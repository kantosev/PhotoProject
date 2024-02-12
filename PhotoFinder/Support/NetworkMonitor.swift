//
//  Networkmonitor.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 18.12.2022.
//
// 

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor: NWPathMonitor
    
    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")
    /*
     private(set), что означает, что геттер свойства все еще имеет уровень доступа по умолчанию internal, но свойство может быть установлено только в пределах кода, который является частью класса NetworkMonitor. Это позволяет NetworkMonitor изменять свойствo скрытно, но тем не менее позволяет свойству быть read-only (только для чтения), когда оно используется в других исходных файлах в пределах того же модуля.
     */
    private(set) var isConnected = false
    
    /// Следующее свойство нужно для проверки, что сетевое соединение
    /// будет дорогим в плане потребления трафика
    ///
    /// Сотовые интерфейсы считаются дорогими. WiFi точки доступа
    /// от других девайсов также могут быть дорогими. Другие интерфейсы
    /// могут оказаться дорогими в будущем
    private(set) var isExpensive = false
    
    /// curentConnectionType указывает на тип текущего соединения
    /// в сети, к которой мы подключены
    ///
    /// Возможные состояния могут быть `other`, `wifi`, `cellular`,
    /// `wiredEthernet`, or `loopback`
    private(set) var currentConnectionType: NWInterface.InterfaceType?
    
    private init() {
        monitor = NWPathMonitor()
    }
    
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
