//
//  SysSettingViewController.swift
//  YJNews
//
//  Created by yyj on 2021/2/6.
//

import UIKit

class SysSettingViewController: YJTableViewController {

    
    /// 存储 setting.plist 文件中的数据
    var sections = [[SettingModel]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = HasNaviBarBounds        
        tableView.yj_registerCell(cell: SettingTCell.self)
        loadData()
    }

    
    /// 加载数据
    private func loadData() {
        
        guard let path = Bundle.main.path(forResource: "setting", ofType: "plist"),
              let sectionArray = NSArray(contentsOfFile: path) else {
            print("setting.plist 文件路径不存在")
            return
        }
        
        for section in sectionArray {
            guard let rowArray = section as? [[String : Any]] else { continue }
        
            var rows = [SettingModel]()
            for row in rowArray {
                guard let setting = SettingModel.deserialize(from: row) else { continue }
                rows.append(setting)
            }
            sections.append(rows)
        }
    }
}


// MARK: - tableView  代理、数据源
extension SysSettingViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < sections.count {
            return sections[section].count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.yj_dequeueReusableCell(indexPath: indexPath) as SettingTCell
        if indexPath.section < sections.count && indexPath.row < sections[indexPath.section].count {
            
            cell.setting = sections[indexPath.section][indexPath.row]
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
