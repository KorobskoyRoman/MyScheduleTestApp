//
//  AddNewScheduleViewController.swift
//  MyScheduleTestApp
//
//  Created by Roman Korobskoy on 11.01.2022.
//

import UIKit
import RealmSwift

class AddNewScheduleViewController: UITableViewController {
    
    private let idNewSchedule = "idNewSchedule"
    private let idNewScheduleHeader = "idNewScheduleHeader"
    var scheduleModel = ScheduleModel()
    var editModel = false
    
    var scheduleStartDate: Date?
    var scheduleStartTime: Date?
    var scheduleFinishDate: Date?
    var scheduleFinishTime: Date?
    
    
    let headerNameArray = ["НАЗВАНИЕ", "ДАТА И ВРЕМЯ НАЧАЛА", "ДАТА И ВРЕМЯ КОНЦА", "ОПИСАНИЕ"]
    var cellNameArray = [["Название"], ["Число", "Время"], ["Число", "Время"], ["Описание"]]
//    var cellNameArray = ["Название", "Число", "Время", "Число", "Время", "Описание"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        tableView.register(NewScheduleCell.self, forCellReuseIdentifier: idNewSchedule)
        tableView.register(HeaderNewScheduleCell.self, forHeaderFooterViewReuseIdentifier: idNewScheduleHeader)
        tableView.bounces = false
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        title = "Добавление"
        print(scheduleModel)
    }
    
//    @objc private func saveButtonTapped() {
//
//        if cellNameArray[0] == ["Название"] ||
//            cellNameArray[1] == ["\(scheduleModel.scheduleStartTime!)"] ||
//            cellNameArray[2] == ["\(scheduleModel.scheduleFinishTime!)"]
////            scheduleModel.scheduleStartDate == nil || scheduleModel.scheduleFinishDate == nil
//            {
//            alertOk(title: "Ошибка сохранения!", message: "Необходимо заполнить дату и название!")
//        } else if editModel == false {
//            setModel()
//            RealmManager.shared.saveScheduleModel(model: scheduleModel)
//            scheduleModel = ScheduleModel() //обновляем модель для изменения данных из БД в реальном времени
//            alertOk(title: "Успешно сохранено", message: nil)
//
//            tableView.reloadRows(at: [[0,0], [1,0], [1,1], [2,0], [2,1], [3,0]], with: .fade)
//        } else {
//            RealmManager.shared.updateScheduleModel(model: scheduleModel, nameArray: cellNameArray, scheduleStartDate: scheduleStartDate, scheduleStartTime: scheduleStartTime, scheduleFinishDate: scheduleFinishDate, scheduleFinishTime: scheduleFinishTime)
//        }
//    }
    
    private func setModel() {
        
        scheduleModel.scheduleName = cellNameArray[0][0]
        scheduleModel.scheduleStartDate = scheduleStartDate
        scheduleModel.scheduleStartTime = scheduleStartTime
        scheduleModel.scheduleFinishDate = scheduleFinishDate
        scheduleModel.scheduleFinishTime = scheduleFinishTime
        scheduleModel.scheduleDescription = cellNameArray[3][0]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 2
        case 2: return 2
        case 3: return 1
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idNewSchedule", for: indexPath) as! NewScheduleCell
        cell.cellScheduleConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idNewScheduleHeader) as! HeaderNewScheduleCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! NewScheduleCell
        switch indexPath {
        case [0,0]:
            alertCell(label: cell.nameCellLabel, name: "Название", placeholder: "Введите название...") { text in
//                self.scheduleModel.scheduleName = text
                self.cellNameArray[0][0] = text
        }
        case [1,0]:
            alertDate(label: cell.nameCellLabel) { date in
//            self.scheduleModel.scheduleStartDate = date
                self.cellNameArray[1][0] = "\(date)"
                
            }
        case [1,1]:
            alertTime(label: cell.nameCellLabel) { time in
//            self.scheduleModel.scheduleStartTime = time
                self.cellNameArray[1][1] = "\(time)"
        }
        case [2,0]:
            alertDate(label: cell.nameCellLabel) { date in
//            self.scheduleModel.scheduleFinishDate = date
                self.cellNameArray[2][0] = "\(date)"
        }
        case [2,1]:
            alertTime(label: cell.nameCellLabel) { time in
//            self.scheduleModel.scheduleFinishTime = time
                self.cellNameArray[2][1] = "\(time)"
        }
        case [3,0]:
            alertCell(label: cell.nameCellLabel, name: "Описание", placeholder: "Введите описание...") { text in
//                self.scheduleModel.scheduleDescription = text
                self.cellNameArray[3][0] = text
        }
        default:
            print("error")
        }
    }
}
