//
//  CollectionViewCell.swift
//  CDDA
//
//  Created by edwardchong on 24/5/20.
//  Copyright © 2020 edwardchong. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieLabel: UILabel!
    
    func displayContent(image: UIImage, title: String){
        movieImage.image = image
        movieLabel.text = title
    }
}
