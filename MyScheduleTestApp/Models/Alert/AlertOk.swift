//
//  AlertOk.swift
//  MyScheduleTestApp
//
//  Created by Roman Korobskoy on 12.01.2022.
//

import UIKit

extension UIViewController {
    
    func alertOk(title: String, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let actionOk = UIAlertAction(title: "OK", style: .default) { _ in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        alert.addAction(actionOk)
        
        present(alert, animated: true, completion: nil)
    }
}
