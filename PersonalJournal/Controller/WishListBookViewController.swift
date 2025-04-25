//
//  WishlListBookViewController.swift
//  PersonalJournal
//
//  Created by Belizaire, Reuel James on 4/24/25.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class WishlistBookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "WishlistBookCell"
    var wishlistBooks: [WishListModel] = []
    let db = Firestore.firestore()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadWishlistBooks()
    }
        override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                loadWishlistBooks()
            }

            func loadWishlistBooks() {
                guard let currentUserID = Auth.auth().currentUser?.uid else {
                    print("No authenticated user.")
                    return
                }
                
                wishlistBooks.removeAll()
                
                db.collection("WishlistBooks")
                    .whereField("UserID", isEqualTo: currentUserID)
                    .order(by: "Date")
                    .getDocuments { (querySnapshot, error) in
                        
                        if let e = error as NSError? {
                            print("There was an issue retrieving wishlist books from Firestore. \(e.localizedDescription)")
                        } else {
                            if let snapshotDocuments = querySnapshot?.documents {
                                for doc in snapshotDocuments {
                                    let data = doc.data()
                                    if let title = data["title"] as? String,
                                       let authorName = data["authorName"] as? String,
                                       let genreType = data["genreType"] as? String,
                                       let description = data["description"] as? String {
                                        
                                        let newWishlistBook = WishListModel(
                                            title: title,
                                            authorName: authorName,
                                            genreType: genreType,
                                            description: description,
                                            currentUserID: currentUserID
                                        )
                                        self.wishlistBooks.append(newWishlistBook)
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
                return wishlistBooks.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                let wishlistBook = wishlistBooks[indexPath.row]
                cell.textLabel?.text = "\(wishlistBook.title) by \(wishlistBook.authorName)"
                cell.detailTextLabel?.text = wishlistBook.genreType
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
                    
                    let bookToDelete = self.wishlistBooks[indexPath.row]
                    
                    self.db.collection("WishlistBooks")
                        .whereField("title", isEqualTo: bookToDelete.title)
                        .whereField("authorName", isEqualTo: bookToDelete.authorName)
                        .whereField("UserID", isEqualTo: currentUserID)
                        .getDocuments { (snapshot, error) in
                            if let error = error {
                                print("Error finding wishlist book to delete: \(error.localizedDescription)")
                                completionHandler(false)
                            } else if let documents = snapshot?.documents, !documents.isEmpty {
                                documents[0].reference.delete { error in
                                    if let error = error {
                                        print("Error deleting wishlist book: \(error.localizedDescription)")
                                        completionHandler(false)
                                    } else {
                                        self.wishlistBooks.remove(at: indexPath.row)
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
                let selectedWishlistBook = wishlistBooks[indexPath.row]
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detailVC = storyboard.instantiateViewController(withIdentifier: "MyWishlistBookViewController") as? MyWishlistBookViewController {
                    detailVC.WishlistBook = selectedWishlistBook
                    navigationController?.pushViewController(detailVC, animated: true)
                }
            }
        }
        }
    
