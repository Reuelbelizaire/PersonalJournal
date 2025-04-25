//
//  MyBookViewController.swift
//  PersonalJournal
//
//  Created by Belizaire, Reuel James on 4/18/25.
//

import UIKit

class MyBookViewController: UIViewController {

    var Book: BookModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let Book = Book {
            titleLabel.text = Book.title
            genreLabel.text = Book.genreType
            authorLabel.text = Book.authorName
            summaryLabel.text = Book.description
        }
        // Do any additional setup after loading the view.
    }
    
    /*
     db.collection("Books").addDocument(data: [
         "title": title,
         "authorName": authorName,
         "genreType": genreType,
         "UserID": currentUserID,
         "description": description,
         "Date": Date().timeIntervalSince1970
     */
    
   

}
