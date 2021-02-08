//
//  HomeNewsTitleModel.swift
//  YJNews
//
//  Created by yyj on 2021/2/7.
//

import Foundation
import HandyJSON
import HandyJSON



/// 新闻标题 Model
struct HomeNewsTitleModel: HandyJSON {
    var category: String = ""
    var web_url: String = ""
    var flags: Int = 0
    var name: String = ""
    var tip_new: Int = 0
    var concern_id: String = ""
    var type: Int = 0
    var icon_url: String = ""
    var selected: Bool = true
}

/// 对标题 bar 数据的封装
struct NewsTitleBarViewModel {
    var titleModelArray: [HomeNewsTitleModel]?    
}

extension NewsTitleBarViewModel : YJDecodable {
    static func parse(data: Any) -> NewsTitleBarViewModel? {

        let titles = ["推荐", "热点", "北京", "视频", "头条号", "社会", "图片", "娱乐", "科技", "汽车", "财经", "军事", "体育", "段子", "美女", "国际", "趣图", "健康", "特卖", "房产",]
        
        var mdArray = [HomeNewsTitleModel]()
        for str in titles {
            
            var md = HomeNewsTitleModel()
            md.category = str
            md.name = str
            mdArray.append(md)
        }
        
        var model = NewsTitleBarViewModel()
        model.titleModelArray = mdArray
        return model
    }
}


