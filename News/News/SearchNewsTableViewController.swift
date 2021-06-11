import UIKit

class SearchNewsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var allNews:[String] = []
    var filterNews:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "collectionCell")
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {return}
        if searchString.isEmpty {return}
        
        switch searchController.searchBar.selectedScopeButtonIndex {
        case 0:
            filterNews = allNews.filter {(news) -> Bool in
                return news.contains(searchString)
            }
        default:
            return
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterNews.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath)

        cell.textLabel?.text = filterNews[indexPath.row]

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let detailVC = mainStoryboard.instantiateViewController(withIdentifier: "vcDetail") as! CollectionDetailViewController
        let nav = self.presentingViewController?.navigationController
        let sql = "SELECT title,path,passtime FROM news WHERE title=\(filterNews[tableView.indexPathForSelectedRow!.row])"
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() { return }
        var news:News
        var image:UIImage
        (news,image) = NewsDAL.LoadNews(title: filterNews[tableView.indexPathForSelectedRow!.row])
        detailVC.news = news
        detailVC.image = image
        sqlite.closeDB()
        nav?.pushViewController(detailVC, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
