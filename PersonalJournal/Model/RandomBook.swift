//
//  ArrayModel.swift
//  PersonalJournal
//
//  Created by Belizaire, Reuel James on 4/25/25.
//

import Foundation

struct BookOfTheDay{
    var title:String
    var authorName:String
    var genreType:String
    var description:String
    var imageName:String
}

//dictionary
class bookOfTheDay{
    private let RandomBook = [
    BookOfTheDay(
        title:"Adventures of Huckleberry Finn",
        authorName:"Mark Twain",
        genreType:"Adventure fiction",
        description:"Huck Finn, the protagonist, escapes his abusive and drunken father and runs away with a slave named Jim and the two have many adventures on a raft on the Mississippi River",
        imageName: "Finn"
    ),
    BookOfTheDay(
        title:"The Boy in the Striped Pyjamas",
        authorName:"John Boyne",
        genreType:"Historical Fiction",
        description:"tells the story of Bruno, a young boy whose family moves from Berlin to a desolate area near a concentration camp, Auschwitz, after his father is appointed commandant",
        imageName: "pajama"
    ),
    BookOfTheDay(
        title:"The Immortal Life of Henrietta Lacks",
        authorName:"Rebecca Skloot",
        genreType:"Biography",
        description:"tells the story of Henrietta Lacks, an African American woman whose cells, taken without her knowledge, became the first human cell line to grow indefinitely in a lab, HeLa cells.",
        imageName: "lacks"
    ),
    BookOfTheDay(
        title:"The Maid's Secret",
        authorName:"Nita Prose",
        genreType:"Suspense & Thriller",
        description:"When Molly brings in some old trinkets to be appraised on the show, one item is revealed to be a rare and coveted artifact worth millions. Molly becomes a rags-to-riches sensation, and a media frenzy swirls as she prepares to sell her priceless treasure. Then, on auction day, the treasure suddenly vanishes. and Molly and her friends find themselves at the center of the boldest art heist in recent memory.",
        imageName: "Maid"
    ),
    BookOfTheDay(
        title:"The Ways of White Folks",
        authorName:"Langston Hughes",
        genreType:"Historical fiction",
        description:"A collection of vibrant and incisive short stories depicting the sometimes humorous, but more often tragic interactions between Black people and white people in America in the 1920s and ‘30s.",
        imageName: "ways"
    ),
    BookOfTheDay(
        title:"Stone Yard Devotional",
        authorName:"Charlotte Wood",
        genreType:"Women's fiction",
        description:"Burnt out and in need of retreat, a middle-aged woman leaves Sydney to return to the place she grew up, taking refuge in a small religious community hidden away on the stark plains of rural Australia. She doesn’t believe in God, or know what prayer is, and finds herself living this strange, reclusive existence almost by accident.",
        imageName: "yard"
    ),
    //*add more b
    ]
    
    //randomizes what books are present to give the effect of book of the day but
    func getRandomBook() -> BookOfTheDay {
            let randomIndex = Int.random(in: 0..<RandomBook.count)
            return RandomBook[randomIndex]
        }
}
