//
//  YJTableViewController.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import UIKit

class YJTableViewController: YJBaseViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.defaultBackgroundColor
        tableView.separatorStyle = .none
        
        // iOS11适配tableView顶部空白
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // 取消自动缩进 - 如果隐藏了导航栏，会缩进 20 个点
            automaticallyAdjustsScrollViewInsets = false
        }

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
    }
}

extension YJTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
