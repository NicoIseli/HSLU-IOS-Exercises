//
//  ViewController.swift
//  Frame-Works
//
//  Created by nico on 27.10.20.
//

import UIKit
import ContactsUI
import EventKitUI
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CNContactPickerDelegate, EKEventEditViewDelegate {
    
    
    
    
    
    // MARK: - Attributes of the class ViewController
    let annotationTitleHSLU = "HSLU"
    let annotationSubTitleHSLU = "Deparement Informatik"
    let annotationCoordinatesHSLU = (lat: 47.143516, lon: 8.432762)
    
    let annotationTitleTrainStation = "Bahnhof Rotkreuz"
    let annotationCoordinatesTrainStation = (lat: 47.141633 , lon: 8.4306651)
    
    let eventStore = EKEventStore()
    var events: [EKEvent] = []
    

    
    
    // MARK: - IBOutles
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    
    
    // MARK: - IBActions
    
    // Function called when pressing Contacts-Button
    @IBAction func contactsButtonPressed(_ sender: Any) {
        let contactVC = CNContactPickerViewController()
        contactVC.delegate = self
        contactVC.modalPresentationStyle = .fullScreen
        self.show(contactVC, sender: nil)
        
        
    }
    
    // Function called when pressing HSLU-Button
    @IBAction func HSLUButtonPressed(_ sender: Any) {
        self.adjustRegtion()
    }
    
    // Function called when pressing Events-Button
    @IBAction func EventsButtonPressed(_ sender: Any) {
        
        if (self.events.count > 0){
            let event = self.events[0]
            let eventVC = EKEventEditViewController()
            eventVC.event = event
            eventVC.eventStore = self.eventStore
            eventVC.editViewDelegate = self
            eventVC.modalPresentationStyle = .fullScreen
            self.show(eventVC, sender: nil)
            
        } else {
            let alertController = UIAlertController(
                title: "No event was found during the next week",
                message: "Create an event in your calendar",
                preferredStyle: .alert)
            let defaultAction = UIAlertAction(
                title: "OK",
                style: .cancel,
                handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    
    // MARK: - Functions of the App-Lifecycle
    
    // Function called when View has loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        let annotationHSLU = MKPointAnnotation()
        annotationHSLU.title = annotationTitleHSLU
        annotationHSLU.subtitle = annotationSubTitleHSLU
        annotationHSLU.coordinate = CLLocationCoordinate2D(latitude: annotationCoordinatesHSLU.lat, longitude: annotationCoordinatesHSLU.lon)
        
        let annotationTrainStation = MKPointAnnotation()
        annotationTrainStation.title = annotationTitleTrainStation
        annotationTrainStation.coordinate = CLLocationCoordinate2D(latitude: annotationCoordinatesTrainStation.lat, longitude: annotationCoordinatesTrainStation.lon)
        
        self.mapView.addAnnotation(annotationHSLU)
        self.mapView.addAnnotation(annotationTrainStation)
    }
    
    // Function called before View appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.adjustRegtion()
        self.getAccessToCalender()
    }
    
    
    
    
    
    // MARK: - Functions for the Map-View
    
    // Function to change color and behaviour of the pins
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        
        if(annotation.title == "HSLU"){
            annoView.canShowCallout = true
            annoView.rightCalloutAccessoryView = UIButton(type: .infoDark)
            annoView.image = UIImage(named: "Study")
            
        } else {
            annoView.canShowCallout = true
            annoView.pinTintColor = .cyan
        }
        
        return annoView
    }
    
    // Function to define the behaviour after clicking on the Info-Icon
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let alertController = UIAlertController(
            title: "What a genius 😮😮😮",
            message: "You figured out how to use an alert-box 👏",
            preferredStyle: .alert)
        let defaultAction = UIAlertAction(
            title: "OK",
            style: .cancel,
            handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    

    
    
    // MARK: - Functions for Contact-Picker
    
    // Function to set name from contacts
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        self.firstNameLabel.text = contact.givenName
        self.lastNameLabel.text = contact.familyName
    }
    
    
    
    
    
    // MARK: - Functions for Event-Edit-View
    
    // Function to dismiss the Event-Edit-View
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    // MARK: - Supporting Functions
    
    // Function to get matching Event
    func loadEvents() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // Get current date
        let now = Date()
        let nowString = dateFormatter.string(from: now)
        let startDate = dateFormatter.date(from: nowString)
        
        // Get date in a week from now
        var dateComponent = DateComponents()
        dateComponent.day = 7
        let nextWeek = Calendar.current.date(byAdding: dateComponent, to: now)
        let nextWeekString = dateFormatter.string(from: nextWeek!)
        let endDate = dateFormatter.date(from: nextWeekString)
    
        if let startDate = startDate, let endDate = endDate {
            
            let eventsPredicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
    
               
            self.events = eventStore.events(matching: eventsPredicate)
                
        }
    }
    
    // Function to ask for persmission to access the Calendar
    func getAccessToCalender () {
        eventStore.requestAccess(to: .event) { (granted, error) in
            if granted {
                self.loadEvents()
            }
        }
    }
    
    // Function to set a specific Region for the map
    func adjustRegtion(){
        self.mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: annotationCoordinatesHSLU.lat, longitude: annotationCoordinatesHSLU.lon), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
    }
}

