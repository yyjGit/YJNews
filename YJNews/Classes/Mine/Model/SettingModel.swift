//
//  SettingModel.swift
//  YJNews
//
//  Created by yyj on 2021/2/6.
//

import UIKit
import HandyJSON

struct SettingModel: HandyJSON {
    var title = ""
    var subtitle = ""
    var rightTitle = ""
    var isHiddenRightTitle = false
    var isHiddenSubtitle = false
    var isHiddenRightArraw = false
    var isHiddenSwitch = false
}
