//
//  MineNoLoginHeaderView.swift
//  YJNews
//
//  Created by yyj on 2021/2/5.
//

import UIKit

/// 点击事件类型
enum NoLoginHeaderViewActionType: Int {
    case phoneLoginAction = 10
    case wxLoginAction
    case qqLoginAction
    case sinaLoginAction
    case moreLoginAction
    case collectAction
    case historyAction
    case nightAction
}

/// 事件回调代理
protocol MineNoLoginHeaderViewDelegate {
    func mineNoLoginHeaderViewButtonAction(_ actiontype: NoLoginHeaderViewActionType)
}

class MineNoLoginHeaderView: UIView {
    
    var delegate: MineNoLoginHeaderViewDelegate?
    static let height: CGFloat = 280
    
    // MARK: - 属性
    private var bgImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "wallpaper_profile_night"))
        return iv
    }()
    
    private var moreLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("更多登录方式 >", for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 14.0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tag = 14
        button.addTarget(self, action: #selector(buuttonsAction), for: .touchUpInside)
        return button
    }()
            
    private var loginBtnsBGView: UIStackView = {
        let createButton = { (btnInfo: [String : String]) -> (UIButton?) in
            guard let imagename = btnInfo["image"],
                  let tagStr = btnInfo["tag"],
                  let tag = Int(tagStr)else { return nil }
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: imagename), for: .normal)
            button.addTarget(self, action: #selector(buuttonsAction), for: .touchUpInside)
            button.tag = tag
            return button
        }
        let imageNameArray : [[String : String]] = [["image" : "cellphoneicon_login_profile_66x66_", "tag" : "10"],
                                                    ["image" : "weixinicon_login_profile_66x66_", "tag" : "11"],
                                                    ["image" : "qqicon_login_profile_66x66_", "tag" : "12"],
                                                    ["image" : "sinaicon_login_profile_66x66_", "tag" : "13"]]
        var buttons = [UIButton]()
        for dict in imageNameArray {
            if let button = createButton(dict) {
                buttons.append(button)
            }
        }
        let sv = UIStackView(arrangedSubviews: buttons)
        // 水平布局
        sv.axis = .horizontal
        // 等间距
        sv.distribution = .equalSpacing
        return sv
    }()
    
    
    var bottomBGView: UIStackView = {
        let createButton = { (imageName: String, title: String) -> (UIButton) in
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: imageName), for: .normal)
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: screenWidth*0.33, height: 70))
            }
            
            button.sizeToFit()
            let imgW:CGFloat = button.imageView!.frame.size.width
            let imgH:CGFloat = button.imageView!.frame.size.height
            let lblW:CGFloat = button.titleLabel!.frame.size.width
            let lblH:CGFloat = button.titleLabel!.frame.size.height
            //设置图片和文字的间距，这里可自行调整
            let margin:CGFloat = 5

            button.imageEdgeInsets = UIEdgeInsets(top: -lblH-margin/2, left: 0, bottom: 0, right: -lblW)
            button.titleEdgeInsets = UIEdgeInsets(top: imgH+margin/2, left: -imgW, bottom: 0, right: 0)

            return button
        }
        let btnInfoArray = [["image" :"favoriteicon_profile_24x24_", "title" : "收藏"],
                            ["image" : "history_profile_24x24_", "title" : "历史"],
                            ["image" : "nighticon_profile_24x24_", "title" : "夜间"]]
        var buttons = [UIButton]()
        for dict in btnInfoArray {
            buttons.append(createButton(dict["image"]!, dict["title"]!))
        }
        let stv = UIStackView(arrangedSubviews: buttons)
        // 水平布局
        stv.axis = .horizontal
        // 等间距
        stv.distribution = .equalSpacing
        stv.backgroundColor = UIColor.white
        return stv
    }()
    
    
    // MARK: - 事件
    @objc func buuttonsAction(button: UIButton) {
        print("tag = \(button.tag)")
        guard let actionType = NoLoginHeaderViewActionType.init(rawValue: button.tag) else { return }
        delegate?.mineNoLoginHeaderViewButtonAction(actionType)
    }
    
  
    
    // MARK: - 初始化
    class func header() -> MineNoLoginHeaderView {
        let view = MineNoLoginHeaderView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: height))
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(loginBtnsBGView)
        addSubview(bottomBGView)
        addSubview(moreLoginButton)
        bgImageView.frame = self.bounds
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()

        loginBtnsBGView.snp.makeConstraints {
            $0.top.equalTo(50)
            $0.left.equalTo(10)
            $0.right.equalTo(-10)
            $0.height.equalTo(73)
        }
        
        moreLoginButton.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(loginBtnsBGView.snp.bottom).offset(20)
            $0.size.equalTo(CGSize(width: 125, height: 28))
        }
        
        bottomBGView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(0)
            $0.height.equalTo(70)
        }
    }
}
