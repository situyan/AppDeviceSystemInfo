//
//  DeviceInfoExtension.swift
//  AppDeviceSystemInfo_Example
//
//  Created by SMH on 2022/5/24.
//  Copyright © 2022 SMH All rights reserved.
//

import UIKit

//MARK: 获取DeviceAPP部分基础信息
extension NSObject: DeviceInfoProtocol {
}

public protocol DeviceInfoProtocol {
    /// 设备 uuid
    var uuidNumber: String { get }
    /// 设备本地名称 XXX的iPhone、XXX...
    var deviceName: String { get }
    /// 设备型号名称 iPhone 13、iPhone 13 Pro、iPhone13 mini...
    var modelName: String { get }
    /// 设备区域化型号
    var localizedModel: String { get }
    /// 方向
    var orientation: UIDeviceOrientation { get }
    /// 电池状态 .batteryMonitoringEnabled = YES; //开启电量监控，默认不开启
    var batteryState: UIDevice.BatteryState { get }
    /// 电池电量 0~1 -1表示未知
    var batteryLevel: Float { get }
    /// 设备界面样式  Phone、Pad、TV...
    var interfaceIdiom: UIUserInterfaceIdiom { get }
}

public extension DeviceInfoProtocol {
    var uuidNumber: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    var deviceName: String {
        return UIDevice.current.name
    }
    
    var modelName: String {
//        return UIDevice.current.model;
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        // https://www.theiphonewiki.com/wiki/Models
        // https://gist.github.com/adamawolf/3048717
        
        switch identifier {
        case "i386","x86_64":                          return "Simulator"
            
        case "iPhone10,3", "iPhone10,6":               return "iPhoneX"
        case "iPhone11,2":                             return "iPhoneXS"
        case "iPhone11,6":                             return "iPhoneXS_MAX"
        case "iPhone11,8":                             return "iPhoneXR"
            
        case "iPhone12,1":                             return "iPhone11"
        case "iPhone12,3":                             return "iPhone11 Pro"
        case "iPhone12,5":                             return "iPhone11 Pro Max"
        case "iPhone12,8":                             return "iPhoneSE (2nd generation)"
            
        case "iPhone13,1":                             return "iPhone12 mini"
        case "iPhone13,2":                             return "iPhone12"
        case "iPhone13,3":                             return "iPhone12 Pro"
        case "iPhone13,4":                             return "iPhone12 Pro Max"
            
        case "iPhone14,4":                             return "iPhone13 mini"
        case "iPhone14,5":                             return "iPhone13"
        case "iPhone14,2":                             return "iPhone13 Pro"
        case "iPhone14,3":                             return "iPhone13 Pro Max"
        case "iPhone14,6":                             return "iPhoneSE (3rd generation)"
            
        case "iPhone8,1":                              return "iPhone6s"
        case "iPhone8,2":                              return "iPhone6s Plus"
        case "iPhone8,4":                              return "iPhoneSE"
        case "iPhone9,1",  "iPhone9,3":                return "iPhone7"
        case "iPhone9,2",  "iPhone9,4":                return "iPhone7 Plus"
        case "iPhone10,1", "iPhone10,4":               return "iPhone8"
        case "iPhone10,5", "iPhone10,2":               return "iPhone8 Plus"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":    return "iPhone4"
        case "iPhone4,1":                              return "iPhone4s"
        case "iPhone5,1","iPhone5,2":                  return "iPhone5"
        case "iPhone5,3", "iPhone5,4":                 return "iPhone5c"
        case "iPhone6,1", "iPhone6,2":                 return "iPhone5s"
        case "iPhone7,2":                              return "iPhone6"
        case "iPhone7,1":                              return "iPhone6 Plus"
            
        case "iPad2,5", "iPad2,6", "iPad2,7":          return "iPad mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":          return "iPad mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":          return "iPad mini 3"
        case "iPad5,1", "iPad5,2":                     return "iPad mini 4"
        case "iPad11,1","iPad11,2":                    return "iPad mini (5th generation)"
        case "iPad14,1","iPad14,2":                    return "iPad mini (6th generation)"
            
        case "iPad4,1", "iPad4,2", "iPad4,3":          return "iPad Air"
        case "iPad5,3","iPad5,4":                      return "iPad Air 2"
        case "iPad11,3","iPad11,4":                    return "iPad Air (3rd generation)"
        case "iPad13,1","iPad13,2":                    return "iPad Air (4th generation)"
        case "iPad13,16","iPad13,17":                  return "iPad Air (5th generation)"
            
        case "iPad1,1":                                return "iPad 1"
        case "iPad2,1","iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":          return "iPad (3rd generation)"
        case "iPad3,4", "iPad3,5", "iPad3,6":          return "iPad (4th generation)"
        case "iPad6,11", "iPad6,12":                   return "iPad (5th generation)"
        case "iPad7,5", "iPad7,6":                     return "iPad (6th generation)"
        case "iPad7,11", "iPad7,12":                   return "iPad (7th generation)"
        case "iPad11,6", "iPad11,7":                   return "iPad (8th generation)"
        case "iPad12,1", "iPad12,2":                   return "iPad (9th generation)"
            
        case "iPad6,3","iPad6,4":                      return "iPad Pro (9.7-inch)"
        case "iPad6,7","iPad6,8":                      return "iPad Pro (12.9-inch)"
        case "iPad7,1","iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad7,3","iPad7,4":                      return "iPad Pro (10.5-inch)"
        case "iPad8,1","iPad8,2","iPad8,3","iPad8,4":  return "iPad Pro (11-inch)"
        case "iPad8,5","iPad8,6","iPad8,7","iPad8,8":  return "iPad Pro (12.9-inch) (3rd generation)"
        case "iPad8,9","iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
        case "iPad8,11","iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
        case "iPad13,4","iPad13,5","iPad13,6","iPad13,7": return "iPad Pro (11-inch) (3rd generation)"
        case "iPad13,8","iPad13,9","iPad13,10","iPad13,11": return "iPad Pro (12.9-inch) (5th generation)"
            
        case "iPod1,1":                                return "iPod touch"
        case "iPod2,1":                                return "iPod touch (2nd generation)"
        case "iPod3,1":                                return "iPod touch (3rd generation)"
        case "iPod4,1":                                return "iPod touch (4th generation)"
        case "iPod5,1":                                return "iPod touch (5th generation)"
        case "iPod7,1":                                return "iPod touch (6th generation)"
        case "iPod9,1":                                return "iPod touch (7th generation)"

//        case "AppleTV2,1":                             return "Apple TV (2nd generation)"
//        case "AppleTV3,2":                             return "Apple TV (3rd generation)"
//        case "AppleTV5,3":                             return "Apple TV (4th generation)"
//        case "AppleTV6,2":                             return "Apple TV 4K"
//        case "AppleTV11,1":                            return "Apple TV 4K (2nd generation)"
        
        default:                                       return identifier
        }
    }
    
    var localizedModel: String {
        return UIDevice.current.localizedModel
    }
    
    var orientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    var batteryState: UIDevice.BatteryState {
        return UIDevice.current.batteryState
    }
    
    var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    
    var interfaceIdiom: UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
}
