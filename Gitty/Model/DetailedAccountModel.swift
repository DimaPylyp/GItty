//
//  DetailedAccountModel.swift
//  Gitty
//
//  Created by DIMa on 20/09/2020.
//  Copyright © 2020 DIMa. All rights reserved.
//

import Foundation

struct DetailedAccountModel: Decodable {
    let login: String
    let avatarUrl: String
    let repos: [Repo]
    let name: String
    let location: String?
    let createdAt: String
}
