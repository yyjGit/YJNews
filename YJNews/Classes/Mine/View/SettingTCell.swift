//
//  SettingTCell.swift
//  YJNews
//
//  Created by yyj on 2021/2/6.
//

import UIKit

class SettingTCell: YJBaseTCell {

    var setting: SettingModel? {
        didSet {
            titleLabel.text = setting?.title
            subTitleLabel.text = setting?.subtitle
            rightTitleLabel.text = setting?.rightTitle
            
            subTitleLabel.isHidden = setting?.isHiddenSubtitle ?? false
            switchBtn.isHidden = setting?.isHiddenSwitch ?? true
            rightArrowsImageView.isHidden = setting?.isHiddenRightArraw ?? true
            
            if !subTitleLabel.isHidden {
                titleLabel.snp.remakeConstraints {
                    $0.left.equalTo(15)
                    $0.top.equalTo(4)
                }
            }
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .red
        return label
    }()
    lazy var rightTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var switchBtn: UISwitch = {
        let sw = UISwitch()
        
        return sw
    }()

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(rightTitleLabel)
        contentView.addSubview(switchBtn)
        
        layoutPageSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layoutPageSubviews() {

        titleLabel.snp.makeConstraints {
            $0.left.equalTo(15)
            $0.centerY.equalTo(contentView)
        }
        subTitleLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel)
            $0.bottom.equalTo(-4)
        }
        rightTitleLabel.snp.makeConstraints {
            $0.right.equalTo(-15)
            $0.centerY.equalTo(contentView)
        }
        switchBtn.snp.makeConstraints {
            $0.right.equalTo(-15)
            $0.centerY.equalTo(contentView)
        }
    }
}

































