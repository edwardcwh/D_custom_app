//
//  Movie.swift
//  CDDA
//
//  Created by edwardchong on 24/5/20.
//  Copyright © 2020 edwardchong. All rights reserved.
//

import Foundation

struct Movie {
    let name: String
    let date: String
    let coverImage: String
    let overview: String
    let language: String
    
    init(dictionary: MovieJSON){
        self.name = dictionary["title"] as! String
        self.date = dictionary["release_date"] as! String
        self.coverImage = dictionary["poster_path"] as! String
        self.overview = dictionary["overview"] as! String
        self.language = dictionary["original_language"] as! String
    }
}
