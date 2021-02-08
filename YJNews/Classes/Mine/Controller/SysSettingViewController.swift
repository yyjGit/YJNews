//
//  SysSettingViewController.swift
//  YJNews
//
//  Created by yyj on 2021/2/6.
//

import UIKit
import Kingfisher

class SysSettingViewController: YJTableViewController {
    
    /// 存储 setting.plist 文件中的数据
    private var sections = [[SettingModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = HasNaviBarBounds        
        tableView.yj_registerCell(cell: SettingTCell.self)
        loadData()
    }

    
    /// 加载数据
    private func loadData() {
        guard let path = Bundle.main.path(forResource: "setting", ofType: "plist"),
              let sectionArray = NSArray(contentsOfFile: path) as? [[[String : Any]]] else {
            print("setting.plist 文件路径不存在")
            return
        }
        
        sections = sectionArray.map { (array) in
            return array.map { (dict) in
                return SettingModel.deserialize(from: dict)!
            }
        }
    }
}


// MARK: - tableView  代理、数据源
extension SysSettingViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int { return sections.count }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 44 }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 10 }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section < sections.count ? sections[section].count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.yj_dequeueReusableCell(indexPath: indexPath) as SettingTCell

        if indexPath.section < sections.count && indexPath.row < sections[indexPath.section].count {
            cell.setting = sections[indexPath.section][indexPath.row]

            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0: // 计算缓存大小
                    calculateDiskCacheSize(cell)
                default:
                    print("")
                }
            default:
                print("")
            }
        }
        return cell
    }
    
            
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingTCell else { return }
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: // 清理缓存
                showCleaerCacheAlertController(cell)
            case 1: // 字体大小
                showSetFontAlertConrtoller(cell)
            case 3: // 非 WiFi 网络流量
                showNotWiFiAlertConrtoller(cell)
            case 4: // 非 Wifi 网络播放提醒
                showNotWiFiPlayRemindAlertConrtoller(cell)
            default:
                print("")
            }
        case 1:
            switch indexPath.row {
            case 0:
                let vc = OfflineDownloadViewController()
                vc.navigationItem.title = "离线下载"
                navigationController?.pushViewController(vc, animated: true)
            default:
                print("")
            }
        default:
            print("")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        return view
    }
}



// MARK: - 事件处理
private extension SysSettingViewController {
    
    // MARK: - 非 Wifi 网络 播放提醒
    func showNotWiFiPlayRemindAlertConrtoller(_ cell: SettingTCell) {
        let alertVc = UIAlertController(title: "非Wi-Fi网络播放提醒", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let everyTimeAction = UIAlertAction(title: "每次提醒", style: .default) {_ in cell.rightTitleLabel.text =  "每次提醒" }
        let onceAction = UIAlertAction(title: "提醒一次", style: .default) {_ in cell.rightTitleLabel.text =  "提醒一次" }
        alertVc.addAction(cancelAction)
        alertVc.addAction(everyTimeAction)
        alertVc.addAction(onceAction)
        present(alertVc, animated: true, completion: nil)
    }
    
    // MARK: - 非 Wifi 网络流量
    func showNotWiFiAlertConrtoller(_ cell: SettingTCell) {
        let alertVc = UIAlertController(title: "非Wi-Fi网络流量", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let bestAction = UIAlertAction(title: "最佳效果（下载大图）", style: .default) {_ in cell.rightTitleLabel.text = "最佳效果（下载大图）"}
        let betterAction = UIAlertAction(title: "较省流量（智能下图）", style: .default) {_ in cell.rightTitleLabel.text = "较省流量（智能下图）"}
        let leastAction = UIAlertAction(title: "极省流量（不下载图）", style: .default) {_ in cell.rightTitleLabel.text = "极省流量（不下载图）"}
        alertVc.addAction(cancelAction)
        alertVc.addAction(bestAction)
        alertVc.addAction(betterAction)
        alertVc.addAction(leastAction)
        present(alertVc, animated: true, completion: nil)
    }
    
    // MARK: - 设置字体大小
    func showSetFontAlertConrtoller(_ cell: SettingTCell) {
        let alertVc = UIAlertController(title: "设置字体大小", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let smallAction = UIAlertAction(title: "小", style: .default) { _ in cell.rightTitleLabel.text = "小"  }
        let middleAction = UIAlertAction(title: "中", style: .default) {_ in cell.rightTitleLabel.text = "中" }
        let bigAction = UIAlertAction(title: "大", style: .default) {_ in cell.rightTitleLabel.text = "大" }
        let largeAction = UIAlertAction(title: "特大", style: .default) {_ in cell.rightTitleLabel.text = "特大" }
        alertVc.addAction(cancelAction)
        alertVc.addAction(smallAction)
        alertVc.addAction(middleAction)
        alertVc.addAction(bigAction)
        alertVc.addAction(largeAction)
        present(alertVc, animated: true, completion: nil)
    }
    
    // MARK: - 计算、清除缓存
    /// 计算缓存
    func calculateDiskCacheSize(_ cell: SettingTCell) {
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskCacheSize { (size) in
            let sizeM = Double(size) / 1024.0 / 1024.0
            
            let cacheSize = sizeM > 0.0 ? String(format: "%.2fM", sizeM) : "0.0M"
            cell.rightTitleLabel.text = cacheSize
        }
    }
        
    /// 清除缓存
    func showCleaerCacheAlertController(_ cell: SettingTCell) {
        let alertVc = UIAlertController(title: "确定清除所有缓存？问打草稿、离线下载及图片均会被清除", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default) {_ in
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            cache.cleanExpiredDiskCache()
            // 重新计算
            self.calculateDiskCacheSize(cell)
        }
        alertVc.addAction(cancelAction)
        alertVc.addAction(okAction)
        present(alertVc, animated: true, completion: nil)
    }
}


























