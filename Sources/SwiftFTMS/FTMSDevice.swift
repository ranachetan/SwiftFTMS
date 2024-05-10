//
//  FTMSDevice.swift
//  Chetan Rana
//
//  Created by Chetan Rana on 09/05/24.
//  Copyright © 2024 Chetan Rana. All rights reserved.
//

import Foundation
import CoreBluetooth

enum FTMSDeviceType: Int {
    case treadmill = 0
    case trainer   = 1
    case bike      = 2
    case rower     = 3
    case steper    = 4
    case climber   = 5
    case strength  = 6
    case vibrator  = 7
}

enum FTMSDeviceState: Int {
    case normal = 0
    case starting = 1
    case paused = 2
    case running = 3
    case pausing = 4
}

class FTMSDeviceParam: NSObject {
    var imperial: Bool?
    var supportPause: Bool?
    var supportHeart: Bool?
    var supportStep: Bool?
    var supportSpeed: Bool?
    var maxSpeed: Float = 0.0
    var minSpeed: Float = 0.0
    var supportIncline: Bool?
    var containIncline: Bool?
    var maxIncline: Int = 0
    var minIncline: Int = 0
    var supportLevel: Bool?
    var containLevel: Bool?
    var maxLevel: Int = 0
    var minLevel: Int = 0
}

class FTMSDeviceValue: NSObject {
    var time: Int = 0
    var remain: Int = 0
    var distance: Int = 0
    var calories: Float = 0.0
    var height: Float = 0.0
    var count: Int = 0
    var freq: Int = 0
    var heart: Int = 0
    var watt: Int = 0
    var second: Int = 0
    var speed: Float = 0
    var incline: Int = 0
    var level: Int = 0
}

class FTMSBLEObject: NSObject {
    var peripheral: CBPeripheral?
    var advertisementData: [AnyHashable: Any]?
    var rSSI: NSNumber?
}

class FTMSDevice: NSObject {
    var type: FTMSDeviceType?
    var state: FTMSDeviceState?
    var bleProps: FTMSBLEObject?
    var params: FTMSDeviceParam?
    var values: FTMSDeviceValue?
}
