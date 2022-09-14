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
