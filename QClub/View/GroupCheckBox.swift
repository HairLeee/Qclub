//
//  GroupCheckBox.swift
//  QClub
//
//  Created by Dreamup on 11/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroupCheckBox {

    var checkboxs = [Checkbox]()
    
    func selectCheckBox(index: Int) {
        for i in 0...(checkboxs.count - 1) {
            checkboxs[i].isChecked = (i == index)
        }
    }
    
    func getSelectedCheckBox() -> Int? {
        for i in 0...(checkboxs.count - 1) {
            if checkboxs[i].isChecked {
                return i
            }
        }
        return nil
    }
    
}
