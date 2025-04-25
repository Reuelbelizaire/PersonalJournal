//
//  MyWishlistViewController.swift
//  PersonalJournal
//
//  Created by Belizaire, Reuel James on 4/24/25.
//

import UIKit

class MyWishlistViewController: UIViewController {

    var Wishlist:WishListModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let Wishlist = Wishlist {
            titleLabel.text = Wishlist.title
            genreLabel.text = Wishlist.genreType
            authorLabel.text = Wishlist.authorName
            summaryLabel.text = Wishlist.description
        }
        // Do any additional setup after loading the view.
    }
    

    /*

      
    */

}
