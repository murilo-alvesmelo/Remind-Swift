//
//  DBHelper.swift
//  Remider
//
//  Created by Murilo Alves on 16/03/26.
//

import Foundation
import SQLite3

class DBHelper {
    static let shared = DBHelper()
    private var db: OpaquePointer?
    
    private init(){
        openDatabase()
        createTable()
    }
    
    private func openDatabase() {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Remider.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
        }
    }
    
    private func createTable() {
        let createTabelQuery = """
        CREATE TABLE IF NOT EXISTS Receipts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            remedy TEXT,
            time TEXT,
            recurrence TEXT,
            takeNow INTEGER
        );
        """
        
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTabelQuery, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Table created")
            } else {
                print("Erro creating table")
            }
        } else {
            print("Erro preparing the statement")
        }
        sqlite3_finalize(statement)
    }
    
    func insertReceipt(remedy: String, time: String, recurrence: String, takeNow: Bool){
        let insertQuery = "INSERT INTO Receipts (remedy, time, recurrence, takeNow) VALUES (?, ?, ?, ?);"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (remedy as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (recurrence as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, (takeNow ? 1 : 0))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Receipt inserted")
            } else {
                print("Erro inserting receipt")
            }
        } else {
            print("Erro preparing the statement")
        }
    }
    
    func deleteReceipt(byId id: Int){
        let deletQuery = "DELETE FROM Receipts WHERE id = ?;"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, deletQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Receipt deleted")
            } else{
                print("Error deleting receipt")
            }
        } else {
            print("Delete statement could not be prepared")
        }
        sqlite3_finalize(statement)
    }
    
    func fetchReceipts() -> [Medicine] {
        let query = "SELECT * FROM Receipts;"
        var statement: OpaquePointer?
        var receipts: [Medicine] = []
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let remedy = sqlite3_column_text(statement, 1).flatMap {String(cString: $0)} ?? "Unknown"
                let time = sqlite3_column_text(statement, 2).flatMap {String(cString: $0)} ?? "Unknown"
                let recurrence = sqlite3_column_text(statement, 3).flatMap {String(cString: $0)} ?? "Unknown"
                
                receipts.append(Medicine(
                                        id: id,
                                        remedy: remedy,
                                        time: time,
                                        recurrence: recurrence
                                ))
                
            }
        } else {
            print("SELECT statement failed")
        }
        
        sqlite3_finalize(statement)
        return receipts
    }
}
