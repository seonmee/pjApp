//
//  PersonnelViewController.swift
//  ProjectBJ
//
//  Created by SWUCOMPUTER on 2017. 12. 10..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class PersonnelViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var pName: UITextField!
    @IBOutlet var position: UITextField!
    @IBOutlet var allowance: UITextField!
    @IBOutlet var percent: UITextField!
    @IBOutlet var total: UITextField!
    

    // coredata delegate
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

        // Do any additional setup after loading the view.
    }

    @IBAction func SavePressed(_ sender: UIBarButtonItem) {
        
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Personnel", in: context)
        // record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(pName.text, forKey: "name")
        object.setValue(position.text, forKey: "position")
        object.setValue(Int(allowance.text!), forKey: "price")
        object.setValue(Int(percent.text!), forKey: "percent")
        object.setValue(Int(total.text!), forKey: "total")
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
    }
    */

}
