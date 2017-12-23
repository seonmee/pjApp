//
//  DataTableViewController.swift
//  ProjectBJ
//
//  Created by SWUCOMPUTER on 2017. 12. 10..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class DataTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource ,UITextFieldDelegate{
    
    var Personnel: [NSManagedObject] = []
    var Equipment: [NSManagedObject] = []
    var Council: [NSManagedObject] = []
    
    
    @IBOutlet var personnelTable: UITableView!
    @IBOutlet var equipmentTable: UITableView!
    @IBOutlet var councilTable: UITableView!
    @IBOutlet var pName: UITextField!
    
    var pType:String=""
    
    // coredata delegete
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // textFiled delegate 2
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // view가 보여질때
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        let context = self.getContext()
        // Personnel DB에 자료를 배열에 불러오기
        let fetchRequest1 = NSFetchRequest<NSManagedObject>(entityName: "Personnel")
        do {
            Personnel = try context.fetch(fetchRequest1)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        // Equipment DB에 자료를 배열에 불러오기
        let fetchRequest2 = NSFetchRequest<NSManagedObject>(entityName: "Equipment")
        do {
            Equipment = try context.fetch(fetchRequest2)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        // Council DB에 자료를 배열에 불러오기
        let fetchRequest3 = NSFetchRequest<NSManagedObject>(entityName: "Council")
        do {
            Council = try context.fetch(fetchRequest3)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        self.personnelTable.reloadData()
        self.equipmentTable.reloadData()
        self.councilTable.reloadData()
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Project", in: context)
        // record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(pName.text, forKey: "pName")
        object.setValue(pType, forKey: "pType")
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        // DB초기화
        Personnel.removeAll()
        Equipment.removeAll()
        Council.removeAll()
        
        // table 초기화 모르겠어요 ㅜㅜㅜㅜ
        
        
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)

        
    }
    


    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case personnelTable:
            return Personnel.count
        case equipmentTable:
            return Equipment.count
        default:
            return Council.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        if tableView == personnelTable {
        
            let pCell = tableView.dequeueReusableCell(withIdentifier: "Personnel Cell", for: indexPath)
            var nametext = ""
            
            let personnel = Personnel[indexPath.row]
            if let pname = personnel.value(forKey: "name") as? String {
                nametext = pname
            }
            
            pCell.textLabel?.text = nametext
            pCell.detailTextLabel?.text = personnel.value(forKey: "position") as? String
            
            // Configure the cell...
            
            return pCell
        }
        
        else if tableView == equipmentTable {
            let eCell = tableView.dequeueReusableCell(withIdentifier: "Equipment Cell",for: indexPath)
            
            var nametext = ""
            
            let equipment = Equipment[indexPath.row]
            
            if let ename = equipment.value(forKey: "eName") as? String {
                nametext = ename
            }
            
            eCell.textLabel?.text = nametext
            eCell.detailTextLabel?.text = equipment.value(forKey: "standard") as? String
            
            // Configure the cell...
            
            return eCell
        }
        else {
            let cCell = tableView.dequeueReusableCell(withIdentifier: "Council Cell",for: indexPath)
            
            var nametext = ""
            
            let council = Council[indexPath.row]
            
            if let mname = council.value(forKey: "mName") as? String {
                nametext = mname
            }
            
            cCell.textLabel?.text = nametext
            cCell.detailTextLabel?.text = (council.value(forKey: "numOfPeaple") as? String)! + "명"
            
            // Configure the cell...
            
            return cCell
        }
    
    }
    

    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if tableView == personnelTable {
                // Core Data 내의 해당 자료 삭제
                let context = getContext()
                context.delete(Personnel[indexPath.row])
                do {
                    try context.save()
                    print("deleted!")
                } catch let error as NSError {
                    print("Could not delete \(error), \(error.userInfo)") }
                
                // 배열에서 해당 자료 삭제
                Personnel.remove(at: indexPath.row)
                
                // 테이블뷰 Cell 삭제
                tableView.deleteRows(at: [indexPath], with: .fade)

            }
            else if tableView == equipmentTable {
                // Core Data 내의 해당 자료 삭제
                let context = getContext()
                context.delete(Equipment[indexPath.row])
                do {
                    try context.save()
                    print("deleted!")
                } catch let error as NSError {
                    print("Could not delete \(error), \(error.userInfo)") }
                
                // 배열에서 해당 자료 삭제
                Equipment.remove(at: indexPath.row)
                
                // 테이블뷰 Cell 삭제
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
            else {
                // Core Data 내의 해당 자료 삭제
                let context = getContext()
                context.delete(Council[indexPath.row])
                do {
                    try context.save()
                    print("deleted!")
                } catch let error as NSError {
                    print("Could not delete \(error), \(error.userInfo)") }
                
                // 배열에서 해당 자료 삭제
                Council.remove(at: indexPath.row)
                
                // 테이블뷰 Cell 삭제
                tableView.deleteRows(at: [indexPath], with: .fade)

            }
        } else if editingStyle == .insert {
            
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
