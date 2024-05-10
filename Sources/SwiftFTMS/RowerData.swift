//
//  RowerData.swift
//  Chetan Rana
//
//  Created by Chetan Rana on 08/05/24.
//  Copyright © 2024 Chetan Rana. All rights reserved.
//

import Foundation

public class RowerData {
    public var strokeRate: UInt8 = 0
    public var strokeCount: UInt16 = 0
    public var averageStrokeRate: UInt8 = 0
    public var totalDistance: UInt32 = 0
    public var instantaneousPace: UInt16 = 0
    public var averagePace: UInt16 = 0
    public var instantaneousPower: UInt16 = 0
    public var averagePower: Int16 = 0
    public var resistenceLevel: Int16 = 0
    public var totalEnergy: UInt16 = 0
    public var energyPerHour: UInt16 = 0
    public var energyPerMinute: UInt8 = 0
    public var heartRate: UInt8 = 0
    public var metabolicEquivilent: UInt8 = 0
    public var elapsedTime: UInt16 = 0
    public var remainingTime: UInt16 = 0
}
