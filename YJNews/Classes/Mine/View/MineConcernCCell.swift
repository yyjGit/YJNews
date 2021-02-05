//
//  MineConcernCCell.swift
//  YJNews
//
//  Created by yyj on 2021/2/5.
//

import UIKit
import Kingfisher

class MineConcernCCell: UICollectionViewCell, RegisterCellOrNib  {

    // MARK: - 属性
    private var avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 20.0

        return iv
    }()
    
    private var vipImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "all_v_avatar_18x18_")
        iv.sizeToFit()
        return iv
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    // 新消息
    private var tipsView: UIView = {
        let tv = UIView()
        tv.backgroundColor = UIColor.red
        tv.layer.masksToBounds = true
        tv.layer.cornerRadius = 3.0
        return tv
    }()

    
    // MARK: - 绑定数据
    var concern: MineConcern? {
        didSet {
            avatarImageView.kf.setImage(with: URL(string: concern?.icon ?? ""))
            nameLabel.text = concern?.name
            if let isVerity = concern?.is_verify {
                vipImageView.isHidden = !isVerity
            } else {
                vipImageView.isHidden = true
            }
            
            if let tips = concern?.tips {
                tipsView.isHidden = !tips
            }
        }
    }
    
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(avatarImageView)
        avatarImageView.addSubview(vipImageView)
        avatarImageView.addSubview(tipsView)
        contentView.addSubview(nameLabel)                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()
                
        nameLabel.snp.makeConstraints {
            $0.left.right.equalTo(0)
            $0.height.equalTo(18)
            $0.bottom.equalTo(-2)
        }
        
        avatarImageView.snp.makeConstraints{
            $0.top.equalTo(6)
            $0.centerX.equalTo(contentView)
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        vipImageView.snp.makeConstraints {
            $0.right.bottom.equalTo(0)
        }
        
        tipsView.snp.makeConstraints {
            $0.top.right.equalTo(0)
            $0.width.height.equalTo(6)
        }
    }
}
