//
//  MineAPIs.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import Foundation

enum MineAPI {
    case mineCellData(device_id: String) // 我的界面 cell 的数据
    case mineConcernData(device_id: String) // 我关注的数据
}


extension MineAPI: ReqeustConfig {

    typealias Response = MineViewModel
    
    /// 主机地址
    var baseUrl: String {
        return BASE_URL
    }
    
    /// 请求路径
    var path: String {
        switch self {
        case .mineCellData:
            typealias Response = MineViewModel
            return "/user/tab/tabs/?"
        case .mineConcernData:
            typealias Response = MineViewModel
            return "123"
        }
    }
    
    /// 请求方式
    var method: YJHTTPMethod {
        return YJHTTPMethod.GET
    }
        
    /// 请求参数
    var parameter: [String : Any] {
        switch self {
        case .mineCellData:
            return ["device_id" : device_id]
        case .mineConcernData:
            return [:]
        }
    }
}
