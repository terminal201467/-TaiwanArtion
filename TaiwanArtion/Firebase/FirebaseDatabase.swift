//
//  Firebase.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/15.
//

import Firebase
import FirebaseFirestore

class FirebaseDatabase {
    
    private let collectionName: String
    private let db: Firestore
    
    init(collectionName: String) {
        self.collectionName = collectionName
        self.db = Firestore.firestore()
    }
    
    func createDocument(data: [String: Any], completion: @escaping (String?, Error?) -> Void) {
        var documentRef: DocumentReference? = nil
        documentRef = db.collection(collectionName).addDocument(data: data) { error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(documentRef?.documentID, nil)
            }
        }
    }
    
    func readDocument(documentID: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let documentRef = db.collection(collectionName).document(documentID)
        documentRef.getDocument { (document, error) in
            if let document = document, document.exists {
                completion(document.data(), nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func updateDocument(documentID: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        let documentRef = db.collection(collectionName).document(documentID)
        documentRef.updateData(data) { error in
            completion(error)
        }
    }
    
    func deleteDocument(documentID: String, completion: @escaping (Error?) -> Void) {
        let documentRef = db.collection(collectionName).document(documentID)
        documentRef.delete { error in
            completion(error)
        }
    }
    
    func getRandomDocuments(count: Int, completion: @escaping ([[String: Any]]?, Error?) -> Void) {
        db.collection(collectionName).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let documents = querySnapshot?.documents.shuffled().prefix(count)
                let results = documents?.map { $0.data() }
                completion(Array(results ?? []), nil)
            }
        }
    }
    
    func getHotDocument(count: Int, completion: @escaping ([[String: Any]]?, Error?) -> Void) {
        db.collection(collectionName).order(by: "hitRate", descending: true).limit(to: count).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let results = querySnapshot?.documents.map { $0.data() }
                completion(results, nil)
            }
        }
    }
    
    func getRecentDocuments(count: Int, completion: @escaping ([[String: Any]]?, Error?) -> Void) {
        db.collection(collectionName).order(by: "startDate", descending: false).limit(to: count).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let results = querySnapshot?.documents.map { $0.data() }
                completion(results, nil)
            }
        }
    }
    
    func getPopularDocument() {
        
    }
    
    func getHighEvaluationDocument() {
        
    }
    
    //首頁讀取資料的相關function
    func readDocument(habby: String? = nil, month: String? = nil, item: String? = nil, completion: @escaping ([[String: Any]], Error?) -> Void) {
        var query: Query = db.collection(collectionName)
        
        if let habby = habby {
            query = query.whereField("habby", isEqualTo: habby)
        }
        
        if let month = month {
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMMM"
            
            if let date = monthFormatter.date(from: month) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy/MM/dd"
                let dateString = dateFormatter.string(from: date)
                query = query.whereField("startDate", isEqualTo: dateString)
            } else {
                // Invalid month string
                completion([], nil)
                return
            }
        }
        
        if let item = item {
            query = query.whereField("category", isEqualTo: item)
        }
        
        query.getDocuments { (snapshot, error) in
            if let error = error {
                completion([], error)
                return
            }
            
            var documents: [[String: Any]] = []
            
            for document in snapshot?.documents ?? [] {
                documents.append(document.data())
            }
            
            completion(documents, nil)
        }
    }
    
    private func getMonthString(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMMM"
            let monthString = monthFormatter.string(from: date)
            return monthString
        }
        
        return nil
    }

}

