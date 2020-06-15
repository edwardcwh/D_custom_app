//
//  MovieData+CoreDataProperties.swift
//  CDDA
//
//  Created by edwardchong on 25/5/20.
//  Copyright © 2020 edwardchong. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieData> {
        return NSFetchRequest<MovieData>(entityName: "MovieData")
    }

    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var language: String?
    @NSManaged public var imageData: Data?

}
