//
//  FTMSBLECentralMananger.swift
//  Chetan Rana
//
//  Created by Chetan Rana on 08/05/24.
//  Copyright © 2024 Chetan Rana. All rights reserved.
//

import CoreBluetooth

enum FTMSManagerState : Int {
    case unknown = 0
    case resetting = 1
    case unsupported = 2
    case unauthorized = 3
    case poweredOff = 4
    case poweredOn = 5
}

protocol BLEManagerDelegate: Any {
    func manager(_ manager: CBCentralManager?, didManagerState state: FTMSManagerState)
    func manager(_ manager: CBCentralManager?, didDiscoverDevice device: FTMSBLEObject?)
    func manager(_ manager: CBCentralManager?, didConnect device: FTMSBLEObject?)
    func manager(_ manager: CBCentralManager,  didFailToConnect device: FTMSBLEObject, error: Error?)
    func manager(_ manager: CBCentralManager,  didDisconnectPeripheral device: FTMSBLEObject, error: Error?)
}



class FTMSBLECentralMananger: NSObject, CBCentralManagerDelegate {

    var delegate:BLEManagerDelegate?
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
       
        var stateForManager:FTMSManagerState = .unknown
        
        switch central.state {
        case .unknown:
            print("[FTMSManager] state: unknown")
            stateForManager = .unknown
            break
        case .resetting:
            print("[FTMSManager] state: resetting")
            stateForManager = .resetting
            break
        case .unsupported:
            print("[FTMSManager] state: not available")
            stateForManager = .unsupported
            break
        case .unauthorized:
            print("[FTMSManager] state: not authorized")
            stateForManager = .unauthorized
            break
        case .poweredOff:
            print("[FTMSManager] state: powered off")
            stateForManager = .poweredOff
            FTMSManager.stopScanningForFTMS()
            break
        case .poweredOn:
            stateForManager = .poweredOn
            print("[FTMSManager] state: powered on")
            break
        @unknown default:
            stateForManager = .unknown
            print("[FTMSManager] state: unknown")
        }
        
        FTMSManager.isReady.value = (central.state == .poweredOn)
        delegate?.manager(central, didManagerState: stateForManager)
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        
        print("[FTMSManager] did discover:", peripheral)
        
        let bleObj:FTMSBLEObject = FTMSBLEObject(peripheral: peripheral, advertisementData: advertisementData, rSSI: RSSI)
        delegate?.manager(central, didDiscoverDevice: bleObj)
        
        //FTMSManager.stopScanningForFTMS()
        //FTMSManager.connectPeripheral(peripheral: peripheral)
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {

        print("[FTMSManager] did connect:", peripheral.name ?? "")
        peripheral.discoverServices([FTMSUUID.serviceFTMS.uuid])
        
        let bleObj:FTMSBLEObject = FTMSBLEObject(peripheral: peripheral, advertisementData: nil, rSSI: nil)
        delegate?.manager(central, didConnect: bleObj)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {

        print("[FTMSManager] did fail to connect:", peripheral.name ?? "")
        
        let bleObj:FTMSBLEObject = FTMSBLEObject(peripheral: peripheral, advertisementData: nil, rSSI: nil)
        self.delegate?.manager(central, didFailToConnect: bleObj, error: error)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {

        print("[FTMSManager] did disconnect:", peripheral.name ?? "")
        
        let bleObj:FTMSBLEObject = FTMSBLEObject(peripheral: peripheral, advertisementData: nil, rSSI: nil)
        self.delegate?.manager(central, didDisconnectPeripheral: bleObj, error: error)
    
    }
    

}
