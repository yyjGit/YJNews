//
//  YJBaseTCell.swift
//  YJNews
//
//  Created by yyj on 2021/2/5.
//

import UIKit
import SnapKit

class YJBaseTCell: UITableViewCell, RegisterCellOrNib {
    
    var rightArrowsImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "setting_rightarrow_8x14_")
        iv.sizeToFit()
        return iv
    }()
    
    var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        return view
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(rightArrowsImageView)
        contentView.addSubview(separatorView)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(rightArrowsImageView)
        contentView.addSubview(separatorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        rightArrowsImageView.snp.makeConstraints {
            $0.right.equalTo(-15)
            $0.centerY.equalTo(contentView)
        }
        
        separatorView.snp.makeConstraints {
            $0.left.equalTo(15)
            $0.right.equalTo(-15)
            $0.bottom.equalTo(contentView)
            $0.height.equalTo(0.8)
        }
    }
}
