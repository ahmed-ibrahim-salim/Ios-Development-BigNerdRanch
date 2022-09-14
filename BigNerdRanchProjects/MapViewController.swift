//
//  MapVC.swift
//  BigNerdRanchProjects
//
//  Created by ahmed ibrahim on 22/02/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    var didFindLocation: Bool = false{
        didSet{
            guard didFindLocation == true else{ return }
            locationManager.stopUpdatingLocation()
            print("called stop")
        }
    }
    var coordinate: CLLocationCoordinate2D?{
        didSet{
            setCamera()
        }
    }
    
    override func loadView() {
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard","Hybrid","Satallite"])
        if #available(iOS 13.0, *) {
            segmentedControl.backgroundColor = UIColor.systemBackground
        } else {
            // Fallback on earlier versions
        }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        let uiSwitch = UISwitch()
        let pointofviewLbl = UILabel()
        
        pointofviewLbl.translatesAutoresizingMaskIntoConstraints = false
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false

        pointofviewLbl.text = "Point of interest"
        view.addSubview(segmentedControl)
        view.addSubview(pointofviewLbl)
        view.addSubview(uiSwitch)

        
        let margins = view.layoutMarginsGuide
        
        let uiSwitchLead = uiSwitch.leadingAnchor.constraint(equalTo: pointofviewLbl.trailingAnchor, constant: 8)
        let uiswitchtop = uiSwitch.topAnchor.constraint(equalTo: margins.topAnchor, constant: 40)
        
        let constPointLblLead = pointofviewLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let constPointLbltop = pointofviewLbl.topAnchor.constraint(equalTo: margins.topAnchor, constant: 50)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor )
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        uiSwitchLead.isActive = true
        uiswitchtop.isActive = true
        constPointLblLead.isActive = true
        constPointLbltop.isActive = true
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(outer:)), for: .valueChanged)
        
        uiSwitch.addTarget(self, action: #selector(pointOfinterestChanged(sw:)), for: .valueChanged)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
        
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            didFindLocation = false
        }
    }
    @objc func pointOfinterestChanged(sw mySwitch: UISwitch ){
        if mySwitch.isOn{
            if #available(iOS 13.0, *) {
                mapView.pointOfInterestFilter = .includingAll
            } else {
                // Fallback on earlier versions
            }
        }else{
            if #available(iOS 13.0, *) {
                mapView.pointOfInterestFilter = .excludingAll
            } else {
                // Fallback on earlier versions
            }

        }
    }
    func setCamera(){
        print("called set camera")
        if let coordinate = coordinate {
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    @objc func mapTypeChanged(outer segmented: UISegmentedControl){
        switch segmented.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
}
extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        setCamera()
    }
}
extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = manager.location?.coordinate{
            self.coordinate = coordinate
            didFindLocation = true
            print("did update location")

        }
    }
}
