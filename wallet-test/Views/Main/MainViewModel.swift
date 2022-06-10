//
//  MainViewModel.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import Foundation
import Combine
import UIKit

protocol MainViewModelViewDelegate {
    func updateView()
    func showHistoryDetails(viewModel: HistoryDetailsViewModel)
}

class MainViewModel {
    var viewDelegate: MainViewModelViewDelegate?
    
    var sectionViewModels: [MainSectionViewModel] = []
    
    var subscriptions = [AnyCancellable]()
    
    // MARK: - init
    
    init() {
        setupSectionViewModels()
        bindSectionViewModels()
    }
    
    // MARK: - Setup
    
    func setupSectionViewModels() {
        sectionViewModels = [
            WalletSectionViewModel(self),
            HistorySectionViewModel(self)
        ]
    }
    
    func bindSectionViewModels() {
        sectionViewModels.forEach { sectionVM in
            sectionVM.requestLoader.loadingState
                .receive(on: DispatchQueue.main)
                .sink { loadingState in
                    if case .error = loadingState {
                        
                    }
                    self.viewDelegate?.updateView()
                }
                .store(in: &subscriptions)
        }
    }
    
    func loadData() {
        sectionViewModels.forEach { $0.load() }
    }
    
    // MARK: - Methods
    
    func showHistory(item: HistoryItem) {
        self.viewDelegate?.showHistoryDetails(viewModel: HistoryDetailsViewModel(historyItem: item))
    }
    
}

// MARK: - BaseTableViewModelProtocol

extension MainViewModel: BaseTableViewModelProtocol {
    func titleForSection(_ section: Int) -> String {
        return sectionViewModels[section].sectionTitle
    }
    
    func numberOfSections() -> Int {
        return sectionViewModels.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return sectionViewModels[section].numberOfItems
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CellRepresentable {
        return sectionViewModels[indexPath.section].viewModels()[indexPath.item]
    }
    
    func heightForSection(_ section: Int) -> CGFloat {
        return sectionViewModels[section].sectionHeight
    }
    
    func heightForCell(at indexPath: IndexPath) -> CGFloat {
        return sectionViewModels[indexPath.section].cellHeight
    }
    
    func selectItem(at indexPath: IndexPath) {
        sectionViewModels[indexPath.section].selectItem(at: indexPath.item)
    }
}
