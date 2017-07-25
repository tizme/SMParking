//
//  ViewController.swift
//  SMParking
//
//  Created by Aaron Manill on 4/24/17.
//  Copyright © 2017 Aaron Manill. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var passedLot: NSDictionary!

    @IBOutlet weak var lotNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var start = ""
    var end = ""
    
    @IBOutlet weak var mapView: GMSMapView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        lotNameLabel.text = passedLot["name"] as? String
        addressLabel.text = passedLot["street_address"] as? String
        let spaces = passedLot["available_spaces"]
        spaceLabel.text = String(describing: spaces!)
        mapView.isMyLocationEnabled = true;
        setlocation()
        //navapicall()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //////////
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 500
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()


        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setlocation(){
//        print("attempint to set locaton")
//        let camera = GMSCameraPosition.camera(withLatitude: (passedLot["latitude"] as? Double)!, longitude: (passedLot["longitude"] as? Double)!, zoom: 18.0)
//        let mapViews = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView = mapViews
//
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (passedLot["latitude"] as? Double)!, longitude: (passedLot["longitude"] as? Double)!)
        marker.title = "\(String(describing: passedLot["name"]!))"
        marker.snippet = "\(String(describing: passedLot["available_spaces"]!)) Spaces"
        marker.map = mapView
        end += "\(String(describing: passedLot["latitude"]!)),\(String(describing: passedLot["longitude"]!))"
        print("the end", end)
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if (status == CLAuthorizationStatus.authorizedWhenInUse)
            
        {
            mapView.isMyLocationEnabled = true
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        var latitude = String(describing: newLocation!.coordinate.latitude)
        var longitude = String(describing: newLocation!.coordinate.longitude)
        start = "\(latitude),\(longitude)"
        print("current location", start)
        mapView.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 15.0)
        mapView.settings.myLocationButton = true
        //let marker = GMSMarker()
        //marker.position = CLLocationCoordinate2DMake(newLocation!.coordinate.latitude, newLocation!.coordinate.longitude)
        //marker.map = self.mapView
    }
    
    @IBAction func getDirectionsPressed(_ sender: UIButton) {
        print("starting spot", start)
        print("Destination", end)
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)){
            UIApplication.shared
                .openURL(URL(string:"comgooglemaps://?saddr=\(start)&daddr=\(end)")!)
            var urlstring = "http://maps.google.com/maps?"
            urlstring += "saddr=\(start)"
            urlstring += "&daddr=\(end)"
            print(urlstring)
        }
        else{
            var urlstring = "http://maps.google.com/maps?"
            urlstring += "saddr=\(start)"
            urlstring += "&daddr=\(end)"
            
            if let url = URL(string: urlstring) {
                UIApplication.shared.openURL(url)
            }
            else{
                print("Cant get directions")
            }
            
            
        }
        
    }
    

    ////////////Navigation testing/////////////////
    func navapicall(){
        print("https://maps.googleapis.com/maps/api/directions/json?orgin=\(start)&destination=\(end)")
        Alamofire.request("https://maps.googleapis.com/maps/api/directions/json?origin=\(start)&destination=\(end)", method: .get, parameters: nil, headers: nil)
            .responseJSON { response in
                print("Ran Alamo fire")
                if response.result.value! is NSArray{
                    print("result")
//                    for lot in response.result.value! as! NSArray {
//                        var lot = lot as! NSDictionary
//                        print(lot["name"])
//                        self.lots.append(lot)
//    
//                    }
//                    print("lot dictionary contains", self.lots)
//                    print(self.lots.count)
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
                    }
    
                
                else{
                     print("data came back in this format", response)
    print(response.result.value)
    
    }
        }
    
    
    }
    
    
    
}


