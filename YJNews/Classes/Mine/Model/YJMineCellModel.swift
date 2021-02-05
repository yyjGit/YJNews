//
//  YJMineCellModel.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import Foundation
import HandyJSON
import SwiftyJSON

struct MineViewModel{
    var mineCellModelArray: [[MineCellModel]]?
}

extension MineViewModel: YJDecodable {
    static func parse(data: Any) -> MineViewModel? {

        let json = JSON(data)
        // 请求是否成功
        guard json["message"] == "success" else {
            print("---- 数据解析: message != success")
            return nil
        }

        // 解析数据
        if let data = json["data"].dictionary {
            
            // 读取 sections
            if let sections = data["sections"]?.array {
                
                var sectionArray = [[MineCellModel]]()
                // 遍历 sections：[arr, arr, arr]
                for item in sections {
                    
                    var rows = [MineCellModel]()
                    // 遍历 sections 中元素
                    for row in item.arrayObject! {
                        // 使用 HandyJSON 将字典，反序列为 Model，添加导数据
                        if let cellModel = MineCellModel.deserialize(from: row as? NSDictionary) {
                            rows.append(cellModel)
                        }
                    }
                    //
                    sectionArray.append(rows)
                }

                // 定自定义一个关注数据
                let jsonStr = "{\"text\":\"我的关注\",\"grey_text\":\"\"}"
                if let concern = MineCellModel.deserialize(from: jsonStr) {
                    sectionArray.insert([concern], at: 0)
                }
                
                let model = MineViewModel(mineCellModelArray: sectionArray)
                return model
                
            } else {
                print("---- 数据解析: sections 为空")                
            }
        } else {
            print("---- 数据解析: data 为空")
        }
        return nil
    }
}

/// cell模型
struct MineCellModel: HandyJSON {
    var grey_text: String = ""
    var text: String = ""
    var url: String = ""
    var key: String = ""
    var tip_new: Int = 0
}

/// 我的关注
struct MineConcern: HandyJSON {
            
    var name: String = ""
    var url: String = ""
    var total_count: Int = 0
    var description: String = ""
    var time: String = ""
    var type: String = ""
    var icon: String = ""
    var userid: Int = 0
    var is_verify: Bool = false
    var media_id: Int = 0
    var tips: Bool = false
    var id: Int = 0
    var user_auth_info = UserAuthInfo()
}


struct UserAuthInfo: HandyJSON {
    var auth_type: Int?
    var auth_info: String?
}

