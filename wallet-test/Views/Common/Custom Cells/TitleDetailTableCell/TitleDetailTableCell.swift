//
//  TitleDetailTableCell.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import UIKit

class TitleDetailTableCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func configure(representable: CellRepresentable) {
        guard let representable = representable as? TitleDetailTableViewModel else { return }
        
        titleLabel.text = representable.title
        detailLabel.text = representable.detail
    }
}

