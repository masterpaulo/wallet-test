//
//  MainViewController.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import UIKit

class MainViewController: BaseTableViewController {
 
    var vm: MainViewModel = MainViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
        
        vm.viewDelegate = self
        
        vm.loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        refreshControl?.superview?.sendSubviewToBack(refreshControl!)
    }
    
    // MARK: - Setup
    
    /// View related configuration
    func setupViews() {
        refreshControl?.tintColor = .white
        refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    override func registerCells() {
        tableView.register(UINib(nibName: "LoadingTableCell", bundle: nil), forCellReuseIdentifier: "LoadingTableCell")
        tableView.register(UINib(nibName: "TitleDetailTableCell", bundle: nil), forCellReuseIdentifier: "TitleDetailTableCell")
        tableView.register(UINib(nibName: "TransactionDetailTableCell", bundle: nil), forCellReuseIdentifier: "TransactionDetailTableCell")
    }
    
    // MARK: - Actions
    
    @objc func refresh(_ sender: AnyObject) {
        vm.loadData()
    }
}

// MARK: Bind View Model

extension MainViewController {
    func bindViewModel() {
        
    }
}

// MARK: MainViewModelViewDelegate

extension MainViewController: MainViewModelViewDelegate {
    func updateView() {
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    func showHistoryDetails(viewModel: HistoryDetailsViewModel) {
        let vc = HistoryDetailsViewController.instantiate(fromAppStoryboard: .main)
        vc.vm = viewModel
        self.present(vc, animated: true)
    }
}


// MARK: UITableViewDelegate & UITableViewDataSource

extension MainViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return vm.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRowsInSection(section: section)
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = vm.titleForSection(section)
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 32, weight: .light)
        return titleLabel
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = vm.cellViewModel(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellIdentifier, for: indexPath) as! BaseTableViewCell
        
        cell.configure(representable: cellVM)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return vm.heightForSection(section)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vm.heightForCell(at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.selectItem(at: indexPath)
    }
}


