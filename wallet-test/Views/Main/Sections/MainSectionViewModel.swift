//
//  MainSectionViewModel.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import Foundation
import Combine
import UIKit

/// Abstraction layer for main view sections view model
class MainSectionViewModel {
    
    unowned var mainViewModel: MainViewModel?
    var requestLoader = RequestLoader()
    
    // MARK: - init
    
    init(_ mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
    // MARK: - Absctract Parameters
    
    var sectionTitle: String { preconditionFailure("Title not provided for section") }
    var cellIdentifier: String { preconditionFailure("CellIdentifier not provided for section") }
    var numberOfItems: Int { preconditionFailure("Number of items not provided for section") }
    var cellHeight: CGFloat { return 70.0 }
    var sectionHeight: CGFloat { return 80.0 }
    
    // MARK: - Absctract Methods
    
    func load() {}
    func selectItem(at index: Int) { }
    func cellViewModels() -> [CellRepresentable] {
        preconditionFailure("Must override cell view models")
    }
    
    
    // MARK: - Default Cell View Models
    
    func viewModels() -> [CellRepresentable] {
        switch requestLoader.loadingState.value {
        case .loaded:
            return cellViewModels()
        case .error(let error):
            return [errorCellViewModel(error: error)]
        default:
            return [loadingCellViewModel()]
        }
    }
    
    func errorCellViewModel(error: RequestLoaderError) -> CellRepresentable {
        let errorCellVM = LoadingCellViewModel(
            loadingState: requestLoader.loadingState.value,
            title: "Something went wrong",
            description: error.description,
            reloadAction: {[weak self] in
                self?.load()
            })
        return errorCellVM
    }
    
    func loadingCellViewModel() -> CellRepresentable {
        let loadingCellVM = LoadingCellViewModel(
            loadingState: requestLoader.loadingState.value) { [weak self] in
            self?.load()
        }
        return loadingCellVM
    }
}
