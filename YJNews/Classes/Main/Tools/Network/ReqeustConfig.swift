//
//  ReqeustConfig.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import Foundation

/// 请求方式
enum YJHTTPMethod: String {
    case GET
    case POST
}


/// 请求配置协议
protocol ReqeustConfig {
    /// 主机地址
    var baseUrl: String { get }
    /// 请求路径
    var path: String { get }
    /// 请求方式
    var method: YJHTTPMethod { get }
    /// 参数
    var parameter: [String : Any] { get }

    /// 关联类型 - 响应的数据
    associatedtype Response: YJDecodable
}

extension ReqeustConfig {
    var baseUrl: String {
        return BASE_URL
    }
}

/// 解析数据协议
protocol YJDecodable {
    static func parse(data: Any) -> Self?
}
