//
//  CollectionDetailViewController.swift
//  NewsReader
//
//  Created by mac on 2021/5/21.
//

import UIKit

class CollectionDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var NewsTitle: UILabel!
    @IBOutlet weak var Path: UILabel!
    @IBOutlet weak var Date: UILabel!
    var news:News?
    var image:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = image
        self.NewsTitle.text = news!.title
        self.Path.text = news!.path
        self.Date.text = news!.passtime
        // Do any additional setup after loading the view.
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
