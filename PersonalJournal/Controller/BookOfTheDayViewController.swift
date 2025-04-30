//
//  BookOfTheDayViewController.swift
//  PersonalJournal
//
//  Created by Belizaire, Reuel James on 4/26/25.
//

import UIKit

class BookOfTheDayViewController: UIViewController {

    //connect to my model
    private let newBook = bookOfTheDay()
    
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookGenreLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showBookOfTheDay()
        // Do any additional setup after loading the view.
    }
    
    func showBookOfTheDay() {
        let RandomBook = newBook.getRandomBook()
        
        bookTitle.text = RandomBook.title
        bookAuthor.text = "by \(RandomBook.authorName)"
        bookImage.image = UIImage(named: RandomBook.imageName)
        bookGenreLabel.text = "genre: \(RandomBook.genreType)"
        bookDescriptionLabel.text = RandomBook.description
    }
    

}
