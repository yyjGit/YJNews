//
//  YJMineViewController.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import UIKit

class YJMineViewController: YJTableViewController {

    var sections: [[MineCellModel]]?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(MineTableViewCell.self, forCellReuseIdentifier: String(describing: MineTableViewCell.self))
        // 加载 cell 数据
        let provider = MineAPI.mineCellData(device_id: device_id)
        BaseNetwork.manager.send(byInfoProvider: provider) { (result) in
            self.sections = result?.mineCellModelArray
            self.tableView.reloadData()
        }
    }
}

extension YJMineViewController {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        view.backgroundColor = UIColor.defaultBackgroundColor
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections?[section].count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MineTableViewCell(style: .default, reuseIdentifier: String(describing: MineTableViewCell.self))
        cell.textLabel?.text = sections?[indexPath.section][indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
