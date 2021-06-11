//
//  CollectedNewsTableViewController.swift
//  NewsReader
//
//  Created by mac on 2021/5/21.
//

import UIKit



class CollectedNewsTableViewController: UITableViewController {
    
    
    var newsRecords:[String]?
    var searchController:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initSearch(){
        let resultsConroller = SearchNewsTableViewController()
        resultsConroller.allNews = self.newsRecords!
        searchController = UISearchController(searchResultsController: resultsConroller)
        let searchBar = searchController.searchBar
        searchBar.placeholder = "输入想搜索的新闻"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchController.searchResultsUpdater = resultsConroller
        self.definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        newsRecords = []
        let sql = "SELECT title From news;"
        let sqlite = SQLiteManager.sharedInstance
        if(!sqlite.openDB()){return}
        let data = sqlite.execQuerySQL(sql: sql)
        if(data == nil){
            return
        }
        for row in data!{
            newsRecords?.append(row["title"] as! String)
        }
        tableView.reloadData()
        sqlite.closeDB()
        initSearch()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsRecords!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath)
        cell.textLabel?.text = newsRecords![indexPath.row]
       return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
           return true
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
           return "删除"
       }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
       {
           
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let title = self.newsRecords![indexPath.row]
            let sql = "DELETE FROM news WHERE title='\(title)';"
            let sqlite = SQLiteManager.sharedInstance
            if(!sqlite.openDB()){return}
            if !sqlite.execNoneQuerySQL(sql: sql){
                sqlite.closeDB();return
            }
            
            sqlite.closeDB()
            self.newsRecords!.remove(at: indexPath.row)
            //刷新tableview
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "collectiondetail", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let dest = segue.destination as? CollectionDetailViewController
        {
            let sql = "SELECT title,path,passtime FROM news WHERE title=\(newsRecords![tableView.indexPathForSelectedRow!.row])"
            let sqlite = SQLiteManager.sharedInstance
            if !sqlite.openDB() { return }
            var news:News
            var image:UIImage
            (news,image) = NewsDAL.LoadNews(title: newsRecords![tableView.indexPathForSelectedRow!.row])
            dest.news = news
            dest.image = image
            sqlite.closeDB()
        }
    }
}
