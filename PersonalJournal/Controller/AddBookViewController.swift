//
//  AddBookViewController.swift
//  PersonalJournal
//
//  Created by Belizaire, Reuel James on 4/18/25.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class AddBookViewController: UIViewController {

    struct BookModel{
        var title:String
        var authorName:String
        var genreType:String
        var description:String
    }

    let db = Firestore.firestore()

    
    @IBOutlet weak var bookTitleLabel: UITextField!
    @IBOutlet weak var bookGenreLabel: UITextField!
    @IBOutlet weak var bookAuthorLabel: UITextField!
    @IBOutlet weak var bookSummary: UITextField!
    
    @IBOutlet weak var popUpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpLabel.text = ""
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addBookPressed(_ sender: UIButton) {
        
        guard let title = bookTitleLabel.text, !title.isEmpty else {
            popUpLabel.text = "Please enter a book title."
            return
        }
        
        guard let authorName = bookAuthorLabel.text, !authorName.isEmpty else {
            popUpLabel.text = "Please enter an author."
            return
        }
        
        guard let genreType = bookGenreLabel.text, !genreType.isEmpty else {
            popUpLabel.text = "Please enter a genre."
            return
        }
        guard let description = bookSummary.text, !description.isEmpty else {
            popUpLabel.text = "Please give us a summary."
            return
        }
        
        let currentUserID = Auth.auth().currentUser?.uid ?? "UnknownUser"

        db.collection("Books").addDocument(data: [
            "title": title,
            "authorName": authorName,
            "genreType": genreType,
            "UserID": currentUserID,
            "description": description,
            "Date": Date().timeIntervalSince1970
        ]) { error in
            if let e = error {
                print("There was an issue saving course to Firestore: \(e)")
                self.popUpLabel.text = "Failed to save book."
                self.popUpLabel.textColor = .systemRed
            } else {
                print("Successfully saved course.")
                self.popUpLabel.text = "Book added successfully!"
                self.popUpLabel.textColor = .systemGreen
                self.clearFields()
            }
        }
    }
    
    
    private func clearFields() {
        bookTitleLabel.text = ""
        bookAuthorLabel.text = ""
        bookGenreLabel.text = ""
        bookSummary.text = ""
    }
}
