//
//  TransactionDetailTableCell.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import UIKit

class TransactionDetailTableCell: BaseTableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func configure(representable: CellRepresentable) {
        guard let representable = representable as? TransactionDetailTableCellViewModel else { return }
        
        if representable.isAmountNegative {
            detailLabel.textColor = UIColor(named: "Red100")
            iconImageView.image = UIImage(systemName: "arrow.up.right")
        } else {
            detailLabel.textColor = UIColor(named: "Green100")
            iconImageView.image = UIImage(systemName: "arrow.down.left")
        }
        
        titleLabel.text = representable.title
        detailLabel.text = representable.amount
    }
}

