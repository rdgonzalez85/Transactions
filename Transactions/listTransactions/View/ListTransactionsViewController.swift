//
//  ListTransactionsViewController.swift
//  Transactions
//
//  Created by Rodrigo Gonzalez on 25/06/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import UIKit

class ListTransactionsViewController: UIViewController {
    static let identifier = "ListTransactionsViewController"
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: (ListTransactionsPresenterProtocol & ListTransactionsTableViewPresenterProtocol)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get the list of transactions
        presenter?.listTransactions()
        // TODO display an alert indicator
    }

}

extension ListTransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else {
            return 0
        }
        return presenter.numberOfItemsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTransactionsTableViewCell.identifier, for: indexPath) as? ListTransactionsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setTransactionData(presenter?.itemForIndexPath(indexPath))
        
        return cell
    }
    
}

// TODO hide the displayed alert indicator
extension ListTransactionsViewController: ListTransactionsPresenterDelegate {
    func showError(error: Error) {
        //TODO: display error
    }
    func dataReady() {
        tableView.reloadData()
    }
}

