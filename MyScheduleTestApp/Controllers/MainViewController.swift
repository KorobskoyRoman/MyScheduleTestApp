//
//  ViewController.swift
//  MyScheduleTestApp
//
//  Created by Roman Korobskoy on 11.01.2022.
//

import UIKit
import FSCalendar

class MainViewController: UIViewController {
    
    var calendarHeightConstrain: NSLayoutConstraint!
    let idScheduleCell = "idScheduleCell"
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    let showHideCalendarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Открыть календарь", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavBar()
        setupCalendar()
        setupButtonTarget()
        setupDelegate()
        setConstraints()
        
    }
    
    private func setupNavBar() {
        navigationItem.title = "Расписание"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc func addButtonTapped() {
        
        let addSchedule = AddNewScheduleViewController()
        navigationController?.pushViewController(addSchedule, animated: true)
    }
    
    private func setupCalendar() {
        calendar.scope = .week
    }
    
    private func setupDelegate() {
        calendar.delegate = self
        calendar.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: idScheduleCell)
    }
    
    private func setupButtonTarget() {
        showHideCalendarButton.addTarget(self, action: #selector(showHideCalendarButtonTapped), for: .touchUpInside)
    }
    
    @objc func showHideCalendarButtonTapped() {
        
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideCalendarButton.setTitle("Скрыть календарь", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideCalendarButton.setTitle("Открыть календарь", for: .normal)
        }
    }
}

// MARK: - Extensions

// MARK: UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idScheduleCell, for: indexPath) as! ScheduleCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: FSCalendar

extension MainViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    //меняем высоту календаря
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstrain.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
}

// MARK: setConstraints
extension MainViewController {
    
    func setConstraints() {
        
        view.addSubview(calendar)
        
        calendarHeightConstrain = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstrain)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        view.addSubview(showHideCalendarButton)
        NSLayoutConstraint.activate([
            showHideCalendarButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideCalendarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHideCalendarButton.widthAnchor.constraint(equalToConstant: 150),
            showHideCalendarButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHideCalendarButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

