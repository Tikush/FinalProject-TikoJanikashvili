//
//  UIVewController+Extension.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 18.07.21.
//

import UIKit

extension UIViewController {
    func dismissKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
    
    func currentTime() -> String {
        let date = Date()
        var calendar = Calendar.current
        if let timeZone = TimeZone(identifier: "GMT+4") {
           calendar.timeZone = timeZone
        }
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        return "\(hour):\(minute)"
    }
}
