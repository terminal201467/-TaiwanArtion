//
//  MapInterface.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/18.
//

import Foundation
import CoreLocation
import MapKit
import FirebaseFirestore

class LocationInterface: NSObject {
    
    //MARK: -Callback
    
    var mapUpdateCenter: ((MKCoordinateRegion) -> Void)?
    
    static let shared = LocationInterface()
    
    typealias LocationInfo = (latitude: String, longitude: String)
    
    private var locationManager: CLLocationManager!
    
    private let firebaseDataBase = FirebaseDatabase(collectionName: "exhibitionHallInfo")
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    func checkLocationAuthorization() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func searchTheLocations(searchKeyword: String, completion: @escaping ([MKMapItem]) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchKeyword
        request.region = MKCoordinateRegion(center: getCurrentLocation().coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print("error:\(error.localizedDescription)")
            }
            
            guard let items = response?.mapItems else { return }
            completion(items)
            for item in items {
                print(
                """
                -----------館別資料--------------
                name: \(item.name ?? "Unknown")
                phone:\(item.phoneNumber ?? "Unknown Phone")
                timeZone:\(item.timeZone! ?? .none)
                url:\(item.url! ?? URL(string: ""))
                placemark: \(item.placemark)
                distance: \(self.getCurrentLocation().distance(from: item.placemark.location!)) meters
                -------------------------------
                """
                )
            }
        }
    }
    
    func filterTheNearExhibition(by infos: [ExhibitionInfo]) -> [ExhibitionInfo] {
        let desiredDistance: CLLocationDistance = 5000
        return infos.filter { info in
            let exhibitionLocation = CLLocation(latitude: Double(info.latitude) ?? 0.0, longitude: Double(info.longtitude) ?? 0.0)
            let distance = self.getCurrentLocation().distance(from: exhibitionLocation)
            return distance <= desiredDistance
        }
    }

//    func searchForPlaces(keyword: String, searchIn mapView: MKMapView) {
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = keyword
//        let search = MKLocalSearch(request: request)
//        search.start { (response, error) in
//            if let error = error {
//                print("Error: \(error)")
//                return
//            }
//
//            if let items = response?.mapItems {
//                mapView.removeAnnotations(mapView.annotations)
//                for item in items {
//                    mapView.addAnnotation(self.addAnnotationForMapItem(mapItem: item))
//                }
//            }
//        }
//    }
    
    //取得當前位置
    func getCurrentLocation() -> LocationInfo {
        guard let coordinate = locationManager.location?.coordinate else { return ("未知的經度","未知的緯度") }
        return (latitude: coordinate.latitude.formatted(),longitude: coordinate.longitude.formatted())
    }
    
    func getCurrentLocationDegrees() -> (latitudeDegree: CLLocationDegrees, longtitudeDegree: CLLocationDegrees) {
        guard let coordinate = locationManager.location?.coordinate else { return (Double(),Double()) }
        return (latitudeDegree: coordinate.latitude, longtitudeDegree: coordinate.longitude)
    }
    
    func getCurrentLocation() -> CLLocation {
        guard let location = locationManager.location else { return CLLocation() }
        return location
    }
    
    private func addAnnotationForMapItem(mapItem: MKMapItem) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapItem.placemark.coordinate
        annotation.title = mapItem.name
        annotation.subtitle = mapItem.placemark.title
        return annotation
    }
}

extension LocationInterface: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if  manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失敗：\(error.localizedDescription)")
    }
}
