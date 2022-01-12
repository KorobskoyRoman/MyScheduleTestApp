//
//  ScheduleCell.swift
//  MyScheduleTestApp
//
//  Created by Roman Korobskoy on 11.01.2022.
//

import UIKit

class ScheduleCell: UITableViewCell {
    
    let id = UILabel(text: "", font: UIFont(name: "Apple SD Gothic Neo Bold", size: 20), alignment: .left, adjustsFontSizeToFitWidth: true)
    
    let dateStart = UILabel(text: "", font: UIFont(name: "Apple SD Gothic Neo Regular", size: 20), alignment: .left, adjustsFontSizeToFitWidth: true)
    
    let dateFinish = UILabel(text: "", font: UIFont(name: "Apple SD Gothic Neo Regular", size: 20), alignment: .left, adjustsFontSizeToFitWidth: true)
    
    let caseName = UILabel(text: "", font: UIFont(name: "Apple SD Gothic Neo Bold", size: 20), alignment: .left, adjustsFontSizeToFitWidth: false)
    
    let dateStartLabel = UILabel(text: "с:", font: UIFont(name: "Apple SD Gothic Neo Regular", size: 18), alignment: .right, adjustsFontSizeToFitWidth: true)
    
    let dateFinishLabel = UILabel(text: "до:", font: UIFont(name: "Apple SD Gothic Neo Regular", size: 18), alignment: .right, adjustsFontSizeToFitWidth: true)

    let caseDescription: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 14)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(model: ScheduleModel) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        dateStart.text = dateFormatter.string(from: model.scheduleStartTime)
        dateFinish.text = dateFormatter.string(from: model.scheduleFinishTime)
        caseName.text = model.scheduleName
        caseDescription.text = model.scheduleDescription
    }

    private func setConstraints() {
        
        let topStackView = UIStackView(arrangedSubviews: [id, caseName, dateStartLabel, dateStart, dateFinishLabel, dateFinish], axis: .horizontal, spacing: 10, distribution: .fill)
        let botStackView = UIStackView(arrangedSubviews: [caseDescription], axis: .horizontal, spacing: 10, distribution: .fillEqually)

        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        self.addSubview(botStackView)
        NSLayoutConstraint.activate([
            botStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: frame.height / 2 - 10),
            botStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            botStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
}

