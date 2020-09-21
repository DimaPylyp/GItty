//
//  AccountsManager.swift
//  Gitty
//
//  Created by DIMa on 18.09.2020.
//  Copyright © 2020 DIMa. All rights reserved.
//

import Foundation

enum Routes{
    case users (keyword: String)
    case item (username: String)
    case repos (url: String)
}

class AccountsManager {
    
    private let urlBase = "https://api.github.com/search/users"
    
    
    func performRequest(with url: Routes, complition: @escaping(Decodable?)->()) {
        switch url {
        case .users(let keyword):
            if let requestURL = URL(string: "https://api.github.com/search/users?q=\(keyword)") {
                URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
                    if error != nil{
                        print (error!)
                        return
                    }
                    
                    if let safeData = data {
                        if let accounts = self.parseJSON(safeData){
                            complition(accounts)
                        }
                    }
                }.resume()
            }
        case .item(let username):
            if let requestURL = URL(string: "https://api.github.com/users/\(username)") {
                URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
                    if error != nil{
                        print (error!)
                        return
                    }
                    
                    if let safeData = data {
                        self.parseItem(safeData){ user in
                            complition(user)
                        }
                    }
                }.resume()
            }
        case .repos(let url):
            if let requestURL = URL(string: "\(url)") {
                URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
                    if error != nil{
                        print (error!)
                        return
                    }
                    
                    if let safeData = data, let repos = self.parseRepos(safeData) {
                        complition(repos)
                    }
                }.resume()
            }
        }
    }
    
    private func parseItem(_ data: Data, completion: @escaping (DetailedAccountModel)->()) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DetailedAccountData.self, from: data)
            self.performRequest(with: Routes.repos(url: decodedData.repos_url)) { (repos) in
                completion(DetailedAccountModel(login: "\(decodedData.login)", avatarUrl: "\(decodedData.avatar_url)", repos: repos as! [Repo], name: "\(decodedData.name)", location: "\(decodedData.location)", createdAt: "\(decodedData.created_at)"))
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func parseRepos(_ data: Data) -> [Repo]? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode([Repo].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func parseJSON(_ accountsData: Data) -> [AccountModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData: AccountData = try decoder.decode(AccountData.self, from: accountsData)
            var accounts: [AccountModel] = []
            for account in decodedData.items {
                let avatarURL = account.avatar_url
                let login = account.login
                let type = account.type
                let account = AccountModel(login: login, type: type, avatarURL: avatarURL)
                accounts.append(account)
            }
            return accounts
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}



