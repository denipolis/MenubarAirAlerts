//
//  AutolaunchHelper.swift
//  MenubarAirAlerts
//
//  Created by Denys Polishchuk  on 08.06.2025.
//


import SwiftUI
import ServiceManagement

enum LoginLauncher {
    static var isEnabled: Bool {
        return SMAppService.mainApp.status == .enabled
    }
    
    static func setEnabled(_ enabled: Bool) {
        do {
            let service = SMAppService.mainApp
            if enabled {
                try service.register()
            } else {
                try service.unregister()
            }
        } catch {
            print("SMAppService error: \(error)")
        }
    }
}
