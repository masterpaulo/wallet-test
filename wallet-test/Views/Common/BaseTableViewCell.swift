//
//  BaseTableViewCell.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import UIKit

protocol CellRepresentable {
    var cellIdentifier: String { get }
}

class BaseTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func configure(representable: CellRepresentable) {
        preconditionFailure("This method must be overridden")
    }
}
