//
//  ParkingLotTableViewController.swift
//  SMParking
//
//  Created by Aaron Manill on 4/25/17.
//  Copyright © 2017 Aaron Manill. All rights reserved.
//

import UIKit
import Alamofire

class ParkingLotTableViewController: UITableViewController {
    
    var lots = [NSDictionary]()
    var urladdress = "https://parking.api.smgov.net/lots"

    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load!")
        apicall()


    }
    
    @IBAction func AboutButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAbout", sender: nil)
        
        
    }
    
    
    
    
    
    

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
        print("generating cells", lots.count)
        return lots.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        var cell:UITableViewCell? =
            tableView.dequeueReusableCell(withIdentifier: "myCell")
        if (cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                                   reuseIdentifier: "myCell")
        }
        
        
        // set the default cell label to the corresponding element in the people array
        cell?.textLabel?.text = lots[indexPath.row]["name"] as? String
        let spots = lots[indexPath.row]["available_spaces"]!
	       cell?.detailTextLabel?.text = "\(String(describing: spots)) spots available"

        // return the cell so that it can be rerndered
        
            cell?.backgroundColor = cellColorForIndex(indexPath: indexPath as NSIndexPath)
        
        return cell!
    }
    /// Color picking
    
    func cellColorForIndex(indexPath:NSIndexPath) -> UIColor{
    let row = Int(indexPath.row)
    if (row % 2 == 1)
    {
        return UIColor(red:0.13, green:0.59, blue:0.95, alpha:1.0)
    }
    else
    {
        return UIColor(red:0.10, green:0.46, blue:0.82, alpha:1.0)
        }
    }
    
    
    func apicall(){
        let headers: HTTPHeaders = [ "Accept": "application/json"]
        
        Alamofire.request("https://parking.api.smgov.net/lots", method: .get, parameters: nil, headers: headers)
            .responseJSON { response in
                print("Ran Alamo fire")
                if response.result.value! is NSArray{
                    print("yay")
                    for lot in response.result.value! as! NSArray {
                        let lot = lot as! NSDictionary
                        print(lot["name"] ?? <#default value#>)
                        self.lots.append(lot)
                        
                    }
                    print("lot dictionary contains", self.lots)
                    print(self.lots.count)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
                else{
                    // print("data came back in this format", response)
                    print(response.result.value!)
                    
                }
                
                
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lot = lots[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: lot)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let lot = sender as? NSDictionary
        let destConctroller = segue.destination as? ViewController
        destConctroller?.passedLot = lot
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
