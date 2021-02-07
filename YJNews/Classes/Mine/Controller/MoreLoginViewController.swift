//
//  MoreLoginViewController.swift
//  YJNews
//
//  Created by yyj on 2021/2/6.
//

import UIKit

class MoreLoginViewController: YJBaseViewController {

    // MARK: - 属性
    /// 关闭按钮
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.theme_setImage("images.Login.close_button", forState: .normal)
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return button
    }()
    
    /// 顶部标题
    lazy var titleLabel: UIButton = {
        let label = UIButton()
        label.setTitle("登录你的头条，精彩永不丢失", for: .normal)
        label.setTitle("账号密码登录", for: .selected)
        label.setTitleColor(.black, for: .normal)
        label.isUserInteractionEnabled = false
        label.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    /// 获取验证码按钮
    lazy var smsCodeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("发送验证码", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.addTarget(self, action: #selector(smsButtonAction), for: .touchUpInside)
        return btn
    }()
    
    /// 手机号 textField
    lazy var phoneNoTextField: UITextField = {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 44))
        let line = UIView(frame: CGRect(x: 0, y: 12, width: 1, height: rightView.bounds.height-24))
        line.backgroundColor = .lightGray
        rightView.addSubview(line)
        smsCodeButton.frame = CGRect(x: 1, y: 0, width: rightView.bounds.width-10, height: rightView.bounds.height)
        rightView.addSubview(smsCodeButton)
                
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))

        let tf = UITextField()
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 22
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1.0
        tf.placeholder = "手机号"
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.rightView = rightView
        tf.rightViewMode = .always
        tf.leftView = leftView
        tf.leftViewMode = .always
        return tf
    }()
    
    /// 找回密码按钮
    lazy var findPwdButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("找回密码", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.addTarget(self, action: #selector(findPwdButtonAction), for: .touchUpInside)
        return btn
    }()

    
    /// 验证码/密码 textField
    lazy var smsCodeTextField: UITextField = {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 44))
        let line = UIView(frame: CGRect(x: 0, y: 12, width: 1, height: rightView.bounds.height-24))
        line.backgroundColor = .lightGray
        rightView.addSubview(line)
        findPwdButton.frame = CGRect(x: 1, y: 0, width: rightView.bounds.width-10, height: rightView.bounds.height)
        rightView.addSubview(findPwdButton)

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        let tf = UITextField()
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 22
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1.0
        tf.placeholder = "请输入验证码"
        tf.font = UIFont.systemFont(ofSize: 14)

        tf.rightView = rightView
        tf.rightViewMode = .always
        tf.leftView = leftView
        tf.leftViewMode = .always
        tf.rightView?.isHidden = true
        return tf
    }()
    
    /// 验证后自动登录
    lazy var autoLoginRemindLabel: UILabel = {
        let label = UILabel()
        label.text = "未注册手机验证后自动登录"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
        
    /// 进入头条
    lazy var enterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("进入头条", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(r: 249, g: 169, b: 169)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
        return button
    }()
    
    
    /// 协议
    lazy var protocolButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "details_choose_icon_15x15_"), for: .normal)
        button.setImage(UIImage(named: "details_choose_ok_icon_15x15_"), for: .selected)
        button.addTarget(self, action: #selector(protocolButtonAction), for: .touchUpInside)
        return button
    }()
    lazy var protocolLabel: UILabel = {
        let label = UILabel()
        label.text = "我已阅读并同意“用户协议和隐私条块”"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .center
        return label
    }()

    
    /// 登录模式切换
    lazy var loginModeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("账号密码登录", for: .normal)
        button.setTitle("免密码登录", for: .selected)
        button.setTitleColor(UIColor(r: 72, g: 107, b: 157), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(loginModeButtonAction), for: .touchUpInside)
        return button
    }()

    
    /// 第三方登录
    lazy var wxLoginBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "weixin_sdk_login_40x40_"), for: .normal)
        button.addTarget(self, action: #selector(wxLoginButtonAction), for: .touchUpInside)
        return button
    }()
    lazy var qqLoginBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "qq_sdk_login_40x40_"), for: .normal)
        button.addTarget(self, action: #selector(qqLoginButtonAction), for: .touchUpInside)
        return button
    }()
    lazy var mailLoginBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "mailbox_sdk_login_40x40_"), for: .normal)
        button.addTarget(self, action: #selector(mailLoginButtonAction), for: .touchUpInside)
        return button
    }()
    lazy var otherLoginBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "tianyi_sdk_login_40x40_"), for: .normal)
        button.addTarget(self, action: #selector(otherLoginButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var thirdLoginBGView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [wxLoginBtn, qqLoginBtn, mailLoginBtn, otherLoginBtn])
        // 水平布局
        sv.axis = .horizontal
        // 等间距
        sv.distribution = .equalSpacing
        return sv
    }()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加子视图
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(phoneNoTextField)
        view.addSubview(smsCodeTextField)
        view.addSubview(autoLoginRemindLabel)
        view.addSubview(enterButton)
        view.addSubview(protocolLabel)
        view.addSubview(protocolButton)
        view.addSubview(loginModeButton)
        view.addSubview(thirdLoginBGView)
        
        // 布局
        layoutPageSubViews()        
    }
    

    // MARK: - 点击事件
    @objc func closeButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func enterButtonAction() {
        print("进入 头条")
    }
    
    @objc func smsButtonAction() {
        print("获取验证码")
    }
    
    @objc func findPwdButtonAction() {
        print("找回密码")
    }
    
    @objc func protocolButtonAction(button: UIButton) {
        button.isSelected = !button.isSelected
        print("选中协议")
    }
    
    @objc func loginModeButtonAction(button: UIButton) {
        button.isSelected = !button.isSelected
        self.titleLabel.isSelected = button.isSelected
        self.smsCodeTextField.placeholder = button.isSelected ? "密码" : "请输入验证码"
        self.phoneNoTextField.rightView?.isHidden = button.isSelected
        self.smsCodeTextField.rightView?.isHidden = !button.isSelected
    }

    @objc func wxLoginButtonAction(button: UIButton) {
        
        print("微信登录")
    }
    
    @objc func qqLoginButtonAction(button: UIButton) {
        
        print("QQ登录")
    }

    @objc func mailLoginButtonAction(button: UIButton) {
        print("邮件登录")
    }

    @objc func otherLoginButtonAction(button: UIButton) {
        print("账号密码登录")
    }
}

