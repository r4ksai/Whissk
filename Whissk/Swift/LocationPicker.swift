//
//  LocationPicker.swift
//  Whissk
//
//  Created by Sai Madhav on 20/08/18.
//  Copyright © 2018 Sai Madhav. All rights reserved.
//
// Create an Error handling code so that the grapical frame can be displayed on a error
// Import some codes into clean code manager so that the class had less code and it wont be clustered
// Use classes and methords more for data localisation
//The User location is found and the map view gets updated to the users location coordinate
//The user location button is there that updates the mapview to go back again to the users location
//Whatever the user gets can be displyed using Update camera function
//If the user presses more details then a slide up comes asking for the users location 
//My locations should show or not ?
//Show users saved locations 

//TODO:- Location picker to type the location so that the map points towatds that 
import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import CoreLocation

class LocationPicker: UIViewController,CLLocationManagerDelegate {

    //Variables
    @IBOutlet weak var locationLabel: UIButton!
    @IBOutlet weak var mapView: GMSMapView! //The Map
    let locationManager = CLLocationManager() //Location Manager


    //MARK:- Status bar color to white text
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //To set the location Manager when the view loads
        readyLocationManager()
        
 
        
    }
    
    @IBAction func changeLocation(_ sender: Any) {
        let neBoundsCorner = CLLocationCoordinate2D(latitude: 18.72220221,
                                                    longitude: 73.60523526)
        let swBoundsCorner = CLLocationCoordinate2D(latitude: 18.42670377,
                                                    longitude: 74.10030667)
        let bounds = GMSCoordinateBounds(coordinate: neBoundsCorner,
                                         coordinate: swBoundsCorner)

        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Set a filter to return only addresses.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        autocompleteController.autocompleteBounds = bounds
        present(autocompleteController, animated: true, completion: nil)
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
    
    //Location is used after the user gets coordinats from the address picker
    //Check if changing camera ready map view can be changed to update this way for the users location button
    //MARK:- Update The location after Picking
    func updateCamera(center : CLLocationCoordinate2D){
        let target = GMSCameraUpdate.setTarget(center)// Maps camera position to users location
        mapView.moveCamera(target)//To animate the location of the camera from x to y
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
            self.locationLabel.setTitle(lines.joined(separator: ","), for: .normal) //This changes the location labels text into the address, joining the lines
            //The UIView gets animated
            //TODO:- Check more upon the animation topic
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
                
            }
        }
    }
    
    //This is called before the mapview is moved
    //TODO:- Set Mapview loading
    //set this in such a way that the location gets called if the user moves not if the user leaves the touch 
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        // This shows loading when the user changes to another location (Really good for the UI) until the new location address is fetched
        self.locationLabel.setTitle("Loading...", for: .normal)
        //TODO:- Create animation in the loading label
        //The UIView gets animated
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }

    
}
//For users location
extension LocationPicker : GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Print place info to the console.
        updateCamera(center: place.coordinate)
        
        // TODO: Add code to get address components from the selected place.
        
        // Close the autocomplete widget.
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Show the network activity indicator.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // Hide the network activity indicator.
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    

}
