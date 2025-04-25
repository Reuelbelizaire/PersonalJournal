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

    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var authorTextBox: UITextField!
    
    @IBOutlet weak var validatorLabel: UILabel!
    @IBOutlet weak var genreTextBox: UITextField!
    @IBOutlet weak var summaryTextBox: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validatorLabel.text = ""
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addBookPressed(_ sender: UIButton) {
        
        guard let title = titleTextBox.text, !title.isEmpty else {
            validatorLabel.text = "Please enter a valid course ID."
            return
        }
        
        guard let authorName = authorTextBox.text, !authorName.isEmpty else {
            validatorLabel.text = "Please enter a valid course name."
            return
        }
        
        guard let genreType = genreTextBox.text, !genreType.isEmpty else {
            validatorLabel.text = "Please enter a valid course name."
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
                self.validatorLabel.text = "Failed to save course."
                self.validatorLabel.textColor = .systemRed
            } else {
                print("Successfully saved course.")
                self.validatorLabel.text = "Course added successfully!"
                self.validatorLabel.textColor = .systemGreen
                self.clearFields()
            }
        }
    }
    
    
    private func clearFields() {
        titleTextBox.text = ""
        authorTextBox.text = ""
        genreTextBox.text = ""
        summaryTextBox.text = ""
    }
   

}
