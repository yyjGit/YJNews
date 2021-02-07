//
//  MineConcernTCell.swift
//  YJNews
//
//  Created by yyj on 2021/2/5.
//

import UIKit

/// 我的关注 cell
class MineConcernTCell: YJBaseTCell {

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

    private var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: MineConcernFlowLayout())
        cv.yj_registerCell(cell: MineConcernCCell.self)
        cv.backgroundColor = UIColor.white
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
            
    
    // MARK: - 绑定数据
    var cellModel: MineCellModel? {
        didSet {
            leftLabel.text = cellModel?.text
            rightLabel.text = cellModel?.grey_text
        }
    }
    
    var concerns: [MineConcern]? {
        didSet {
            collectionView.reloadData()
        }
    }
        
    
    // MARK: - 初始化方法
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.bringSubviewToFront(separatorView)
        
        leftLabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.cellRightTextColor"
        collectionView.theme_backgroundColor = "colors.cellBackgroundColor"        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()
                        
        leftLabel.snp.makeConstraints {
            $0.left.equalTo(15)
            $0.height.equalTo(44)
            $0.top.equalTo(0)
        }
        rightArrowsImageView.snp.remakeConstraints {
            $0.right.equalTo(-15)
            $0.centerY.equalTo(leftLabel)
        }        
        rightLabel.snp.makeConstraints {
            $0.right.equalTo(rightArrowsImageView.snp.left).offset(-15)
            $0.centerY.equalTo(contentView)
        }
        
        collectionView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(contentView)
            $0.top.equalTo(leftLabel.snp.bottom)
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MineConcernTCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return concerns?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.yj_dequeueReusableCell(indexPath: indexPath) as MineConcernCCell
        if indexPath.item < concerns?.count ?? 0 {
            cell.concern = concerns?[indexPath.item]
        }
        return cell
    }
}


// MARK: - CollectionView 布局
private class MineConcernFlowLayout: UICollectionViewFlowLayout {    
    override func prepare() {
        // 每个 cell 大小
        itemSize = CGSize(width: 58, height: 74)
        // 纵向间距
        minimumInteritemSpacing = 0
        // 横向间距
        minimumLineSpacing  = 0
        
        // cell 上下左右的间距
        sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        // 滚动方向，水平滚动
        scrollDirection = .horizontal
    }
}

