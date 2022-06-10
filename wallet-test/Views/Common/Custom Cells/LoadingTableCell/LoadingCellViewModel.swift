//
//  LoadingCellViewModel.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//


import Foundation

class LoadingCellViewModel: CellRepresentable {
    var cellIdentifier: String { return "LoadingTableCell" }
    
    var title: String
    var description: String
    
    var loadingState: RequestLoaderState = .idle
    var reloadAction: (() -> Void)?
    
    init(loadingState: RequestLoaderState, title: String = "", description: String = "", reloadAction: (()->Void)?) {
        self.loadingState = loadingState
        
        self.title = title
        self.description = description
        
        self.reloadAction = reloadAction
    }
}
