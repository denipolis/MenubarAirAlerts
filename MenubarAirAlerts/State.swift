//
//  State.swift
//  MenubarAirAlerts
//
//  Created by Denys Polishchuk  on 08.06.2025.
//

struct Response: Decodable {
    let source: String
    let cachedat: String
    let states: [String: Region]
}

struct Region: Decodable {
    let alertnow: Bool
    let changed: String
}
