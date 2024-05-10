//
//  FTMSUUID.swift
//  Chetan Rana
//
//  Created by Chetan Rana on 08/05/24.
//  Copyright © 2024 Chetan Rana. All rights reserved.
//

import CoreBluetooth

public enum FTMSUUID: String {

    case serviceFTMS                        = "1826"

    case characteristicFTMSFeature          = "2ACC"
    case characteristicFTMSStatus           = "2ADA"
    case characteristicFTMSControlPoint     = "2AD9"

    case characteristicRowerData            = "2AD1"
    case characteristicTrainingStatus       = "2AD3"
    case characteristicInclinationRange     = "2AD5"
    case characteristicResistenceLevelRange = "2AD6"
    case characteristicHeartRateRange       = "2AD7"
    case characteristicPowerRange           = "2AD8"

    var uuid: CBUUID {
        return CBUUID( string: self.rawValue )
    }
}
