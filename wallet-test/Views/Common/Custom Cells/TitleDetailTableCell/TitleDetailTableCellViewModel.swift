//
//  TitleDetailTableViewModel.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import Foundation

class TitleDetailTableViewModel: CellRepresentable {
    
    var cellIdentifier: String { return "TitleDetailTableCell" }
    
    var title: String
    var detail: String
    
    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }
    
}
