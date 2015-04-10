//
//  ViewController.swift
//  CollegeProfileBuilder
//
//  Created by nhealy on 1/23/15.
//  Copyright (c) 2015 Barrington High School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var colleges: [College] = []
    // var colleges = ["Marquette University", "University of Wisconsin-Madison", "University of Chicago", "Harvard University"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colleges.append(College(name: "Marquette University", location: "Milwaukee, Wisconsin", numberOfStudents: 12002, image: UIImage (named: "Marquette")!, URL: "http://www.marquette.edu", coordinates: [43.0380, -87.9280]))
        colleges.append(College(name: "University of Wisconsin-Madison", location: "Madison, Wisconsin", numberOfStudents: 43275, image: UIImage (named: "UWM")!, URL: "http://www.wisc.edu", coordinates: [43.0750, -89.4172]))
        colleges.append(College(name: "University of Chicago", location: "Chicago, Illinois", numberOfStudents: 14954, image: UIImage (named: "UChicago")!, URL: "http://www.uchicago.edu", coordinates: [41.7897, -87.5997]))
        colleges.append(College(name: "Harvard University", location: "Cambridge, Massachusetts", numberOfStudents: 21000, image: UIImage (named: "Harvard")!, URL: "http://www.harvard.edu", coordinates: [42.3744, -71.1169]))

        editButton.tag = 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = colleges[indexPath.row].name
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            colleges.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func onTappedPlusButton(sender: UIBarButtonItem) {
        var alert = UIAlertController(title: "Add College", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Add College Here"
        }
        
        var cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancelAction)
        
        var addAction = UIAlertAction(title: "add", style: UIAlertActionStyle.Default) { (action) -> Void in
            var collegeTextField = alert.textFields?[0] as UITextField
            
            self.colleges.append(College (name: collegeTextField.text))
            self.tableView.reloadData()
        }
        
        alert.addAction(addAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        var college = colleges[sourceIndexPath.row]
        colleges.removeAtIndex(sourceIndexPath.row)
        colleges.insert(college, atIndex: destinationIndexPath.row)
    }
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBAction func onTappedEditButton(sender: UIBarButtonItem) {
        if sender.tag ==  0 {
            tableView.editing = true
            sender.tag = 1
        }
        else {
            tableView.editing = false
            sender.tag = 0
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var dvc = segue.destinationViewController as DetailViewController
        var index = tableView.indexPathForSelectedRow()?.row
        dvc.college = colleges[index!]
    }
}

