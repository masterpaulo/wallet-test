//
//  BaseTableViewModel.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//


import Foundation
import UIKit

protocol BaseTableViewModelProtocol {
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func titleForSection(_ section: Int) -> String
    func heightForSection(_ section: Int) -> CGFloat
    func heightForCell(at indexPath: IndexPath) -> CGFloat
    func selectItem(at indexPath: IndexPath)
    
    func cellViewModel(at indexPath: IndexPath) -> CellRepresentable
}
