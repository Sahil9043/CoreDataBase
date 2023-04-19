//
//  EmployeeListViewController.swift
//  CoreDataBase
//
//  Created by Lalaiya Sahil on 11/02/23.
//

import UIKit

class EmployeeListViewController: UIViewController {

    @IBOutlet weak var employeTableiew: UITableView!
    var arrStudent: [StudentDetails] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.text = "\(arrStudent[indexPath.row].id) \n \(arrStudent[indexPath.row].name) \n \(arrStudent[indexPath.row].address)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
}
