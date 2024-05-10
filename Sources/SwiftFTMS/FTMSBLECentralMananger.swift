//
//  FTMSBLECentralMananger.swift
//  Chetan Rana
//
//  Created by Chetan Rana on 08/05/24.
//  Copyright © 2024 Chetan Rana. All rights reserved.
//

import CoreBluetooth

@available(iOS 10.0, *)
class FTMSBLECentralMananger: NSObject, CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("[FTMSManager] state: unknown")
            break
        case .resetting:
            print("[FTMSManager] state: resetting")
            break
        case .unsupported:
            print("[FTMSManager] state: not available")
            break
        case .unauthorized:
            print("[FTMSManager] state: not authorized")
            break
        case .poweredOff:
            print("[FTMSManager] state: powered off")
            FTMSManager.stopScanningForFTMS()
            break
        case .poweredOn:
            print("[FTMSManager] state: powered on")
            break
        @unknown default:
            print("[FTMSManager] state: unknown")
        }
        
        FTMSManager.isReady.value = (central.state == .poweredOn)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {

        print("[FTMSManager] did connect:", peripheral.name ?? "")
        peripheral.discoverServices([FTMSUUID.serviceFTMS.uuid])
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        
        print("[FTMSManager] did discover:", peripheral)
        FTMSManager.stopScanningForFTMS()
        FTMSManager.connectPeripheral(peripheral: peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {

        print("[FTMSManager] did disconnect:", peripheral.name ?? "")
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {

        print("[FTMSManager] did fail to connect:", peripheral.name ?? "")
    }
}
