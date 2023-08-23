//
//  MapLocationPinAnnotation.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/22.
//

import UIKit
import MapKit
import SnapKit

class MapLocationPinAnnotation: NSObject, MKAnnotation {

    static let reuseIdentifier: String = "MapLocationPinView"
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
