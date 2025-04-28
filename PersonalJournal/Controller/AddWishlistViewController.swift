//
//  WishlistViewController.swift
//  PersonalJournal
//
//  Created by Belizaire, Reuel James on 4/18/25.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class WishlistViewController: UIViewController {
    
    let db = Firestore.firestore()

    struct WishListModel{
        var title:String
        var authorName:String
        var genreType:String
        var description:String
    }
    
    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var authorTextBox: UITextField!
    @IBOutlet weak var genreTextBox: UITextField!
    @IBOutlet weak var summaryTextBox: UITextField!
    
    @IBOutlet weak var validationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validationLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    //adds the necessary information to the wishlist
    @IBAction func addWishlistPressed(_ sender: Any) {
        guard let title = titleTextBox.text, !title.isEmpty else {
            validationLabel.text = "Please enter a valid course ID."
            return
        }
        
        guard let authorName = authorTextBox.text, !authorName.isEmpty else {
            validationLabel.text = "Please enter a valid course name."
            return
        }
        
        guard let genreType = genreTextBox.text, !genreType.isEmpty else {
            validationLabel.text = "Please enter a valid course name."
            return
        }
        guard let description = summaryTextBox.text, !description.isEmpty else {
            validationLabel.text = "Please enter a valid course name."
            return
        }
        
        
        
        let currentUserID = Auth.auth().currentUser?.uid ?? "UnknownUser"
                
        db.collection("WishList").addDocument(data: [
            "BookTitle": title,
            "Author": authorName,
            "genreType": genreType,
            "Description": description,
            "UserID": currentUserID,
            "Date": Date().timeIntervalSince1970
        ]) { error in
            if let e = error {
                print("There was an issue saving course to Firestore: \(e)")
                self.validationLabel.text = "Failed to save course."
                self.validationLabel.textColor = .systemRed
            } else {
                print("Successfully saved course.")
                self.validationLabel.text = "Course added successfully!"
                self.validationLabel.textColor = .systemGreen
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
