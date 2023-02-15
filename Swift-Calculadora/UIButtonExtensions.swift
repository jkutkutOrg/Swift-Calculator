//
//  UIButtonExtensions.swift
//  Swift-Calculadora
//
//  Created by Usuario invitado on 15/2/23.
//

import Foundation
import UIKit

extension UIButton {
    
    func select() {
        self.configuration?.background.backgroundColor = .white;
        self.configuration?.baseForegroundColor = .orange;
    }
    func unselect() {
        self.configuration?.background.backgroundColor = .orange;
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
}
