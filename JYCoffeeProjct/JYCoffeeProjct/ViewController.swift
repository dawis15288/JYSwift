//
//  ViewController.swift
//  JYCoffeeProjct
//
//  Created by atom on 16/2/25.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import MapKit

import RealmSwift

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var mapViw: MKMapView!
    @IBOutlet weak var tableVieew: UITableView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    let distanceSpan: Double = 500
    
    var lastLocation: CLLocation?
    
    var venues: [Venue]?
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        mapViw.delegate = self
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.distanceFilter = 50
        
        locationManager.startUpdatingLocation()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("onVenuesUpdatd:"), name: API.notifications.venusUpdated, object: nil)
    }
    
    func onVenuesUpdatd(notification: NSNotification) {
        
        refreshVenues(nil)
    
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, distanceSpan, distanceSpan)
        
        mapViw.setRegion(region, animated: true)
        
        refreshVenues(newLocation, getDataFromFoursquare: true)
        
    }
    
    func refreshVenues(location: CLLocation?, getDataFromFoursquare: Bool = false) {
        
        if location != nil {
            
            lastLocation = location
        
        }
        
        if let location = lastLocation {
            
            if getDataFromFoursquare == true {
            
                CoffeeAPI.sharedInstance.getCoffeeShopWithLocation(location)
                
            }
            
            //let realm = try! Realm()
            
            //venues = realm.objects(Venue)
            
            let (start, stop) = calculateCoordinatesWithRegion(location)
            
            let predicate = NSPredicate(format: "latitude < %f AND latitude > %f AND longitude > %f AND longitude < %f", start.latitude, stop.latitude, start.longitude, stop.longitude)
            
            let realm = try! Realm()
            
            venues = realm.objects(Venue).filter(predicate).sort{
                
                location.distanceFromLocation($0.coorrdinte) < location.distanceFromLocation($1.coorrdinte)
            
            }
            
            for venue in venues! {
                
                let annotation = CoffeeAnntation(title: venue.name, subtitle: venue.address, coordinate: CLLocationCoordinate2D(latitude: Double(venue.latitude), longitude: Double(venue.longitude)))
                
                mapViw.addAnnotation(annotation)
                
            }
            
            tableVieew.reloadData()
        
        }
    
    
    }
    
    func calculateCoordinatesWithRegion(locatiion: CLLocation) -> (CLLocationCoordinate2D, CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegionMakeWithDistance(locatiion.coordinate, distanceSpan, distanceSpan)
        
        var start: CLLocationCoordinate2D = CLLocationCoordinate2D()
        
        var stop: CLLocationCoordinate2D = CLLocationCoordinate2D()
        
        start.latitude = region.center.latitude + ( region.span.latitudeDelta / 2.0)
        
        start.longitude = region.center.longitude + (region.span.longitudeDelta / 2.0)
        
        stop.latitude = region.center.latitude + (region.span.latitudeDelta / 2.0)
        
        stop.longitude = region.center.longitude + ( region.span.longitudeDelta / 2.0)
        
        return (start, stop)
    
    
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKindOfClass(MKUserLocation) {
            
            return nil
        
        }
        
        var view = mapViw.dequeueReusableAnnotationViewWithIdentifier("annotationIdentifier")
        
        if view == nil {
            
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationIdentifier")
        
        }
        
        view?.canShowCallout = true
        
        return view
    }
    
    // MARK: datasurce dlegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return venues?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        if let venue = venues?[indexPath.row] {
            
            cell.textLabel?.text = venue.name
            
            cell.detailTextLabel?.text = venue.address
            
            
        
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let venue = venues?[indexPath.row] {
            
            let region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: Double(venue.latitude), longitude: Double(venue.longitude)), distanceSpan, distanceSpan)
            
            mapViw?.setRegion(region, animated: true)
        
        }
    }


}

