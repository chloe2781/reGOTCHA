//
//  NetworkManager.swift
//  regotcha
//
//  Created by Chloe Nguyen on 12/2/23.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    @Published var isNetworkReachable: Bool = true
    @Published var monitor: NWPathMonitor?

    init() {
        startMonitoring()
    }

    func startMonitoring() {
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor?.start(queue: queue)

        monitor?.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isNetworkReachable = path.status == .satisfied
            }
        }
    }

    deinit {
        monitor?.cancel()
    }
}
