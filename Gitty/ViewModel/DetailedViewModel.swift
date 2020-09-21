//
//  DetailedViewModel.swift
//  Gitty
//
//  Created by DIMa on 20/09/2020.
//  Copyright © 2020 DIMa. All rights reserved.
//

import Foundation

final class DetailedViewModel {
    
    private var manager = AccountsManager()
    
    private(set) var item: DetailedAccountModel?
        
    func searchForAccount(named username:String, completion: @escaping ()->()) {
        manager.performRequest(with: Routes.item(username: username), complition: { recievedItems in
            if let recievedItems = recievedItems {
                self.item = recievedItems as? DetailedAccountModel
                completion()
            }
        })
    }
}
