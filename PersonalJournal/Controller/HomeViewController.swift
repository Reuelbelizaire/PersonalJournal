//
//  HomeViewController.swift
//  PersonalJournal
//
//  Created by Belizaire, Reuel James on 4/18/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var funnyLabel: UILabel!
    let inspiration=["The more that you read, the more things you will know. The more that you learn, the more places you'll go. - Dr. Seuss", "The reading of all good books is like conversation with the finest (people) of the past centuries. - Descartes","A reader lives a thousand lives before he dies. The man who never reads lives only one. - George R.R. Martin"]
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = "Welcome to the future of your personal bookcase!"
        funnyLabel.isHidden = true
    }
    
    
    @IBAction func funnyPressed(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5) { [self] in
        self.funnyLabel.isHidden.toggle()
        funnyLabel.text = inspiration[Int.random(in: 0...2)]
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
