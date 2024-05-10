//
//  FTMSManager.swift
//  Chetan Rana
//
//  Created by Chetan Rana on 08/05/24.
//  Copyright © 2024 Chetan Rana. All rights reserved.
//

import Combine
import CoreBluetooth

@available(iOS 10.0, *)
public class FTMSManager: NSObject, ObservableObject {
    
    public static let sharedInstance = FTMSManager()
    
    public static func scanForFTMS() {
        sharedInstance.scanForFTMS()
    }

    public static func stopScanningForFTMS() {
        sharedInstance.stopScanningForFTMS()
    }

    public static func connectPeripheral( peripheral: CBPeripheral ) {
        sharedInstance.connectFTMS( peripheral: peripheral )
    }

    public static var isReady: Subject<Bool> {
        get {
            return sharedInstance.isReady
        }
    }
    
    public static var isConnected: Subject<Bool> {
        get {
            return sharedInstance.isConnected
        }
    }
    
    public static var rowerData: Subject<RowerData> {
        get {
            return sharedInstance.peripheralDelegate.rowerData
        }
    }

    // MARK: Internal functions
    fileprivate let isReady = Subject<Bool>(value: false)
    fileprivate let isConnected = Subject<Bool>(value: false)

    //fileprivate let scannedDevices:[FTMSDevice]?
    
    fileprivate let connectedComModule = Subject<CBPeripheral?>(value: nil)
  
    fileprivate let peripheralDelegate = FTMSPeripheralDelegate()

    fileprivate var centralManager: CBCentralManager
    fileprivate var centralManagerDelegate: CBCentralManagerDelegate
    fileprivate let centralManagerQueue = DispatchQueue(
        label: "com.chetanrana.bluetooth.central",
        attributes: DispatchQueue.Attributes.concurrent
    )

    override private init( ) {
        // Perform any final initialization of your application.
        centralManagerDelegate = FTMSBLECentralMananger()
        centralManager = CBCentralManager(delegate: centralManagerDelegate, queue: centralManagerQueue)
        
        self.isReady.value = (centralManager.state == CBManagerState.poweredOn)
    }

    func scanForFTMS() {
        centralManager.scanForPeripherals(withServices: [FTMSUUID.serviceFTMS.uuid], options: nil)
    }
    
    func stopScanningForFTMS() {
        centralManager.stopScan()
    }

    func connectFTMS( peripheral: CBPeripheral ) {
        peripheral.delegate = peripheralDelegate
        connectedComModule.value = peripheral
        isConnected.value = true
        centralManager.connect(connectedComModule.value!, options: nil)
    }

    func disconnectFTMS() {

        print("[FTMS] cleanup:")
        if let comModule = connectedComModule.value {
            comModule.services?.forEach({ (service: CBService) -> Void in
                service.characteristics?.forEach({ (characteristic: CBCharacteristic) -> Void in
                    comModule.setNotifyValue(false, for: characteristic)
                })
            })

            centralManager.cancelPeripheralConnection(comModule)
        }
        
        isConnected.value = false
    }
}
