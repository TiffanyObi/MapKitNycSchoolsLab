//
//  LocateNycSchoolsController.swift
//  MapKitNycSchoolsLab
//
//  Created by Tiffany Obi on 2/25/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import MapKit

class LocateNycSchoolsController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var locationSession = CoreLocationSession()
    private var annotations = [MKPointAnnotation]()
    private var isShowingNewAnnotations = true
    
    private var nYcSchools = [NYCSchools](){
        didSet {
            print("Total school count - \(nYcSchools.count)")
            loadMap()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        getSchools()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
    }
    
    private func getSchools() {
        NycSchoolsAPIClient.getListOfSchools { [weak self] (result) in
            switch result {
            case .failure:
                print("could not load schools")
                
            case .success(let schools):
                DispatchQueue.main.async {
                    self?.nYcSchools = schools
                }
            }
        }
    }
    
    private func loadMap() {
        
        let annotations  = makeAnnotation()
        mapView.addAnnotations(annotations)
        
    }
    
    private func makeAnnotation() -> [MKPointAnnotation]{
        var annotations = [MKPointAnnotation]()
        
        for school in nYcSchools{
            
            let annotation  = MKPointAnnotation()
            annotation.title = school.schoolName
            annotation.coordinate = CLLocationCoordinate2DMake(Double(school.latitude)!, Double(school.longitude)!)
            
            annotations.append(annotation)
        }
        
        isShowingNewAnnotations = true
        self.annotations = annotations
        return annotations
    }
    
}

extension LocateNycSchoolsController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//
//
//        guard let annotation = view.annotation else { return }
//
//        guard let location = (Location.getLocations().filter { $0.title == annotation.title }).first else {return}
//
//        guard let detailVC = storyboard?.instantiateViewController(identifier: "LocationDetailController",creator: { coder in
//            return LocationDetailController(coder: coder, location: location)
//        }) else {
//           fatalError("could not downcast to LocationDetailController")
//
//        }
//
//        detailVC.modalPresentationStyle = .popover
//        detailVC.modalTransitionStyle = .flipHorizontal
//        present(detailVC,animated: true)
//
//    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil}

        let identifier = "annotationView"

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout =  true
            annotationView?.glyphImage = UIImage(named: "school")

        } else {

            annotationView?.annotation = annotation
        }
return annotationView
    }

    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if isShowingNewAnnotations {
            // we set it to false because setting it to true gives weird animations.
            mapView.showAnnotations(annotations, animated: false)
        }
        isShowingNewAnnotations = false
    }
}
