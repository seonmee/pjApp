//
//  TypeViewController.swift
//  ProjectBJ
//
//  Created by SWUCOMPUTER on 2017. 12. 23..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class TypeViewController: UIViewController {
    
    @IBOutlet var textType: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func pressOne(_ sender: UIButton) {
        textType.text = "유형1"
    }
    @IBAction func pressTwo(_ sender: UIButton) {
        textType.text = "유형2"
    }
    @IBAction func pressThree(_ sender: UIButton) {
        textType.text = "유형3"
    }
    @IBAction func pressFour(_ sender: UIButton) {
        textType.text = "유형4"
    }

 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDataTable" {
            if let destination = segue.destination as? DataTableViewController {
                destination.title = textType.text
                destination.pType = textType.text!
            }
        }
    }

}
