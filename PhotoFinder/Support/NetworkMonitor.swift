//
//  Networkmonitor.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 18.12.2022.
//
// 

import Foundation
import Network

/// Объект для отслеживание соединения устройства с интернетом
final class NetworkMonitor: NetworkMonitorProtocol {
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    
    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")
 
    private(set) var isConnected = false
    
    // Свойство нужно для проверки, что сетевое соединение
    // будет дорогим в плане потребления трафика
    // Сотовые интерфейсы считаются дорогими. WiFi точки доступа
    // от других девайсов также могут быть дорогими.
    private(set) var isExpensive = false
    
    // Указывает на тип текущего соединения
    // в сети, к которой мы подключены
    // Возможные состояния могут быть `other`, `wifi`, `cellular`, `wiredEthernet`, or `loopback`
    private(set) var currentConnectionType: NWInterface.InterfaceType?
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    /// Начало мониторинга наличия подключения
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.isExpensive = path.isExpensive
            // Идентифицирует текущий тип соединения из
            // спискa возможных типов сетевых ссылок
            self?.currentConnectionType = NWInterface.InterfaceType.allCases.filter { path.usesInterfaceType($0) }.first
        }
        monitor.start(queue: queue)
    }
    
    /// Завершить мониторинг
    func stopMonitoring() {
        monitor.cancel()
    }
}

extension NWInterface.InterfaceType: CaseIterable {
    public static var allCases: [NWInterface.InterfaceType] = [
        .other,
        .wifi,
        .cellular,
        .loopback,
        .wiredEthernet
    ]
}
