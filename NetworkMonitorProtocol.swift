//
//  NetworkMonitorProtocol.swift
//  PhotoFinder
//
//  Created by Аркадий Варежкин on 15.02.2024.
//

import Foundation
import Network


protocol NetworkMonitorProtocol {
    var isConnected: Bool { get }
    var isExpensive: Bool { get }
    func startMonitoring()
    func stopMonitoring()
}
