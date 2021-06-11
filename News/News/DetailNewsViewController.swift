//
//  NewsDetailViewController.swift
//  NewsReader
//
//  Created by mac on 2021/5/19.
//

import UIKit
import WebKit

class DetailNewsViewController: UIViewController {
    
    
    var newsURL:URL?
    var news:News?
    var image:UIImage?
    @IBOutlet weak var newsView: WKWebView!
    
    func showMsgbox(_message: String, _title: String = "提示"){
            
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
            let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
            alert.addAction(btnOK)
            self.present(alert, animated: true, completion: nil)
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let req = URLRequest(url: newsURL!)
        newsView.load(req)
        self.view.addSubview(newsView)
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func Collect(_ sender: Any) {
        let url = URL(string: news!.image)
        let data = try? Data(contentsOf: url!)
        image = UIImage(data: data!)
        NewsDAL.saveNews(news: news, image: image)
        
        //添加小红点
        let SaveNews = NewsDAL.GetAllNews() as! Array<Any>
        let nav = tabBarController?.viewControllers?[1] as? UINavigationController
        nav?.tabBarItem.badgeValue = "\(SaveNews.count)"
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
