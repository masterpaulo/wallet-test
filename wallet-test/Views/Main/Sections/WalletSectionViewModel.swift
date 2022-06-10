//
//  WalletSectionViewModel.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import Foundation
import UIKit

class WalletSectionViewModel: MainSectionViewModel {
    
    var walletList: [Wallet] = []
    
    // MARK: - Parameters
    
    override var sectionTitle: String { "My Wallets" }
    
    override var cellHeight: CGFloat {
        switch requestLoader.loadingState.value {
        case .loaded: return super.cellHeight
        default: return 180
        }
    }
    
    override var numberOfItems: Int {
        viewModels().count
    }
    
    // MARK: - Methods
    
    override func load() {
        loadWalletList()
    }
    
    override func selectItem(at index: Int) {
        // do nothing
    }
    
    // MARK: - Setup View Models
    
    override func cellViewModels() -> [CellRepresentable] {
        let itemVMs = walletList.map { item -> TitleDetailTableViewModel in
            let title = item.name
            let amount = item.balance
            return TitleDetailTableViewModel(title: title , detail: amount)
        }
        return itemVMs
    }
    
}

// MARK: - Network Connections

extension WalletSectionViewModel {
    func loadWalletList() {
        requestLoader.getWallets { [weak self] result in
            switch result {
            case .success(let list):
                self?.walletList = list.items
            case .failure:
                self?.walletList = []
            }
        }
    }
}
