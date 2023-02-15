//
//  UIButtonExtensions.swift
//  Swift-Calculadora
//
//  Created by Jkutkut and Alexeses on 15/2/23.
//

import Foundation
import UIKit

extension UIButton {
    
    func select() {
        self.configuration?.background.backgroundColor = .white;
        self.configuration?.baseForegroundColor = UIColor.systemOrange;
    }
    func unselect() {
        self.configuration?.background.backgroundColor = UIColor.systemOrange;
        self.configuration?.baseForegroundColor = .white;
    }
    
    func shine() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5;
        }) {(completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1;
            })
        }
    }
    
    func isSelected() -> Bool {
        return self.configuration?.background.backgroundColor == .white;
    }
}
