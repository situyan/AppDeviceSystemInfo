//
//  AppInfoExtension.swift
//  AppDeviceSystemInfo_Example
//
//  Created by SMH on 2022/5/24.
//  Copyright © 2022 SMH All rights reserved.
//

import UIKit

//MARK: 获取APP部分基础信息
extension NSObject: APPInfoProtocol {}

public protocol APPInfoProtocol {
    /// App 名称
    var displayName: String? { get }
    /// App 版本号
    var appVersion: String? { get }
    /// Bulid 版本号
    var buildVersion: String? { get }
    /// Bundle Identifier
    var bundleIdentifier: String { get }
}

public extension APPInfoProtocol {
    var displayName: String? {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
    }
    
    var appVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
    var bundleIdentifier: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
}
