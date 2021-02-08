//
//  OfflineDownloadViewController.swift
//  YJNews
//
//  Created by yyj on 2021/2/7.
//

import UIKit

class OfflineDownloadViewController: YJTableViewController {

    // 标题数据
    private var titles: [HomeNewsTitleModel]?
    // 标题数据库表
    private let newsTitletable = NewsTitleTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = CGRect(x: 0, y: navigationBarHeight, width: screenWidth, height: screenHeight - navigationBarHeight)
        tableView.yj_registerCell(cell: OfflineDownloadTCell.self)
        
        loadData()
    }

    private func loadData() {
        
        // 从数据库取出所有数据，赋值给 标题数据
        titles = newsTitletable.selectAll()
        if titles?[1].name == "推荐" {
            titles?.remove(at: 1)
        }
        tableView.reloadData()
    }
}


// MARK: - tableView  代理、数据源
extension OfflineDownloadViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 44 }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 40 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return titles?.count ?? 0 }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.yj_dequeueReusableCell(indexPath: indexPath) as OfflineDownloadTCell
        if indexPath.row < titles?.count ?? 0 {
            cell.model = titles?[indexPath.row]
        }
        return cell
    }
    
            
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if var homeNewsTitle = titles?[indexPath.row] {
            homeNewsTitle.selected = !homeNewsTitle.selected
            let cell = tableView.cellForRow(at: indexPath) as! OfflineDownloadTCell
            
            cell.rightMarkButton.isSelected = homeNewsTitle.selected
            
            titles?[indexPath.row] = homeNewsTitle
            
            newsTitletable.update(homeNewsTitle)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.bounds.width-10, height: view.bounds.height))
        label.text = "我的频道"
        label.textColor = .black
        view.addSubview(label)
        view.backgroundColor = tableView.backgroundColor
        return view
    }
}