// MARK: - 布局
private extension MoreLoginViewController {
    
    func layoutPageSubViews()  {
        closeButton.snp.makeConstraints {
            $0.right.equalTo(-10)
            $0.top.equalTo(35)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(closeButton.snp.bottom).offset(10)
        }
        
        phoneNoTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.left.equalTo(30)
            $0.right.equalTo(-30)
            $0.height.equalTo(44)
        }
        
        smsCodeTextField.snp.makeConstraints {
            $0.top.equalTo(phoneNoTextField.snp.bottom).offset(10)
            $0.centerX.width.height.equalTo(phoneNoTextField)
        }
        
        autoLoginRemindLabel.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(smsCodeTextField.snp.bottom).offset(10)
        }
        
        enterButton.snp.makeConstraints {
            $0.centerX.size.height.equalTo(smsCodeTextField)
            $0.top.equalTo(autoLoginRemindLabel.snp.bottom).offset(10)
        }
        
        protocolLabel.snp.makeConstraints {
            $0.centerX.equalTo(view).offset(10)
            $0.top.equalTo(enterButton.snp.bottom).offset(10)
        }
        protocolButton.snp.makeConstraints {
            $0.centerY.equalTo(protocolLabel)
            $0.right.equalTo(protocolLabel.snp.left).offset(-4)
        }
        
        loginModeButton.snp.makeConstraints {
            $0.centerX.equalTo(view )
            $0.top.equalTo(protocolLabel.snp.bottom).offset(20)
        }

        thirdLoginBGView.snp.makeConstraints {
            $0.left.right.equalTo(smsCodeTextField)
            $0.bottom.equalTo(-60)
            $0.height.equalTo(60)
        }
    }
}
