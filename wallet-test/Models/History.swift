//
//  History.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import Foundation

enum EntryType: String, Codable {
    case incoming = "incoming"
    case outgoing = "outgoing"
    case cashIn = "cash-in"
    case cashOut = "cash-out"
}

struct HistoryList: Codable {
    var items: [HistoryItem]
    
    private enum CodingKeys : String, CodingKey {
        case items = "histories"
    }
}

struct HistoryItem: Codable {
    var id: String
    var entry: EntryType
    var amount: String
    var currency: String
    var sender: String
    var recipient: String
}
