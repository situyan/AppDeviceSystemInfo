//
//  SystemInfoExtension.swift
//  AppDeviceSystemInfo_Example
//
//  Created by SMH on 2022/5/24.
//  Copyright © 2022 SMH All rights reserved.
//

import UIKit

//MARK: 获取系统部分基础信息
extension NSObject: SystemInfoProtocol {}

public protocol SystemInfoProtocol {
    /// iOS 版本号
    var iOSVersion: String { get }
    /// 操作系统名称 iOS、MacOS...
    var systemName: String { get }
}

public extension SystemInfoProtocol {
    var iOSVersion: String {
        return UIDevice.current.systemVersion
    }
    
    var systemName: String {
        return UIDevice.current.systemName
    }
}
