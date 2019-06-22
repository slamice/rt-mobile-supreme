//
//  Notification.swift
//  FlarumApp
//
//  Created by Issam Zeibak on 6/21/19.
//  Copyright © 2019 Chamath Palihawadana. All rights reserved.
//

import Foundation
import OHMySQL

var USERNAME = "vagrant"
var PASSWORD = "test"
var SERVERNAME = "localhost"
var DATABASE_NAME = "latest"
var PORT = 3307

class Database {
    private func configureMySQL() {
        let user = OHMySQLUser(userName: USERNAME, password: PASSWORD, serverName: SERVERNAME, dbName: DATABASE_NAME, port: UInt(PORT), socket: "/var/mysql/mysql.sock")
        let coordinator = OHMySQLStoreCoordinator(user: user!)
        coordinator.encoding = .UTF8MB4
        coordinator.connect()
        
        let context = OHMySQLQueryContext()
        context.storeCoordinator = coordinator
        OHMySQLContainer.shared.mainQueryContext = context
    }
    
    public func fetchNotifications() {
        configureMySQL()
        let query = OHMySQLQueryRequestFactory.select("notifications_notification", condition: nil)
        let response = try? OHMySQLContainer.shared.mainQueryContext?.executeQueryRequestAndFetchResult(query)

    }
}
