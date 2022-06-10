//
//  LoadingTableCell.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import UIKit

class LoadingTableCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var reloadActionClosure: (()->Void)?
    
    override func configure(representable: CellRepresentable) {
        guard let representable = representable as? LoadingCellViewModel else { return }
        
        self.reloadActionClosure = representable.reloadAction
        
        switch representable.loadingState {
        case .loading:
            loadingIndicator.startAnimating()
            loadingIndicator.isHidden = false
            messageContainerView.isHidden = true
        default:
            loadingIndicator.isHidden = true
            messageContainerView.isHidden = false
        }
        
        titleLabel.text = representable.title
        messageLabel.text = representable.description
    }
    
    @IBAction func reloadButtonAction(_ sender: Any) {
        reloadActionClosure?()
    }
}

