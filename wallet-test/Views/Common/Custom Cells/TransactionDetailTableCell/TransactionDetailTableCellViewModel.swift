//
//  TransactionDetailTableCellViewModel.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import Foundation
import UIKit

class TransactionDetailTableCellViewModel: CellRepresentable {
    
    var cellIdentifier: String { return "TransactionDetailTableCell" }
    
    var title: String
    var amount: String
    
    init(title: String, amount: String) {
        self.title = title
        self.amount = amount
    }
    
}

extension TransactionDetailTableCellViewModel {
    var isAmountNegative: Bool {
        self.amount.hasPrefix("-")
    }
}
