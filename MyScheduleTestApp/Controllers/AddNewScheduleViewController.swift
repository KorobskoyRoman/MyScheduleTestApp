//
//  AddNewScheduleViewController.swift
//  MyScheduleTestApp
//
//  Created by Roman Korobskoy on 11.01.2022.
//

import UIKit

class AddNewScheduleViewController: UITableViewController {
    
    let idNewSchedule = "idNewSchedule"
    let idNewScheduleHeader = "idNewScheduleHeader"
    
    let headerNameArray = ["НАЗВАНИЕ", "ДАТА И ВРЕМЯ НАЧАЛА", "ДАТА И ВРЕМЯ КОНЦА", "ОПИСАНИЕ"]
    let cellNameArray = [["Название"],
                         ["Число", "Время"],
                         ["Число", "Время"],
                         ["Описание"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        tableView.register(NewScheduleCell.self, forCellReuseIdentifier: idNewSchedule)
        tableView.register(HeaderNewScheduleCell.self, forHeaderFooterViewReuseIdentifier: idNewScheduleHeader)
        tableView.bounces = false
        title = "Добавление"
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
        case [0,0]: alertCell(label: cell.nameCellLabel, name: "Название", placeholder: "Введите название...")
        case [1,0]: alertDate(label: cell.nameCellLabel) { date in
            print(date)
        }
        case [1,1]: alertTime(label: cell.nameCellLabel) { date in
            print(date)
        }
        case [2,0]: alertDate(label: cell.nameCellLabel) { date in
            print(date)
        }
        case [2,1]: alertTime(label: cell.nameCellLabel) { date in
            print(date)
        }
        case [3,0]: alertCell(label: cell.nameCellLabel, name: "Описание", placeholder: "Введите описание...")
        default:
            print("error")
        }
    }
}
