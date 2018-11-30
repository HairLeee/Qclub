//
//  String.swift
//  QClub
//
//  Created by SMR on 11/21/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

extension String {
    func toLoginDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: self) ?? Date()
    }
}
