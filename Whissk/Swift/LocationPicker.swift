//
//  LocationPicker.swift
//  Whissk
//
//  Created by Sai Madhav on 20/08/18.
//  Copyright © 2018 Sai Madhav. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import CoreLocation

class LocationPicker: UIViewController,CLLocationManagerDelegate {

    //Variables
    @IBOutlet weak var locationLabel: UILabel! //Location Label
    @IBOutlet weak var mapView: GMSMapView! //The Map
    let locationManager = CLLocationManager() //Location Manager
    @IBOutlet weak var searchBar: UISearchBar! //Search bar Mostly will be taken out
    
    //MARK:- Status bar color to white text
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //To set the location Manager when the view loads
        readyLocationManager()
    }
    
    //To use the location manager
    func readyLocationManager(){
        locationManager.delegate = self //Setting the deligate as this view controller
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //To change the accuracy later
        locationManager.requestWhenInUseAuthorization() //To get the users location when in use
        locationManager.startUpdatingLocation() //This starts searching for the location and sends it to the deligate (Us) if the location is found
    }
    
    //To Update the map to the users location
    func readyMapView(center : CLLocationCoordinate2D){
        mapView.delegate = self //Setting the map views deligate to the current view controller
        let camera = GMSCameraPosition.camera(withTarget: center, zoom: 17, bearing: 0, viewingAngle: 0) // Maps camera position to users location
        mapView.camera = camera // Sets the camera of the map view as the camera variable declared
        mapView.isMyLocationEnabled = true //To enable the users location and show it as a blue dot
        mapView.setMinZoom(12, maxZoom: 20) //The camera zoon so that the user can go only to buildings to street view
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                //Use the dark map style
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {//If the map skin fails to load
                NSLog("Unable to find style.json")
            }
        } catch {
            //If the do catch fails to load the map skin
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight] //To let the map autosize with dynamic frame
        //To get the location name from the Coordinates
        reverseGeocodeCoordinate(center)
    }
    
    //This gets called when the location gets found
    //MARK:- Location Found !
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{ // Gets the last updated location from the location array
            if location.horizontalAccuracy > 0 { //If the location horizondal accuracy is less than 0 means there is soeme error
                manager.stopUpdatingLocation() //To stop the updating else more memory will be taken
                readyMapView(center: location.coordinate) //This calls ready map view function with Users location
            }
            else {
                //TODO:- Location Error
                //Check if this only gets called if the location is found so slow internet and other errors can be handled too
            }
        }
    }
    
    
    //This gets called when there is an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        //TODO:- Error In Finding location
        // Add a pop up to show the error
    }

    //To check for internet connection
    func checkForInternet(){
        if (NetworkReachabilityManager()?.isReachable)! { //To check if the network is available
            print("There is network")
        }
        else{
            //TODO:- Error with internet
            // Add a nice pop up for the error
        }
    }

    //Checks for the users location and updates it on the mapview
    @IBAction func findUser(_ sender: Any) { //Its a button on the map that recenters the location to users
        locationManager.startUpdatingLocation()//This starts searching for the location and sends it to the deligate (Us) if the location is found
    }
    
    //MARK:- Asks for users details after Location is picked
    let cleanCodeManager = MoreDetailsController()
    @IBAction func moreDetails(_ sender: Any) {
        cleanCodeManager.standby()
    }

    //MARK:- Dismiss to the previous page
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)//Dismisses the location picker and goes back to the previous page
    }
}
//MARK:- Update Address label
//----------------------------------------------------------------------------------------------------------------------------------------------\\
extension LocationPicker: GMSMapViewDelegate{//This is and extention of he location picker code with the mapview deligate, Can be changed to another file
    
    //This functions calls after the camera position is changed
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target) // the calles Coordinates to Text function with the users newly moved to position
    }
    
    //This funtion takes a coordinate value and shows the address in the address label area
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        // Creating a geo coder object
        let geocoder = GMSGeocoder()
        //Its a function that returns a result of the coordinate address
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            //TODO:- Find out the above lines
            self.locationLabel.text = lines.joined(separator: ",")//This changes the location labels text into the address, joining the lines
            //The UIView gets animated
            //TODO:- Check more upon the animation topic
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    //This is called before the mapview is moved
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        // This shows loading when the user changes to another location (Really good for the UI) until the new location address is fetched
        self.locationLabel.text = "Loading..."
        //TODO:- Create animation in the loading label
        //The UIView gets animated
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }

    
}
//For users location
extension LocationPicker {
    
    
    

}
