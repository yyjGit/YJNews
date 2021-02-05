//
//  YJMineViewController.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import UIKit

class YJMineViewController: YJTableViewController {
        
    /// sections 数据
    var sections: [[MineCellModel]]?
    /// 我的关注
    var concerns: [MineConcern]?
    
    /// 没登录是的 头视图
    lazy var noLoginHeaderView: MineNoLoginHeaderView = {
        let header = MineNoLoginHeaderView.header()
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 注册 cell
        tableView.yj_registerCell(cell: MineTableViewCell.self)
        tableView.yj_registerCell(cell: MineConcernTCell.self)

        tableView.tableHeaderView = noLoginHeaderView
        
        // 加载数据
        loadCellsData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - 加载数据
private extension YJMineViewController {

    // 加载 cell 数据
    func loadCellsData() {
        
        let provider = MineAPI<MineViewModel>.mineCellData(device_id: device_id)
        BaseNetwork.manager.send(byInfoProvider: provider) { (result) in
            self.sections = result?.mineCellModelArray
            self.tableView.reloadData()
            // 加载关注数据
            self.loadConcernsData()
        }
    }
    
    /// 加载关注数据
    func loadConcernsData()  {
        
        let provider = MineAPI<MineConcernCellModel>.mineConcernData(device_id: device_id)
        BaseNetwork.manager.send(byInfoProvider: provider) { (result) in
            // 加载关注数据
            self.concerns = result?.concernArray
            let indexSet = IndexSet(integer: 0)
            self.tableView.reloadSections(indexSet, with: .automatic)            
        }
    }
}

// MARK: - tableView 代理、数据源
extension YJMineViewController {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return (concerns?.count ?? 0) > 1 ? 114 : 44
        }
        return 44
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
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.yj_dequeueReusableCell(indexPath: indexPath) as MineConcernTCell
            if indexPath.section < (sections?.count ?? 0) && indexPath.row < (sections?[indexPath.section].count ?? 0) {
                cell.cellModel = sections?[indexPath.section][indexPath.row]
                cell.concerns = concerns ?? []
            }
            return cell
        }
        
        
        let cell = tableView.yj_dequeueReusableCell(indexPath: indexPath) as MineTableViewCell
        if indexPath.section < (sections?.count ?? 0) && indexPath.row < (sections?[indexPath.section].count ?? 0) {
            cell.cellModel = sections?[indexPath.section][indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            let totalOffset = MineNoLoginHeaderView.height + abs(offsetY)
            let f = totalOffset / MineNoLoginHeaderView.height
            noLoginHeaderView.bgImageView.frame = CGRect(x: -screenWidth * (f - 1) * 0.5, y: offsetY, width: screenWidth * f, height: totalOffset)
        }
    }
}





























