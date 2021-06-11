import Foundation

import UIKit
class NewsDAL{
    static func initDB(){
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() { return }
        let createSql = "CREATE TABLE IF NOT EXISTS news(" + "'title' TEXT NOT NULL PRIMARY KEY, 'path' TEXT, 'passtime' TEXT, 'image' BLOB);"
        if !sqlite.execNoneQuerySQL(sql: createSql)
        {
            sqlite.closeDB();return
        }
        
        sqlite.closeDB()
    }
    
    static func saveNews(news:News?, image:UIImage?){
        if news == nil { return }
        
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() { return }
        
        var sql = "Insert Into news (title, path, passtime) Values('\(news!.title)', '\(news!.path)', '\(news!.passtime)');"
        if !sqlite.execNoneQuerySQL(sql: sql){
            sqlite.closeDB();return
        }
        
        sql = "UPDATE news SET image = ? WHERE title = '\(news!.title)';"
        
        let data = image!.jpegData(compressionQuality: 1.0) as NSData?
        sqlite.execSavaBlob(sql: sql, blob: data!)
        sqlite.closeDB()
        return
    }
    
    static func LoadNews(title:String) -> (News, UIImage)
    {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() { return (News(title: ""), UIImage(named: "nopic")!) }
        
        var sql = "SELECT title, path, passtime FROM news WHERE title = '\(title)';"
        let news_raw = sqlite.execQuerySQL(sql: sql)
        sql = "SELECT image from news WHERE title = '\(title)';"
        let data = sqlite.execLoadBlob(sql: sql)
        sqlite.closeDB()
        var news = News(title: "")
        
        if data != nil && news != nil
        {
            news.title = news_raw?[0]["title"] as! String
            news.path = news_raw?[0]["path"] as! String
            news.passtime = news_raw?[0]["passtime"] as! String
            return (news, UIImage(data: data!)!)
        }
        else
        {
            return (news, UIImage(named: "nopic")!)
        }
    }
    
    static func GetAllNews()->AnyObject
    {
        var myArray:Array<Any> = []
        let sqlite = SQLiteManager.sharedInstance
        
        if !sqlite.openDB(){return true as AnyObject}
        
        let queryResult = sqlite.execQuerySQL(sql:"SELECT * FROM news")
        
        return(queryResult) as AnyObject
    }
}
