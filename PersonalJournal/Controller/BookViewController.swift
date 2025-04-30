//
//  BookViewController.swift
//  PersonalJournal
//
//  Created by Belizaire, Reuel James on 4/24/25.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth


class BookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    private let cellIdentifier = "BookCell"
    var books: [BookModel] = []
    let db = Firestore.firestore()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //loadBooks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //gets rid of duplicate books
        books = []
        loadBooks()
    }

    func loadBooks() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("No authenticated user.")
            return
        }
        
        
        db.collection("Books")
            .whereField("UserID", isEqualTo: currentUserID)
            .order(by: "Date")
            .getDocuments { (querySnapshot, error) in
                
                if let e = error as NSError? {
                    print("There was an issue retrieving books from Firestore. \(e.localizedDescription)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let title = data["title"] as? String,
                               let authorName = data["authorName"] as? String,
                               let genreType = data["genreType"] as? String,
                               let description = data["description"] as? String {
                                
                                let newBook = BookModel(
                                    title: title,
                                    authorName: authorName,
                                    genreType: genreType,
                                    description: description,
                                    currentUserID: currentUserID
                                )
                                self.books.append(newBook)
                            }
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let book = books[indexPath.row]
        cell.textLabel?.text = "\(book.title) by \(book.authorName)"
        cell.detailTextLabel?.text = book.genreType
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            
            guard let self = self else { return }
            guard let currentUserID = Auth.auth().currentUser?.uid else {
                print("No authenticated user.")
                completionHandler(false)
                return
            }
            
            let bookToDelete = self.books[indexPath.row]
            // deletes from firestone database
            self.db.collection("Books")
                .whereField("title", isEqualTo: bookToDelete.title)
                .whereField("authorName", isEqualTo: bookToDelete.authorName)
                .whereField("UserID", isEqualTo: currentUserID)
                .getDocuments { (snapshot, error) in
                    if let error = error {
                        print("Error finding book to delete: \(error.localizedDescription)")
                        completionHandler(false)
                    } else if let documents = snapshot?.documents, !documents.isEmpty {
                        documents[0].reference.delete { error in
                            if let error = error {
                                print("Error deleting book: \(error.localizedDescription)")
                                completionHandler(false)
                            } else {
                                self.books.remove(at: indexPath.row)
                                tableView.deleteRows(at: [indexPath], with: .automatic)
                                completionHandler(true)
                            }
                        }
                    } else {
                        print("No matching document found to delete")
                        completionHandler(false)
                    }
                }
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "MyBookViewController") as? MyBookViewController {
          detailVC.Book = selectedBook
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
