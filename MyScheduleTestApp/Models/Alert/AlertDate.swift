//
//  AlertDate.swift
//  MyScheduleTestApp
//
//  Created by Roman Korobskoy on 11.01.2022.
//

import UIKit

extension UIViewController {
    
    func alertDate(label: UILabel, completionHandler: @escaping (Date) -> Void) {
        
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        alert.view.addSubview(datePicker)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { action in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormatter.string(from: datePicker.date)
            
            //получаем значение дня недели для будущих возможных доработок
//            let calendar = Calendar.current
//            let component = calendar.dateComponents([.weekday], from: datePicker.date)
//
//            guard let weekday = component.weekday else { return }
//            let numberWeekday = weekday
            //
            let date = datePicker.date
            completionHandler(date)
            
            label.text = dateString
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        
        present(alert, animated: true, completion: nil)
    }
}

