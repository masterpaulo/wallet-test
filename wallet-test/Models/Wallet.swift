//
//  Wallet.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import Foundation

class WalletList: Codable {
    var items: [Wallet]
    
    private enum CodingKeys : String, CodingKey {
        case items = "wallets"
    }
}

class Wallet: Codable {
    
    var id: String
    var name: String
    var balance: String
    
    private enum CodingKeys : String, CodingKey {
        case id
        case name = "wallet_name"
        case balance
    }
}
