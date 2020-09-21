//
//  DetailedAccountData.swift
//  Gitty
//
//  Created by DIMa on 20/09/2020.
//  Copyright © 2020 DIMa. All rights reserved.
//

import Foundation

struct DetailedAccountData: Decodable {
    let login: String
    let avatar_url: String
    let repos_url: String
    let name: String
    let location: String
    let created_at: String
}

struct Repo:Decodable {
    let name: String
    let language: String?
    let updated_at: String
    let stargazers_count: Int
}
