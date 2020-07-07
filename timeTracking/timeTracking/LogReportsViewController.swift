//
//  LogReportsViewController.swift
//  timeTracking
//
//  Created by Robbie Barnes on 5/13/20.
//  Copyright © 2020 Robbie Barnes. All rights reserved.
//

import Foundation
import UIKit

var userID = ""

class LogReportsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DownloadEmployeesProtocol, DownloadLogsProtocol {
    
    var employeeFeedItems: [EmployeeModel] = []
    var selectedEmployee = EmployeeModel()
    
    var logFeedItems: [LogModel] = []
    var selectedLog = LogModel()
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var employeeDropDown: UITableView!
    @IBOutlet weak var logTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeDropDown.delegate = self
        employeeDropDown.dataSource = self
        
        let downloadEmployeesModel = DownloadEmployeesModel()
        downloadEmployeesModel.delegate = self
        downloadEmployeesModel.downloadItems()
        
        logTableView.delegate = self
        logTableView.dataSource = self
        
        let downloadLogsModel = DownloadLogsModel()
        downloadLogsModel.delegate = self
        downloadLogsModel.downloadItems()
        
        self.employeeDropDown.isHidden = true
        self.logTableView.isHidden = true
    }
    
    func employeeItemsDownloaded(items: [EmployeeModel]) {
        employeeFeedItems = items
        self.employeeDropDown.reloadData()
    }
    
    func logItemsDownloaded(items: [LogModel]) {
        logFeedItems = items
        self.logTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == employeeDropDown {
            return employeeFeedItems.count
        }
        else {
            if logFeedItems.count == 0 {
                logTableView.isHidden = true
            }
            return logFeedItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == employeeDropDown {
            let cellId: String = "employeeCell"
            let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId)!
            let item: EmployeeModel = employeeFeedItems[indexPath.row]
            myCell.textLabel!.text = "\(item.active!)  -  \(item.first_name!) \(item.last_name!)"
            
            return myCell
        }
        else {
            let cellId: String = "logCell"
            let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId)!
            let item: LogModel = logFeedItems[indexPath.row]
            myCell.textLabel!.text = "\(item.start_datetime!)"
            
            return myCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == employeeDropDown {
            tableView.deselectRow(at: indexPath, animated: true)
            
            UIView.animate(withDuration: 0.5) {
                self.employeeDropDown.isHidden = true
            }
            
            selectedEmployee = employeeFeedItems[indexPath.row]
            
            button.setTitle("\(selectedEmployee.first_name!) \(selectedEmployee.last_name!)", for: .normal)
            
            if (button.currentTitle != "Select Employee") {
                
                userID = selectedEmployee.id!
                logTableView.isHidden = false
                logTableView.layer.borderColor = UIColor.black.cgColor
                logTableView.layer.borderWidth = 2.0
                
                let downloadLogsModel = DownloadLogsModel()
                downloadLogsModel.delegate = self
                downloadLogsModel.downloadItems()
            }
        }
        
        
        
    }
    
    @IBAction func selectEmployeeButton(_ sender: UIButton) {
        if (self.employeeDropDown.isHidden) {
            UIView.animate(withDuration: 0.5) {
                self.employeeDropDown.isHidden = false
                self.employeeDropDown.layer.borderColor = UIColor.black.cgColor
                self.employeeDropDown.layer.borderWidth = 2.0
                self.employeeDropDown.layer.zPosition = 100
            }
        }
        else {
            UIView.animate(withDuration: 0.5) {
                self.employeeDropDown.isHidden = true
            }
        }
        let downloadEmployeesModel = DownloadEmployeesModel()
        downloadEmployeesModel.delegate = self
        downloadEmployeesModel.downloadItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if let destination = segue.destination as? EditLogViewContoller {
            destination.selectedLog = logFeedItems[(logTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let downloadLogsModel = DownloadLogsModel()
        downloadLogsModel.delegate = self
        downloadLogsModel.downloadItems()
    }
}
