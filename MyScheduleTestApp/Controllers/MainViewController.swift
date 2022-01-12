//
//  ViewController.swift
//  MyScheduleTestApp
//
//  Created by Roman Korobskoy on 11.01.2022.
//

import UIKit
import FSCalendar
import RealmSwift

class MainViewController: UIViewController {
    
    private var calendarHeightConstrain: NSLayoutConstraint!
    private let idScheduleCell = "idScheduleCell"
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    private let showHideCalendarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Открыть календарь", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let localRealm = try! Realm()
    var scheduleArray: Results<ScheduleModel>!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: idScheduleCell)
        scheduleOnDay(date: calendar.today!)
        setupNavBar()
        setupCalendar()
        setupButtonTarget()
        setupDelegateDataSource()
        setConstraints()
    }
    
    private func setupNavBar() {
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }
        navigationItem.title = "Расписание"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc private func addButtonTapped() {
        
        let addSchedule = AddNewScheduleViewController()
        navigationController?.pushViewController(addSchedule, animated: true)
    }
    
    @objc private func editingModel(scheduleModel: ScheduleModel) {
        
        let addSchedule = AddNewScheduleViewController()
        addSchedule.scheduleModel = scheduleModel
        addSchedule.editModel = true
        
        let dateFormatterHrs = DateFormatter()
        let dateFormatterDate = DateFormatter()
        dateFormatterHrs.dateFormat = "HH:mm"
        dateFormatterDate.dateFormat = "dd.MM.yyyy"
        
        addSchedule.cellNameArray = [[scheduleModel.scheduleName],
                                     [dateFormatterDate.string(from: scheduleModel.scheduleStartDate!),
                                      dateFormatterHrs.string(from: scheduleModel.scheduleStartTime!)],
                                     [dateFormatterDate.string(from: scheduleModel.scheduleFinishDate!),
                                      dateFormatterHrs.string(from: scheduleModel.scheduleFinishTime!)],
                                     [scheduleModel.scheduleDescription]]
        
        navigationController?.pushViewController(addSchedule, animated: true)
    }
    
    private func setupCalendar() {
        calendar.scope = .week
//        calendar.select(calendar.today)
//        tableView.reloadData()
    }
    
    private func setupDelegateDataSource() {
        calendar.delegate = self
        calendar.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupButtonTarget() {
        showHideCalendarButton.addTarget(self, action: #selector(showHideCalendarButtonTapped), for: .touchUpInside)
    }
    
    @objc private func showHideCalendarButtonTapped() {
        
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideCalendarButton.setTitle("Скрыть календарь", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideCalendarButton.setTitle("Открыть календарь", for: .normal)
        }
    }
    
    private func scheduleOnDay(date: Date) {
        
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        let predicate = NSPredicate(format: "scheduleStartDate BETWEEN %@", [dateStart, dateEnd])
        
        scheduleArray = localRealm.objects(ScheduleModel.self).filter(predicate).sorted(byKeyPath: "scheduleStartTime")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editingRow = scheduleArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completionHandler in
            RealmManager.shared.deleteScheduleModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = scheduleArray[indexPath.row]
        editingModel(scheduleModel: model)
    }
}

// MARK: - Extensions

// MARK: UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idScheduleCell, for: indexPath) as! ScheduleCell
        let model = scheduleArray[indexPath.row]
        cell.configureCell(model: model)
        cell.backgroundColor = #colorLiteral(red: 0.959415853, green: 0.9599340558, blue: 0.9751341939, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
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
        scheduleOnDay(date: date)
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

