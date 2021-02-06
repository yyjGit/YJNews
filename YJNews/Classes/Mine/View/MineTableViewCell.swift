//
//  MineTableViewCell.swift
//  YJNews
//
//  Created by yyj on 2021/2/5.
//

import UIKit
import SnapKit

class MineTableViewCell: YJBaseTCell {

    // MARK: - 属性
    private var leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    private var rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray        
        return label
    }()

    // MARK: - 绑定数据
    var cellModel: MineCellModel? {
        didSet {
            leftLabel.text = cellModel?.text
            rightLabel.text = cellModel?.grey_text
        }
    }
    
    // MARK: - 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        
        leftLabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.cellRightTextColor"        
    }    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        leftLabel.snp.makeConstraints {
            $0.left.equalTo(15)
            $0.centerY.equalTo(contentView)
        }
        
        rightLabel.snp.makeConstraints {
            $0.right.equalTo(rightArrowsImageView.snp.left).offset(-15)
            $0.centerY.equalTo(contentView)
        }
    }
}
