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
