//
//  MapViewController.swift
//  CollegeProfileBuilder
//
//  Created by nhealy on 2/24/15.
//  Copyright (c) 2015 Barrington High School. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var enterLocationTextField: UITextField!
    
    var locationName = ""
    var displayedTextLocation = ""
    var pointLatitude = 0.0
    var pointLongitude = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pointLatitude == 0.0 && pointLongitude == 0.0 {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(displayedTextLocation, completionHandler: {
                placemarks, error in
                if (error != nil) {
                    println(error)
                }
                else {
                    let placemark = placemarks.first as CLPlacemark
                    let center = placemark.location.coordinate
                    let span = MKCoordinateSpanMake(0.05, 0.05)
                    let region = MKCoordinateRegionMake(center, span)
                    let pin = MKPointAnnotation()
                    pin.coordinate = center
                    pin.title = self.displayedTextLocation
                    self.mapView.addAnnotation(pin)
                    self.mapView.setRegion(region, animated: true)
                }
            })
        }
        let center = CLLocationCoordinate2DMake(pointLatitude, pointLongitude)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(center, span)
        let pin = MKPointAnnotation()
        pin.coordinate = center
        pin.title = locationName
        mapView.addAnnotation(pin)
        mapView.setRegion(region, animated: true)
        
    }
    
/*    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(enterLocationTextField.text, completionHandler: {
            placemarks, error in
            if (error != nil) {
                println(error)
            }
            else {
                let placemark = placemarks.first as CLPlacemark
                let center = placemark.location.coordinate
                let span = MKCoordinateSpanMake(0.05, 0.05)
                let region = MKCoordinateRegionMake(center, span)
                let pin = MKPointAnnotation()
                pin.coordinate = center
                pin.title = self.enterLocationTextField.text
                self.mapView.addAnnotation(pin)
                self.mapView.setRegion(region, animated: true)
            }
        })
        textField.resignFirstResponder()
        return true
    } */
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        locationName = textField.text
        textField.resignFirstResponder()
        findLocation()
        println(locationName)
        return true
    }
    
    func findLocation() {
        var alert = UIAlertController(title: "Seletct a location", message: nil, preferredStyle: .ActionSheet)
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationName, completionHandler: {
            placemarks, error in
            if (error != nil) {
                println(error)
            }
            else {
                var number = placemarks.count
                if number == 0 {
                    let placemark = placemarks.first as CLPlacemark
                    self.displayMap(placemark)
                }
                else {
                    if number > 5 {number = 5}
                    for index in 0..<number {
                        let placemark = placemarks[index] as CLPlacemark
                        let name = placemark.name
                        let city = placemark.locality
                        let state = placemark.administrativeArea
                        let location = "\(name), \(city), \(state)"
                        let locationAction = UIAlertAction(title: location, style: .Default, handler: { (action) -> Void in
                            self.displayMap(placemark)
                        })
                        alert.addAction(locationAction)
                    }
                    var cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                    alert.addAction(cancelAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        })
    }
    
    func displayMap(placemark: CLPlacemark) {
        let name = placemark.name
        let city = placemark.locality
        let state = placemark.administrativeArea
        let location = "\(name), \(city), \(state)"
        let center = placemark.location.coordinate
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(center, span)
        let pin = MKPointAnnotation()
        pin.setCoordinate(center)
        pin.title = location
        self.mapView.addAnnotation(pin)
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func onTappedSave(sender: UIButton) {
        pointLatitude = 0.0
        pointLongitude = 0.0
    }
}
