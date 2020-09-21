//
//  AccountModel.swift
//  Gitty
//
//  Created by DIMa on 18.09.2020.
//  Copyright © 2020 DIMa. All rights reserved.
//

import Foundation

struct AccountModel: Decodable {
    let login: String
    let type: String
    let avatarURL: String
}
