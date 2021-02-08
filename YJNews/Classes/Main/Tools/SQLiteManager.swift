//
//  SQLiteManager.swift
//  YJNews
//
//  Created by yyj on 2021/2/7.
//

import Foundation
import SQLite

struct SQLiteManager {
    var  database: Connection!
    init() {
        do {
            let path = NSHomeDirectory() + "/Documents/news.sqlite3"
            database = try Connection(path)
        } catch {
            print("error \(error)")
        }
    }
}


/// 首页新闻分类的标题数据表
struct NewsTitleTable {
    
    
    /// 数据库管理制度
    private let sqlManager = SQLiteManager()
        
    /// 新闻标题 表
    private let news_title = Table("news_title")
    
    /// 表字段
    let id = Expression<Int64>("id")
    let category = Expression<String>("category")
    let web_url = Expression<String>("web_url")
    let flags = Expression<Int64>("flags")
    let name = Expression<String>("name")
    let tip_new = Expression<Int64>("tip_new")
    let concern_id = Expression<String>("concern_id")
    let type = Expression<Int64>("type")
    let icon_url = Expression<String>("icon_url")
    let selected = Expression<Bool>("selected")
    

    init() {
        do {
            // 建表
            try sqlManager.database.run(news_title.create(ifNotExists: true, block: { (t) in
                t.column(id, primaryKey: true)
                t.column(category)
                t.column(web_url)
                t.column(flags)
                t.column(name)
                t.column(tip_new)
                t.column(concern_id)
                t.column(type)
                t.column(icon_url)
                t.column(selected)
            }))
        } catch {
            print("error \(error)")
        }
    }

    
    /// 插入一组数据
    func insert(_ titles: [HomeNewsTitleModel]) {
        // 遍历插入
        for title in titles {
            insert(title)
        }
    }
    
    // 插入一条数据
    func insert(_ title: HomeNewsTitleModel) {
        // 数据库中不存在该数据才插入
        if !exist(title) {        
            let insert = news_title.insert(category <- title.category, tip_new <- Int64(title.tip_new), concern_id <- title.concern_id, web_url <- title.web_url, icon_url <- title.icon_url, flags <- Int64(title.flags), type <- Int64(title.type), name <- title.name, selected <- title.selected)
            
            do {
                try sqlManager.database.run(insert)
            } catch  {
                print(error)
            }
        }
    }
    
    // 判断数据控，某一条数据是否存在
    func exist(_ title: HomeNewsTitleModel) -> Bool {

        let title = news_title.filter(category == title.category)
        do {
            // 判断该条数据是否存在，没有直接方法
            // 可以根据 count 是否是 0 来判断是否存在该条数据，0 表示没有，1 表示有
            let count = try sqlManager.database.scalar(title.count)
            return count != 0
        } catch {
            print(error)
        }
        return false
    }
    
    
    // 查询所有数据
    func selectAll() -> [HomeNewsTitleModel] {
        var allTitles = [HomeNewsTitleModel]()
        
        do {
            // 遍历表中数据
            for title in try sqlManager.database.prepare(news_title) {
                // 取出表中数据，并初始化为一个结构体模型
                let newsTitle = HomeNewsTitleModel(category: title[category], web_url: title[web_url], flags: Int(title[flags]), name: title[name], tip_new: Int(title[tip_new]), concern_id: title[concern_id], type: Int(title[type]), icon_url: title[icon_url], selected: title[selected])
                // 添加到数组中
                allTitles.append(newsTitle)
            }
            return allTitles
        } catch {
            print(error)
        }
        return []
    }
    
    // 更新数据
    func update(_ newsTitle: HomeNewsTitleModel) {
        
        do {
            let title = news_title.filter(category == newsTitle.category)
            try sqlManager.database.run(title.update(selected <- newsTitle.selected))
        } catch {
            print(error)
        }
    }
}
































