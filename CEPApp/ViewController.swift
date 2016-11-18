//
//  ViewController.swift
//  CEPApp
//
//  Created by Guillermo Alonso Barrón on 17/11/16.
//  Copyright © 2016 Guillermo Alonso Barrón. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var txtJSON: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        conectarJSON();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func conectarJSON() {
        Alamofire.request("http://132.247.120.21/webservicep/get.php?status=1").responseJSON{response in
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
            if let JSON = response.result.value{
                print("JSON:\(JSON)")
                let datos = "\(JSON)"
                self.txtJSON.text = datos as String
            }
        }
    }
}

