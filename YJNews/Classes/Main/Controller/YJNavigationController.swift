//
//  YJNavigationController.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import UIKit

class YJNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_24x24_"), style: .plain, target: self, action: #selector(defaultBack))
        }
        super.pushViewController(viewController, animated: animated)
    }

    
    @objc private func defaultBack() {
        popViewController(animated: true)
    }

}
