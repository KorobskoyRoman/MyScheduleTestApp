//
//  AlertCell.swift
//  MyScheduleTestApp
//
//  Created by Roman Korobskoy on 12.01.2022.
//

import UIKit

extension UIViewController {
    
    func alertCell(label: UILabel, name: String, placeholder: String) {
        
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default) { action in
            let alertTf = alert.textFields?.first
            guard let text = alertTf?.text else { return }
            label.text = text
        }
        
        alert.addTextField { alertTf in
            alertTf.placeholder = placeholder
        }
        
        let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }
}
