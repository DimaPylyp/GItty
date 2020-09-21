//
//  ViewModel.swift
//  Gitty
//
//  Created by DIMa on 17.09.2020.
//  Copyright © 2020 DIMa. All rights reserved.
//

import Foundation

final class ViewModel {
    
    private var manager = AccountsManager()
    
    private(set) var items = [AccountModel]()
    
    func sortAsc() {
        items.sort (by: { $0.login > $1.login })
    }

    func sortDec() {
        items.sort (by: { $0.login < $1.login })
    }
    
    func searchForAccounts(named keyword:String, completion: @escaping ()->()) {
        manager.performRequest(with: Routes.users(keyword: keyword), complition: { recievedItems in
            if let recievedItems = recievedItems {
                self.items = recievedItems as! [AccountModel]
                completion()
            }
        })
    }
}
