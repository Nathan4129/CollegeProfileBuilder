//
//  College.swift
//  CollegeProfileBuilder
//
//  Created by nhealy on 2/9/15.
//  Copyright (c) 2015 Barrington High School. All rights reserved.
//

import UIKit

class College: NSObject {
    var name = ""
    var location = ""
    var numberOfStudents = 0
    var image = UIImage(named: "default-1")
    var URL = ""
    var coordinates: [Double] = [0.0, 0.0]
    
    convenience init(name: String, location: String, numberOfStudents: Int, image: UIImage, URL: String, coordinates: [Double]) {
        self.init()
        self.name = name
        self.location = location
        self.numberOfStudents = numberOfStudents
        self.image = image
        self.URL = URL
        self.coordinates = coordinates
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
