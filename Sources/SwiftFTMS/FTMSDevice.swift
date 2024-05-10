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
    case normal   = 0
    case starting = 1
    case paused   = 2
    case running  = 3
    case pausing  = 4
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
    
    init(time: Int, remain: Int, distance: Int, calories: Float, height: Float, count: Int, freq: Int, heart: Int, watt: Int, second: Int, speed: Float, incline: Int, level: Int) {
        self.time = time
        self.remain = remain
        self.distance = distance
        self.calories = calories
        self.height = height
        self.count = count
        self.freq = freq
        self.heart = heart
        self.watt = watt
        self.second = second
        self.speed = speed
        self.incline = incline
        self.level = level
        super.init()
    }
    
}

class FTMSBLEObject: NSObject {
    var peripheral: CBPeripheral?
    var advertisementData: [AnyHashable: Any]?
    var rSSI: NSNumber?
    
    init(peripheral: CBPeripheral?, advertisementData: [AnyHashable: Any]?, rSSI: NSNumber?) {
        super.init()
        self.peripheral = peripheral
        self.advertisementData = advertisementData
        self.rSSI = rSSI
    }
    
}

class FTMSDevice: NSObject {
    
    var type: FTMSDeviceType
    var state: FTMSDeviceState
    var bleProps: FTMSBLEObject
    var params: FTMSDeviceParam
    var values: FTMSDeviceValue
    
    init(type: FTMSDeviceType, state: FTMSDeviceState, bleProps: FTMSBLEObject, params: FTMSDeviceParam, values: FTMSDeviceValue) {
        self.type = type
        self.state = state
        self.bleProps = bleProps
        self.params = params
        self.values = values
        super.init()
    }
    
    public func start() {
        // Start device functionality
    }
    
    public func pause() {
        // Pause device functionality
    }
    
    public func stop() {
        // Stop device functionality
    }
    
    public func setSpeed(_ speed: Float) {
        // Set speed for the device
    }
    
    public func setIncline(_ incline: Int) {
        // Set incline for the device
    }
    
    private func sendCommandToDevice(){
        // Send command to the device
    }
    
}

