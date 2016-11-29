//
//  DetallesEventos.swift
//  CEPApp
//
//  Created by Guillermo Alonso Barrón on 24/11/16.
//  Copyright © 2016 Guillermo Alonso Barrón. All rights reserved.
//

import UIKit

class DetallesEventos: UIViewController {

    var EventoDetalle:NSDictionary?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgDetalle: UIImageView!
    @IBOutlet weak var lblFinicio: UILabel!
    @IBOutlet weak var lblHInicio: UILabel!
    @IBOutlet weak var lblFTermino: UILabel!
    @IBOutlet weak var lblHTermino: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = EventoDetalle["title"] as? String
        self.lblFinicio.text = EventoDetalle["fInit"] as? String
        self.lblHInicio.text = EventoDetalle["hInit"] as? String
        self.lblFTermino.text = EventoDetalle["fEnd"] as? String
        self.lblHTermino.text = EventoDetalle["hEnd"] as? String
        
        var laImg:String="http://www.posgrado.unam.mx/sites/default/files/"
        if !(EventoDetalle["uri2"] is NSNull){
            laImg = laImg+(EventoDetalle["uri2"] as! String).lowercased()
        }else{
            if !(EventoDetalle["uri"] is NSNull){
                laImg = laImg+(EventoDetalle["uri"] as! String).lowercased()
            }else{
                laImg = laImg+"image-not-available.png"
            }
        }
        if let url = URL(string: laImg){
            getDataFromUrl(url: url) { (data, response, error)  in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() { () -> Void in
                    self.imgDetalle.image = UIImage(data: data)
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
