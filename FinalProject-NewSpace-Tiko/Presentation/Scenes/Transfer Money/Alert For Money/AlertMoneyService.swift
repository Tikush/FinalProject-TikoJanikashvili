//
//  AlertMoneyService.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit

class AlertMoneyService {
    func alert(money: String)-> AlertMoneyViewController {
        let storyboard = UIStoryboard(name: "AlertMoneyViewController", bundle: nil)
        let vcAlert = storyboard.instantiateViewController(withIdentifier: "AlertMoneyViewController") as! AlertMoneyViewController
        vcAlert.getMoney = money
        return vcAlert
    }
}
