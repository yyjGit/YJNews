//
//  HomeService.swift
//  YJNews
//
//  Created by yyj on 2021/2/7.
//

import Foundation

enum HomeAPI<RespObj: YJDecodable> {
    case newsTitleData(device_id: String, iid: String) // 我的界面 cell 的数据
    case newsTitleData2(device_id: String) // 我关注的数据
}

extension HomeAPI: ReqeustConfig {

    // 类型别名
    typealias Response = RespObj
    
    /// 请求路径
    var path: String {
        switch self {
        case .newsTitleData:
            return "/article/category/get_subscribed/v1/?"
        case .newsTitleData2:
            return "/concern/v2/follow/my_follow/??"
        }
    }
    
    /// 请求方式
    var method: YJHTTPMethod {
        return YJHTTPMethod.GET
    }
        
    /// 请求参数
    var parameter: [String : Any] {
        switch self {
        case .newsTitleData(let device_id, let iid):
            return ["device_id" : device_id, "iid" : iid]
        case .newsTitleData2(let device_id):
            return ["device_id" : device_id]
        }
    }
}
