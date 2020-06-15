//
//  ViewController.swift
//  CDDA
//
//  Created by edwardchong on 22/5/20.
//  Copyright © 2020 edwardchong. All rights reserved.
//

import UIKit
let store = DataStore.sharedInstance

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var tabcontrol: UITabBar!
    @IBOutlet weak var refreshButton: UIButton!
    
    let refreshControl = UIRefreshControl()
    
    @IBAction func refreshApi(_ sender: Any) {
        store.getMovieImages{
            self.collectionview?.reloadData()
        }
        print("Refreshed!")
        collectionview.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        store.getMovieImages{
            self.collectionview?.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        let movie = store.movies[indexPath.row]
        let image = store.images[indexPath.row]
        cell.displayContent(image: image, title: movie.name)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        desVC.image = store.images[indexPath.row]
        let movie = store.movies[indexPath.row]
        desVC.name = movie.name
        desVC.date = movie.date
        desVC.lang = movie.language
        desVC.over = movie.overview
        
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
}

