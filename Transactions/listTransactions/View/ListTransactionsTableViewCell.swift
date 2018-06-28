//
//  ListTransactionsTableViewCell.swift
//  Transactions
//
//  Created by Rodrigo Gonzalez on 6/26/18.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import UIKit

// Cell used for displaying Transactions
class ListTransactionsTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    static let identifier = "ListTransactionsTableViewCell"
    
    func setTransactionData(_ data: TransactionData?) {
        title.text = data?.title
        date.text = data?.date
        amount.text = data?.amount
    }

}
