//
//  CouncilViewController.swift
//  ProjectBJ
//
//  Created by SWUCOMPUTER on 2017. 12. 23..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class CouncilViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var mName: UITextField!
    @IBOutlet var numOfPeaple: UITextField!
    @IBOutlet var price: UITextField!
    @IBOutlet var mTotal: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // coredata delegate
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // textFiled delegate 2
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
        return true
    }
    
    @IBAction func saveCouncil(_ sender: UIBarButtonItem) {
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Council", in: context)
        // record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(mName.text, forKey: "mName")
        object.setValue(numOfPeaple.text, forKey: "numOfPeaple")
        object.setValue(Int(price.text!), forKey: "price")
        object.setValue(Int(mTotal.text!), forKey: "mTotal")
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
