//
//  AccountData.swift
//  Gitty
//
//  Created by DIMa on 18.09.2020.
//  Copyright © 2020 DIMa. All rights reserved.
//

import Foundation

struct AccountData: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let login: String
    let avatar_url: String
    let type: String
}
