//
//  internetConnect.swift
//  testIIOS
//
//  Created by Александр on 29.03.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import Foundation
import SystemConfiguration

public class TestConnect{
    class func isConnectNetwork() -> Bool{
    
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
    SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0))
    }
    
    var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
    if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
    return false
    }
    
    let isReachable = flags == .Reachable
    let needsConnection = flags == .ConnectionRequired
    
    return isReachable && !needsConnection
    
    }
}



func testConnect() -> Bool{
    if TestConnect.isConnectNetwork() == true {
        print("Internet connection OK")
    } else {
        print("Internet connection FAILED")
        var alert = UIAlertView(title: "Отсутсвует соединение с интрнетом", message: "Устройство не подключено к интернету",delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    return TestConnect.isConnectNetwork()
}
