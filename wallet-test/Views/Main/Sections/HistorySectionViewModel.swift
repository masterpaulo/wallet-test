//
//  HistorySectionViewModel.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import Foundation
import UIKit

class HistorySectionViewModel: MainSectionViewModel {
    
    var historyList: [HistoryItem] = []
    
    // MARK: - Parameters
    
    override var sectionTitle: String { "History" }
    
    override var cellHeight: CGFloat {
        switch requestLoader.loadingState.value {
        case .loaded: return UITableView.automaticDimension
        default: return 320
        }
    }
    
    override var numberOfItems: Int {
        viewModels().count
    }
    
    // MARK: - Methods
    
    override func load() {
        loadHistoryList()
    }
    
    override func selectItem(at index: Int) {
        guard let item = historyList[safe: index] else { return }
        mainViewModel?.showHistory(item: item)
    }
    
    // MARK: - Setup View Models
    
    override func cellViewModels() -> [CellRepresentable] {
        let itemVMs = historyList.map { item -> TransactionDetailTableCellViewModel in
            var title = ""
            var amount = item.amount
            switch item.entry {
            case .incoming:
                title = "Received payment from \(item.sender)"
            case .outgoing:
                title = "Sent payment to \(item.recipient)"
                amount = "-\(amount)"
            case .cashIn:
                title = "You've cashed in from \(item.sender)"
            case .cashOut:
                title = "You've cashed out to \(item.recipient)"
                amount = "-\(amount)"
            }
            amount += " \(item.currency)"
            return TransactionDetailTableCellViewModel(title: title, amount: amount)
        }
        return itemVMs
    }
    
}

// MARK: - Network Connections

extension HistorySectionViewModel {
    func loadHistoryList() {
        requestLoader.getHistories { [weak self] result in
            switch result {
            case .success(let list):
                self?.historyList = list.items
            case .failure:
                self?.historyList = []
            }
        }
    }
}
