//
//  MenubarAirAlertsApp.swift
//  MenubarAirAlerts
//
//  Created by Denys Polishchuk  on 08.06.2025.
//

import SwiftUI

@main
struct MenubarAirAlertsApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings { EmptyView() }
    }
}
