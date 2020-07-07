//
//  ManageEmployeeViewController.swift
//  timeTracking
//
//  Created by Robbie Barnes on 5/12/20.
//  Copyright © 2020 Robbie Barnes. All rights reserved.
//

import Foundation
import UIKit

class ManageEmployeeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DownloadEmployeesProtocol {
    
    
    var feedItems: [EmployeeModel] = []
    var selectedEmployee = EmployeeModel()
    
    @IBOutlet weak var employeeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.employeeTable.delegate = self
        self.employeeTable.dataSource = self
        
        let downloadEmployeesModel = DownloadEmployeesModel()
        downloadEmployeesModel.delegate = self
        downloadEmployeesModel.downloadItems()
    }
    
    func employeeItemsDownloaded(items: [EmployeeModel]) {
        feedItems = items
        self.employeeTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        let cellId: String = "employeeCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        let item: EmployeeModel = feedItems[indexPath.row]
        myCell.textLabel!.text = "\(item.active!)  -  \(item.first_name!) \(item.last_name!)"
        
        return myCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if let destination = segue.destination as? EditEmployeeViewController {
            destination.selectedEmployee = feedItems[(employeeTable.indexPathForSelectedRow?.row)!]
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let downloadEmployeesModel = DownloadEmployeesModel()
        downloadEmployeesModel.delegate = self
        downloadEmployeesModel.downloadItems()
    }
    
}
