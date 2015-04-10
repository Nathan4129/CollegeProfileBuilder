//
//  DetailViewController.swift
//  CollegeProfileBuilder
//
//  Created by nhealy on 2/10/15.
//  Copyright (c) 2015 Barrington High School. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var college: College!
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var numberOfStudentsTextField: UITextField!
    @IBOutlet weak var URLTextField: UITextField!
    @IBAction func onTappedSaveButton(sender: UIButton) {
        college.location = locationTextField.text
        college.numberOfStudents = numberOfStudentsTextField.text.toInt()!
        college.URL = URLTextField.text
        college.image = imageView.image
    }
    
    @IBAction func onChangeImageButtonTapped(sender: UIButton) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: {
            var selectedImage = info[UIImagePickerControllerOriginalImage] as UIImage
            self.imageView.image = selectedImage
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTextField.text = college.location
        numberOfStudentsTextField.text = String(college.numberOfStudents)
        imageView.image = college.image
        URLTextField.text = college.URL
        imagePicker.delegate = self
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as UIViewController
        if dvc is WebViewController {
          (dvc as WebViewController).collegeURL = college.URL
        }
        else {
            (dvc as MapViewController).locationName = college.name
            (dvc as MapViewController).displayedTextLocation = college.location
            //(dvc as MapViewController).pointLatitude = college.coordinates[0]
            //(dvc as MapViewController).pointLongitude = college.coordinates[1]
            
        }
    }
}
