//
//  DataStore.swift
//  CDDA
//
//  Created by edwardchong on 24/5/20.
//  Copyright © 2020 edwardchong. All rights reserved.
//

import Foundation
import UIKit
import CoreData

var list: [NSManagedObject] = []

final class DataStore{
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var movies: [Movie] = []
    var images: [UIImage] = []
    
    func getMovies(completion: @escaping () -> Void){
        APIClient.getMoviesAPI { (json) in
            if let results = json?["results"] as? [MovieJSON]{
                for dict in results {
                    let newMovie = Movie(dictionary: dict)
                    self.movies.append(newMovie)
                }
            }
            completion()
        }
    }
    
    func getMovieImages(completion: @escaping () -> Void){
        getMovies {
            for movie in self.movies {
                let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + movie.coverImage)
                let data = try? Data(contentsOf: imageUrl!)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.images.append(image!)
                }
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
    
    func save(title: String, lang: String, date: String, over: String, image: Data){
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "MovieData", in: managedContext)!
        let movieData = NSManagedObject(entity: entity, insertInto: managedContext)
        
        movieData.setValue(title, forKey: "title")
        movieData.setValue(lang, forKey: "language")
        movieData.setValue(date, forKey: "releaseDate")
        movieData.setValue(over, forKey: "overview")
        movieData.setValue(image, forKey: "imageData")
        do {
            try managedContext.save()
            list.append(movieData)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchrequest = NSFetchRequest<NSManagedObject>(entityName: "MovieData")
        
        do{
            list = try managedContext.fetch(fetchrequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        MyTableViewController().self.refresh()
    }
    
}
