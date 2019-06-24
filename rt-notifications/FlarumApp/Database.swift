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
var SERVERNAME = "127.0.0.1"
var DATABASE_NAME = "latest"
var PORT = 3307

class Database {
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    private func configureMySQL() {
        let user = OHMySQLUser(userName: USERNAME, password: PASSWORD, serverName: SERVERNAME, dbName: DATABASE_NAME, port: UInt(PORT), socket: "/tmp/mysql.sock")
        let coordinator = OHMySQLStoreCoordinator(user: user!)
        coordinator.encoding = .UTF8MB4
        coordinator.connect()
        
        let context = OHMySQLQueryContext()
        context.storeCoordinator = coordinator
        OHMySQLContainer.shared.mainQueryContext = context
    }
    
    public func fetchNotifications() {
        let notifications = ["Trip Notification",
                             "Local Notification with Action",
                             "Local Notification with Content"]
        
        configureMySQL()
        let query = OHMySQLQueryRequestFactory.select("notifications_notification", condition: nil)
        let response = try? OHMySQLContainer.shared.mainQueryContext?.executeQueryRequestAndFetchResult(query)
        if (response?.isEmpty == false) && ((response?[0]) != nil) {
            var title = response?[0]["title"]
            var body = response?[0]["body"]
            self.appDelegate?.scheduleNotification(notificationType: notifications[0],
                                                   title: title as! String,
                                                   body:body as! String)
        }
        // do check to see if there's notifications. and if so then send it
    }
    
    public func deleteNotifications() {
        let query = OHMySQLQueryRequestFactory.delete("notifications_notification", condition: "")
        let response = try?OHMySQLContainer.shared.mainQueryContext?.executeQueryRequestAndFetchResult(query)
    }
}
