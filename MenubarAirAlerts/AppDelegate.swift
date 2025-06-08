//
//  AppDelegate.swift
//  MenubarAirAlerts
//
//  Created by Denys Polishchuk  on 08.06.2025.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBar: NSStatusItem!
    var timer: Timer?
    var regions: [String: Region] = [:]
    
    var chosenRegion: String? {
        get { UserDefaults.standard.string(forKey: "ChosenRegion") }
        set { UserDefaults.standard.set(newValue, forKey: "ChosenRegion") }
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        
        
        statusBar = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBar.button?.title = "📢"

        let menu = NSMenu()
        
        menu.addItem(.sectionHeader(title: "📢 MenubarAirAlerts"))
        menu.addItem(.separator())
        
        let regionItem = NSMenuItem(title: "Обрати область", action: nil, keyEquivalent: "c")
        menu.setSubmenu(NSMenu(), for: regionItem)
        menu.addItem(regionItem)
        menu.addItem(.separator())
        
        let autolaunchItem = NSMenuItem(
            title: "Запускати при вході в систему",
            action: #selector(toggleAutolaunch),
            keyEquivalent: ""
        )
        autolaunchItem.target = self
        autolaunchItem.state = LoginLauncher.isEnabled ? .on : .off
        
        menu.addItem(autolaunchItem)
        menu.addItem(NSMenuItem(title: "Вийти", action: #selector(quit), keyEquivalent: "q"))
        
        statusBar.menu = menu

        startTimer()
        fetchAndUpdate()
    }

    @objc func quit() { NSApp.terminate(nil) }
    @objc func toggleAutolaunch(_ sender: NSMenuItem) {
        let isEnabled = sender.state == .on
        LoginLauncher.setEnabled(!isEnabled)
        sender.state = isEnabled ? .off : .on
    }
}

extension AppDelegate {
    var regionMenu: NSMenu {
        return statusBar.menu?
            .item(withTitle: "Обрати область")?
            .submenu ?? NSMenu()
    }

    func populateRegionMenu() {
        regionMenu.removeAllItems()
            
        regions.sorted(by: {$0.key < $1.key}).forEach { region, value in
            let mi = NSMenuItem(title: "\(value.alertnow ? "🔴" : "🟢") \(region)", action: #selector(selectRegion(_:)), keyEquivalent: "")
            mi.target = self
            mi.state = (region == chosenRegion) ? .on : .off
            regionMenu.addItem(mi)
        }
    }

    @objc func selectRegion(_ mi: NSMenuItem) {
        let title = String(mi.title.dropFirst(2))
        
        if(chosenRegion == title) {
            print("Deselected region: \(chosenRegion ?? "nil") -> nil")
            chosenRegion = nil
        } else {
            print("Selected region: \(chosenRegion ?? "nil") -> \(title)")
            chosenRegion = title
        }
        
        populateRegionMenu()
        updateTitle()
    }
}

extension AppDelegate {
    func startTimer() {
        timer = Timer(timeInterval: 5, target: self,
                      selector: #selector(fetchAndUpdate),
                      userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }

    @objc func fetchAndUpdate() {
        guard let url = URL(string: "https://ubilling.net.ua/aerialalerts/") else {
            print("Unable to fetch data!")
            return
        }

        URLSession.shared.dataTask(with: url) { d, _, _ in
            guard let d = d,
                  let root = try? JSONDecoder().decode(Response.self, from: d)
            else {
                print("Unable to parse received data!")
                return
            }

            DispatchQueue.main.async {
                self.regions = root.states
                self.populateRegionMenu()
                self.updateTitle()
            }
            
            print("Succesfully fetched \(self.regions.count) regions!")
        }.resume()
    }
}

extension AppDelegate {
    func updateTitle() {
        guard let region = chosenRegion,
              let st = regions[region]
        else {
            statusBar.button?.title = "📢"
            return
        }
        
        statusBar.button?.title = "\(st.alertnow ? "🔴" : "🟢") \(region)"
    }
}
