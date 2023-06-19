//
//  LocationViewController.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2023/1/1.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    var viewModel = LocationViewModel()
    var locatorDetailsArray :[LocatorsData] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (locationManager.authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse ||
            locationManager.authorizationStatus == CLAuthorizationStatus.authorizedAlways){
            guard let currentLocation = locationManager.location else {
                return
            }
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            viewModel.getLocators(lat: "12.9253498", longi: "77.619228",  completion: { locators, status in
                if status == true {
                    self.locatorDetailsArray = locators ?? []
                        self.customAnnotations()
                       // self.mapView .showAnnotations(self.mapView.annotations, animated: true)
                }
            })
        }
        
    }
    
    
    func customAnnotations(){
        if locatorDetailsArray.count > 1 {
            for  i in 0...locatorDetailsArray.count - 1  {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(locatorDetailsArray[i].latitude) ?? 0.0000, longitude: Double(locatorDetailsArray[i].longitude) ?? 0.000)
                annotation.title = locatorDetailsArray[i].location // Optional
                annotation.subtitle = locatorDetailsArray[i].address // Optional
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    
}

extension LocationViewController: CLLocationManagerDelegate {
    
//    // iOS 13 and below
//        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//            switch status {
//            case .notDetermined:
//                print("Not determined")
//            case .restricted:
//                print("Restricted")
//            case .denied:
//                print("Denied")
//            case .authorizedAlways:
//                print("Authorized Always")
//            case .authorizedWhenInUse:
//                print("Authorized When in Use")
//            @unknown default:
//                print("Unknown status")
//            }
//        }
    
    // iOS 14
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .notDetermined:
                print("Not determined")
            case .restricted:
                print("Restricted")
            case .denied:
                print("Denied")
            case .authorizedAlways:
                print("Authorized Always")
            case .authorizedWhenInUse:
                print("Authorized When in Use")
            @unknown default:
                print("Unknown status")
            }
        }
    }
    
}

extension LocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        return nil
    }
}
    

    
