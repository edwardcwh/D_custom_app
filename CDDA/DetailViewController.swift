//
//  DetailViewController.swift
//  CDDA
//
//  Created by edwardchong on 25/5/20.
//  Copyright © 2020 edwardchong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var langLabel:UILabel!
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var overLabel:UILabel!
    
    @IBOutlet var imageView:UIImageView!
    @IBOutlet weak var favouriteBtn: UIButton!
    
    var image = UIImage()
    var name = ""
    var date = ""
    var lang = ""
    var over = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = image
        titleLabel.text = name
        dateLabel.text = date + " release"
        langLabel.text = lang
        overLabel.text = over
    }
    
    @IBAction func FavouriteClicked(_ sender: Any) {
        store.save(title: name, lang: lang, date: date, over: over, image: image.pngData()!)
        store.fetchData()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
