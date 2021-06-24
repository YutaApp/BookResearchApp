//
//  LibraryDetailViewController.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/16.
//

import UIKit
import MapKit

class LibraryDetailViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    var strFormal = String()
    var strShort = String()
    var strCategory = String()
    var strAddress = String()
    var strTel = String()
    var strCoordinate = String()
    
    @IBOutlet weak var formalLabel: UILabel!
    @IBOutlet weak var shortLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var libraryMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var geocodeArray = [Substring]()
    let libraryAnnotation = MKPointAnnotation()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        startUpdatingLoction()
        mapSetting()
        addLibraryAnnotation()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        formalLabel.text = strFormal
        shortLabel.text = strShort
        decideCategoryName(label: categoryLabel, cate: strCategory)
        addressLabel.text = strAddress
        telLabel.text = strTel
    }
    
    func decideCategoryName(label:UILabel,cate:String)
    {
        switch (cate) {
        case "SMALL":
            label.text = "図書室・公民館"
            break
            
        case "MEDIUM":
            label.text = "図書館(地域)"
            break
            
        case "LARGE":
            label.text = "図書館(広域)"
            break
            
        case "UNIV":
            label.text = "大学"
            break
            
        case "SPECIAL":
            label.text = "専門"
            break
            
        case "BM":
            label.text = "移動・BM"
            break
        default:
            label.text = ""
        }
    }
    
    func startUpdatingLoction()
    {
        locationManager.requestAlwaysAuthorization()
        let status = CLAccuracyAuthorization.fullAccuracy
        
        if status == .fullAccuracy
        {
            locationManager.startUpdatingLocation()
        }
    }
    
    func mapSetting()
    {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        
        libraryMapView.delegate = self
        libraryMapView.mapType = .standard
        libraryMapView.userTrackingMode = .follow
    }
    
    func addLibraryAnnotation()
    {
        libraryMapView.removeAnnotations(libraryMapView.annotations)
        
        geocodeArray = strCoordinate.split(separator: ",")
        
        libraryAnnotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(Double(geocodeArray[1])!), CLLocationDegrees(Double(geocodeArray[0])!))
        
        libraryMapView.addAnnotation(libraryAnnotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: libraryAnnotation.coordinate, span: span)
        
        libraryMapView.region = region
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)
    {
        switch manager.authorizationStatus
        {
        case .authorizedAlways, .authorizedWhenInUse:
            break
            
        case .notDetermined, .denied, .restricted:
            break
        default:
            print("Unhandled case")
        }
        
        switch manager.accuracyAuthorization
        {
        case .reducedAccuracy:
            break
        case .fullAccuracy:
            break
        default:
            print("This should not happen!")
        }
    }
    
    
    
    
    
}
