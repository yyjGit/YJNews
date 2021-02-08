//
//  MineAPIs.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import Foundation

enum MineAPI<RespObj: YJDecodable> {
    case mineCellData(device_id: String) // 我的界面 cell 的数据
    case mineConcernData(device_id: String) // 我关注的数据
}

extension MineAPI: ReqeustConfig {

    // 类型别名
    typealias Response = RespObj
        
    /// 请求路径
    var path: String {
        switch self {
        case .mineCellData:
            return "/user/tab/tabs/?"
        case .mineConcernData:
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
        case .mineCellData(let device_id):
            return ["device_id" : device_id]
        case .mineConcernData(let device_id):
            return ["device_id" : device_id]
        }        
    }
}
