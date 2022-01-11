//
//  UILabel.swift
//  MyScheduleTestApp
//
//  Created by Roman Korobskoy on 11.01.2022.
//

import Foundation
import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, alignment: NSTextAlignment, adjustsFontSizeToFitWidth: Bool) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = .black
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
