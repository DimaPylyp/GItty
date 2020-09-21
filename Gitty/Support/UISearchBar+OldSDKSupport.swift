//
//  UISearchBar+OldSDKSupport.swift
//  Gitty
//
//  Created by DIMa on 17.09.2020.
//  Copyright © 2020 DIMa. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            for view: UIView in (self.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    return textField
                }
            }
        }
        return nil
    }
}
