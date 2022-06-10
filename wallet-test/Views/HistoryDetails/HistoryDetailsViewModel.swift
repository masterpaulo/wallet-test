//
//  HistoryDetailsViewModel.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import Foundation
import UIKit

class HistoryDetailsViewModel {
    
    let historyItem: HistoryItem
    
    // MARK: - init
    
    init(historyItem: HistoryItem) {
        self.historyItem = historyItem
    }
    
}

// MARK: - Display properties

extension HistoryDetailsViewModel {
    var summaryText: String {
        switch historyItem.entry {
        case .incoming:
            return "Received \(amountText) from \(historyItem.sender)"
        case .outgoing:
            return "Sent \(amountText) to \(historyItem.recipient)"
        case .cashIn:
            return "You've cashed in \(amountText) from \(historyItem.sender)"
        case .cashOut:
            return "You've cashed out \(amountText) to \(historyItem.recipient)"
        }
    }
    var senderText: String { historyItem.sender }
    var recipientText: String { historyItem.recipient }
    var paymentChannelText: String {
        switch historyItem.entry {
        case .cashOut: return historyItem.recipient
        case .cashIn: return historyItem.sender
        default: return ""
        }
    }
    
    var iconImage: UIImage? {
        switch historyItem.entry {
        case .incoming, .cashIn:
            return UIImage(systemName: "arrow.down.left.circle.fill")
        case .outgoing, .cashOut:
            return UIImage(systemName: "arrow.up.right.circle.fill")
        }
    }
    
    var showSenderLabel: Bool { historyItem.entry == .incoming }
    var showRecipientLabel: Bool { historyItem.entry == .outgoing }
    var showPaymentChannelLabel: Bool { historyItem.entry == .cashIn || historyItem.entry == .cashOut }
    
    var amountText: String { "\(historyItem.amount) \(historyItem.currency)" }
}
