//
//  ViewController.swift
//  DatabaseTest
//
//  Created by Tanmay Bakshi on 2014-09-02.
//  Copyright (c) 2014 TBSS. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableview: UITableView!

    var data: NSArray = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print(data, terminator: "")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        Alamofire.request(.GET, "YOUR_LINK_HERE")
            .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                print(totalBytesRead)
            }
            .responseJSON { response in
                if let final = response.data {
                    
                    if let final_2 = JSON(final).dictionaryObject {
                        
                        // DO SOMETHING WITH final_2 \\
                        if !animated { self.reload() }
                        
                    }
                    
                }
            }
            .responseString { response in
                print(String(data: response.data!, encoding: NSUTF8StringEncoding))
        }
    }
    
    @IBAction func reload() {
        viewDidAppear(true)
        self.tableview.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: additionInfoCell = self.tableview.dequeueReusableCellWithIdentifier("customCell") as! additionInfoCell
        let maindata = (data[indexPath.row] as! NSDictionary)
        cell.name!.text = maindata["name"] as! String
        let userID = maindata["id"] as! Int
        let age = maindata["age"] as! String
        let imageURL = maindata["image"] as! String
        let image = UIImage(data: NSData(contentsOfURL: NSURL(string: imageURL)!)!)
        cell.imageview!.image = image
        cell.info!.text = "id: \(userID)\nage: \(age)"
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
