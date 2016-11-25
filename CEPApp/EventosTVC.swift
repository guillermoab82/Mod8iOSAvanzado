//
//  EventosTVC.swift
//  CEPApp
//
//  Created by Guillermo Alonso Barrón on 24/11/16.
//  Copyright © 2016 Guillermo Alonso Barrón. All rights reserved.
//

import UIKit
import Alamofire

class EventosTVC: UITableViewController {

    var losEventos:NSArray?

    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //conectarEventos();
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
/*
    func conectarEventos() {
        Alamofire.request("http://132.247.120.21/webservicep/get.php?status=1").responseJSON{response in
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
            if let JSON = response.result.value {
                let arreglo = JSON as! NSDictionary
                self.losEventos = arreglo["Eventos"] as? NSArray
                print("JSON2:\(self.losEventos!.count)")
            }else{
                print("Error no hay datos")
            }
        }
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.losEventos!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let dictEventos = self.losEventos![indexPath.row] as! NSDictionary
        cell.textLabel?.text = (dictEventos["title"] as! String).capitalized
        
        var laImg:String="http://www.posgrado.unam.mx/sites/default/files/"
        if !(dictEventos["uri"] is NSNull) {
            laImg = laImg+(dictEventos["uri"] as! String).lowercased()
        }else{
            if !(dictEventos["uri2"] is NSNull) {
                laImg = laImg+(dictEventos["uri2"] as! String).lowercased()
            }else{
                laImg = laImg+"image-not-available.png"
            }
        }
        print(laImg)
        
        if let url = URL(string: laImg){
            getDataFromUrl(url: url) { (data, response, error)  in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() { () -> Void in
                    cell.imageView?.image = UIImage(data: data)
                }
            }
            /*if let data = NSData(contentsOf: url){
                cell.imageView?.image = UIImage(data: data as Data)
            }*/
        }
        
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
