//
//  String+LocalizedValue.swift
//  Artworks
//
//  Created by Muhammad Adam on 27/12/2021.
//

import Foundation

extension String{
    var localizedValue: String{
        return NSLocalizedString(self, comment: "")
    }
}
