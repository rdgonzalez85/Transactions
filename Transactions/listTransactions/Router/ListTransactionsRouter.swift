//
//  ListTransactionsRouter.swift
//  Transactions
//
//  Created by Rodrigo Gonzalez on 25/06/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import UIKit

class ListTransactionsRouter: NSObject {
    static let storyboardName = "Main"
    
    // get the initial viewController for listTransactions
    static func mainViewController() -> UIViewController {
        
        guard let endpointURL = self.getURL() else {
            Swift.print("need to set the endpoint URL")
            return UIViewController()
        }
        
        if let viewController = UIStoryboard.storyboard(name: storyboardName, viewController: ListTransactionsViewController.identifier) as? ListTransactionsViewController {
            let provider = ListTransactionsNetworkProvider()
            provider.endpointURL = endpointURL
            
            let interactor = ListTransactionsInteractor()
            interactor.provider = provider
            
            let presenter = ListTransactionsPresenter()
            presenter.interactor = interactor
            presenter.delegate = viewController
            
            viewController.presenter = presenter
            
            return viewController
        }
        
        return UIViewController()
    }
    
    // get the url from the Info.plist file
    static let fileName = "Info"
    static let fileExtension = "plist"
    static let endpointURLKey = "endpointURL"
    
    static func getURL() -> String? {
        if let fileUrl = Bundle.main.url(forResource: fileName, withExtension: fileExtension),
            let data = try? Data(contentsOf: fileUrl) {
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
                return result?[endpointURLKey] as? String
            }
        }
        return nil
    }
}

// extension to load UIViewControllers from UIStoryboard
extension UIStoryboard {
    class func storyboard(name: String, viewController: String) -> UIViewController {
        return UIStoryboard.init(name: name, bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
}
