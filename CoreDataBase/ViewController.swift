//
//  ViewController.swift
//  CoreDataBase
//
//  Created by Lalaiya Sahil on 11/02/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var addressTextfilde: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var nameTextFilde: UITextField!
    @IBOutlet weak var messageLable: UILabel!
    @IBOutlet weak var idTextFilde: UITextField!
    
    var arrstudent: [StudentDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    private func insertStudentDetaisls(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let viewContext = appDelegate.persistentContainer.viewContext
        
        let studentEntity = NSEntityDescription.entity(forEntityName: "Student", in: viewContext)!
        let studentManageObject = NSManagedObject(entity: studentEntity, insertInto: viewContext)
        studentManageObject.setValue(Double(idTextFilde.text ?? "0"), forKey: "id")
        studentManageObject.setValue(nameTextFilde.text ?? "", forKey: "name")
        studentManageObject.setValue(addressTextfilde.text ?? "", forKey: "address")
        
        do{
            try viewContext.save()
            print("Data Save Successfully")
            messageLable.text = "Data save successfully"
            nameTextFilde.text = ""
            idTextFilde.text = ""
            addressTextfilde.text = ""
        }catch let error as NSError{
            print(error.localizedDescription)
            messageLable.text = error.localizedDescription
        }
    }
    
    private func getStudentDetaisls(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let viewContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Student")
        do{
            let students = try viewContext.fetch(fetchRequest)
            arrstudent = []
            for students in students as! [NSManagedObject] {
                let name = students.value(forKey: "name") ?? ""
                let address = students.value(forKey: "address") ?? ""
                let id = students.value(forKey: "id") ?? 0.0
                let studentObject = StudentDetails(id: id as! Double, name: name as! String, address: address as! String)
                arrstudent.append(studentObject)
                print("Student id is \(id)")
                print("Student name is \(name)")
                print("Student address is \(address)")
            }
            print(arrstudent)
            
            if arrstudent.count > 0 {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let studentListViewController = storyBoard.instantiateViewController(withIdentifier: "EmployeeListViewController") as! EmployeeListViewController
                studentListViewController.arrStudent = arrstudent
                navigationController?.pushViewController(studentListViewController, animated: true)
            }else{
                print("No Data Found")
            }
            
        }catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    private func updateStudentDetaisls(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Student")
        do{
            let students = try viewContext.fetch(fetchRequest)
            arrstudent = []
            for students in students as! [NSManagedObject] {
                let tempStudent = students
                tempStudent.setValue(Double(idTextFilde.text ?? "0"), forKey: "id")
                try viewContext.save()
                print("Data Update Sucessfully")
                messageLable.text = "Data Update Sucessfully"
                nameTextFilde.text = ""
                addressTextfilde.text = ""
                getStudentDetaisls()
            }
            print(arrstudent)
            
            
        }catch let error as NSError {
            print(error.localizedDescription)
            messageLable.text = error.localizedDescription
        }
        
    }
        
        private func deleteStudentDetaisls(){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let viewContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Student")
            fetchRequest.predicate = NSPredicate(format: "name", nameTextFilde.text ?? "")
            
            do{
                let students = try viewContext.fetch(fetchRequest)
                arrstudent = []
                for students in students as! [NSManagedObject] {
                    let tempStudent = students
                    tempStudent.setValue(Double(idTextFilde.text ?? "0"), forKey: "id")
                    try viewContext.save()
                    print("Data Update Sucessfully")
                    messageLable.text = "Data Update Sucessfully"
                    nameTextFilde.text = ""
                    addressTextfilde.text = ""
                    getStudentDetaisls()
                }
                print(arrstudent)
                
                
            }catch let error as NSError {
                print(error.localizedDescription)
                messageLable.text = error.localizedDescription
            }
            
        }
        
        
        @IBAction func saveButtonClicked(_ sender: UIButton) {
            if idTextFilde.text?.count == 0 || nameTextFilde.text?.count == 0 || addressTextfilde.text?.count == 0 {
                print("Please enter Missing Details")
            }
            insertStudentDetaisls()
        }
        
        @IBAction func searchButtonClicked(_ sender: UIButton) {
            getStudentDetaisls()
            
        }
        
        @IBAction func updateButtonClicked(_ sender: UIButton) {
            if idTextFilde.text?.count == 0 || nameTextFilde.text?.count == 0 || addressTextfilde.text?.count == 0 {
                print("Please enter Missing Details")
            }
            updateStudentDetaisls()
        }
        
        @IBAction func deleteButtonClicked(_ sender: UIButton) {
            deleteStudentDetaisls()
        }
    }
    struct StudentDetails{
        var id: Double
        var name: String
        var address: String
    }
    


