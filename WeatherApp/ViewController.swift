//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yiğithan Sönmez on 25.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let apiKey: String = ""
    var lattitude: String = "38.423784"
    var longitude: String = "27.142780"
    
    @IBAction func getDataButtonClicked(_ sender: UIButton) {
        getDataByLatAndLong()
    }
    
    @IBOutlet var Temperature: UILabel!
    @IBOutlet var CityName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(alertTitle: String, alertMessage: String){
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        present(alertController, animated: true, completion: nil)
    }
    
    func getDataByLatAndLong(){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lattitude)&lon=\(longitude)&appid=\(apiKey)")
        
        print(url!.absoluteString)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
            guard error != nil else{
                print("Error")
                print(error.debugDescription)
                return
            }
            
            guard data != nil else{
                print("no data")
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers ) as? [String:Any]
                
                DispatchQueue.main.async {
                    if let main = jsonResponse!["main"] as? [String:Any]{
                        if let Temperature = main["temp"] as? Double {
                            self.Temperature.text = String(Temperature) + "°"
                        }
                    }
                }
            }catch {
                
            }
        }
        task.resume()
    }
        
        
}

