//
//  HistoryDetailsViewController.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import UIKit

class HistoryDetailsViewController: UIViewController {
    
    var vm: HistoryDetailsViewModel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var recipientLabel: UILabel!
    @IBOutlet weak var paymentChannelLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var senderSectionView: UIView!
    @IBOutlet weak var recipientSectionView: UIView!
    @IBOutlet weak var paymentChannelSectionView: UIView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }
    
    // MARK: - Setup
    
    func setupData() {
        iconImageView.image = vm.iconImage
        
        summaryLabel.text = vm.summaryText
        senderLabel.text = vm.senderText
        recipientLabel.text = vm.recipientText
        paymentChannelLabel.text = vm.paymentChannelText
        
        senderSectionView.isHidden = !vm.showSenderLabel
        recipientSectionView.isHidden = !vm.showRecipientLabel
        paymentChannelSectionView.isHidden = !vm.showPaymentChannelLabel
        
        amountLabel.text = vm.amountText
    }
    
    // MARK: - Actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
