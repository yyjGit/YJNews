//
//  OfflineDownloadTCell.swift
//  YJNews
//
//  Created by yyj on 2021/2/7.
//

import UIKit

class OfflineDownloadTCell: YJBaseTCell {

    lazy var rightMarkButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "air_download_option_20x20_"), for: .normal)
        btn.setImage(UIImage(named: "air_download_option_press_20x20_"), for: .selected)
        return btn
    }()
    
    var model: HomeNewsTitleModel? {
        didSet {
            textLabel?.text = model?.name
            rightMarkButton.isSelected = model!.selected
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(rightMarkButton)
        layputPageSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layputPageSubviews() {
        rightMarkButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.right.equalTo(-15)
        }
    }
}
