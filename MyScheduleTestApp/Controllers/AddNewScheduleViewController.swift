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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        tableView.register(NewScheduleCell.self, forCellReuseIdentifier: idNewSchedule)
        tableView.register(HeaderNewScheduleCell.self, forHeaderFooterViewReuseIdentifier: idNewScheduleHeader)
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
        cell.cellConfigure(indexPath: indexPath)
//        cell.textLabel?.text = "cell \(indexPath)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idNewScheduleHeader) as! HeaderNewScheduleCell
        header.headerConfigure(section: section)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
