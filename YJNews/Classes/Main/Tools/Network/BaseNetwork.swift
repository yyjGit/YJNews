//
//  BaseNetwork.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import Foundation
import Alamofire


protocol BaseNetworkProtocol {
        
    /// 发送请求
    /// - Parameters:
    ///   - info: 请求： 参数、路径、方式。。。
    ///   - handler: 回传数据
    func send<T: ReqeustConfig>(byInfoProvider info: T, handler : @escaping (T.Response?) -> Void)
}


class BaseNetwork: BaseNetworkProtocol {

    // 单例方法
    static let manager = BaseNetwork()
    private init() {}

    
    /// 发送请求
    /// - Parameters:
    ///   - r: 提供请求 参数、路径、方式。。。
    ///   - handler: 回传数据
    func send<T: ReqeustConfig>(byInfoProvider info: T, handler: @escaping (T.Response?) -> Void) {

        // 构建参数
        let url = URL(string: info.baseUrl + info.path)!;
        let params = info.parameter
        
        // 发起请求
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                print("请求失败")
                DispatchQueue.main.async { handler(nil) }
                return
            }
            
            // 处理请求结果，回调
            if let value = response.result.value {
                let resp = T.Response.parse(data: value)
                DispatchQueue.main.async {
                    handler(resp)
                }
            } else {
                DispatchQueue.main.async { handler(nil) }
            }
        }
    }
}
