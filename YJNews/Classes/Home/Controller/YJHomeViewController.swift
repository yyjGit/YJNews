//
//  YJHomeViewController.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import UIKit

class YJHomeViewController: YJBaseViewController {

    // 标题数据库表
    private let newsTitletable = NewsTitleTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    private func loadData() {
        let provider = HomeAPI<NewsTitleBarViewModel>.newsTitleData(device_id: device_id, iid: IID)
        BaseNetwork.manager.send(byInfoProvider: provider) { (result) in                        
            if let arr = result?.titleModelArray {
                self.newsTitletable.insert(arr)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
