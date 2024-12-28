
import UIKit

import MapKit

import CoreLocation

// used to create audio video players and play
import AVFoundation

// used for create AV Player View -- acceleration audio, forward...
import AVKit

// If you are using SwiftUI elements
import SwiftUI

class ExplorationViewController: UIViewController, MKMapViewDelegate, TreasureSelectionDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var explorationMap: MKMapView!
    
    @IBOutlet weak var explorationBtn: UIButton!
    
    @IBOutlet weak var timeUsedLabel: UILabel!
    
    @IBOutlet weak var resetTimerBtn: UIButton!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    @IBOutlet weak var resetExplorationBtn: UIButton!

    @IBOutlet weak var longSlider: UISlider!
    
    @IBOutlet weak var latSlider: UISlider!
    
    @IBOutlet weak var leftRightLabel: UILabel!
    
    @IBOutlet weak var upDownLabel: UILabel!
    
    @IBOutlet weak var statusViewBtn: UIButton!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    // MARK: - Properties

    // Timer for tracking time used
    var timer_one:Timer = Timer()
    
    // Timer for tracking time remaining
    var timer_two:Timer = Timer()
    
    // Time used for random treasures (in seconds)
    var randomTreasures_timeUsedCount : Int = 0
    
    // Changed variable name
    var randomTreasures_timeRemainingCount : Int = 0
    
    var timerCounting : Bool = false
    
    // Declare the flag
    var hasPresentedAlert = false
    
    var treasure_timeUsedCount : Int = 0
    
    var treasure_timeRemainingCount: Int = 0
    
    // Flag for initial start
    var initialStart = true
    
    // Location manager and annotations
    
    // Manages location services
    let location_man = CLLocationManager()
    
    // An annotation that will be moved
    let aAnnotation = MKPointAnnotation()
    
    // An annotation created on long press
    var Annotation1 = MKPointAnnotation()
       
    // Used for timing annotation movement
    var Timestamp = 0.0
    
    // Add a set to keep track of collided annotations
    var collidedAnnotations: Set<MKPointAnnotation> = []
    
    // Inactivity tracking
    var inactivityTimer: Timer?
    
    var inactivityDuration: TimeInterval = 0
    
    // Declare variables to hold URLs for audio and video files
    let file_src = Bundle.main.url(forResource: "bensound-rebelsofourownkind", withExtension: "mp3")
    
    // Audio player object
    var playerAudio: AVAudioPlayer!
    
    // Distance and score tracking
    var previousLocation: CLLocationCoordinate2D?
    
    var totalDistance: Double = 0
    
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Map view setup
        
        view.addSubview(explorationMap)
        
        explorationMap.frame = view.bounds
        
        explorationMap.delegate = self
        
        // Configure location manager for best accuracy and request authorization
        location_man.desiredAccuracy = kCLLocationAccuracyBest
        
        location_man.requestAlwaysAuthorization()
        
        // Show the user's location on the map
        explorationMap.showsUserLocation = true
        
        // Initially hide all pins
        explorationMap.removeAnnotations(explorationMap.annotations)
        
        // UI setup
        
        // Lock the button
        explorationBtn.isEnabled = false
        
        // Access the Tab Bar Controller and then the TreasureSelectionViewController
        if let tabBarController = self.tabBarController,
           let viewControllers = tabBarController.viewControllers {
            for viewController in viewControllers {
                if let treasureSelectionVC = viewController as? TreasureSelectionViewController {
                    // Set the delegate
                    treasureSelectionVC.delegate = self
                    break
                }
            }
            
            // Create the double-tap gesture recognizer for the exploration button
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(explorationBtnDoubleTapped(_:)))
            
            doubleTap.numberOfTapsRequired = 2
            
            explorationBtn.addGestureRecognizer(doubleTap)
        }
        
        // Hide the button initially
        resetExplorationBtn.isHidden = true
        
        longSlider.isHidden = true
        latSlider.isHidden = true
        
        leftRightLabel.isHidden = true
        upDownLabel.isHidden = true
        
        // Start the inactivity timer
        resetInactivityTimer()
        
        resetTimerBtn.isHidden = true
        
        statusViewBtn.isHidden = true
                
        // Initialize the audio player
        if let path = file_src
        {
            // Try to create an audio player with the provided URL
            playerAudio = try! AVAudioPlayer(contentsOf: path)
        }
        else
        {
            // Print an error message if the audio file is not found
            print("Audio file not found")
        }
        
        // Prepare the audio player for playback
        playerAudio.prepareToPlay()
        
        // Print the audio duration to the console (for debugging purposes)
        print(playerAudio.duration)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        // Set up the initial annotation when the view appears
        aAnnotation.title = "Some where interesting"
        
        aAnnotation.coordinate = CLLocationCoordinate2D(latitude: 1.3324, longitude: 103.775)

        // Center the map on the annotation
        let regionATMyloc = MKCoordinateRegion(
            center: aAnnotation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        
        explorationMap.setRegion(regionATMyloc, animated: true)
    }
    
    // MARK: - Slider Actions
    
    // IBActions for slider value changes
    @IBAction func longChangedS(_ sender: UISlider)
    {
        let newLocation = CLLocationCoordinate2D(latitude: aAnnotation.coordinate.latitude, longitude: 103.775 + Double(sender.value - 0.5) * 0.01)
        
        totalDistance += calculateDistance(from: aAnnotation.coordinate, to: newLocation)

        aAnnotation.coordinate = newLocation

        previousLocation = newLocation

        // Adjust the annotation's longitude based on the slider value
        aAnnotation.coordinate.longitude = 103.775 + Double(sender.value - 0.5) * 0.01
        
        // Check for collision after updating longitude
        checkCollision()
        
        // Reset the inactivity timer
        resetInactivityTimer()
    }
    
    @IBAction func latChangedS(_ sender: UISlider)
    {
        let newLocation = CLLocationCoordinate2D(latitude: 1.3324 + Double(sender.value - 0.5) * 0.01, longitude: aAnnotation.coordinate.longitude)

        // Calculate distance
        totalDistance += calculateDistance(from: aAnnotation.coordinate, to: newLocation)

        // Update annotation location
        aAnnotation.coordinate = newLocation
        
        previousLocation = newLocation

        // Adjust the annotation's latitude based on the slider value
        aAnnotation.coordinate.latitude = 1.3324 + Double(sender.value - 0.5) * 0.01
        
        // Check for collision after updating latitude
        checkCollision()
        
        // Reset the inactivity timer
        resetInactivityTimer()
    }
    
    // MARK: - Inactivity Timer
    
    func resetInactivityTimer() {
        inactivityTimer?.invalidate()
        inactivityDuration = 0
        inactivityTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateInactivityTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateInactivityTimer() {
        inactivityDuration += 1
        
        // 60 seconds of inactivity
        if inactivityDuration >= 60 {
            showInactivityAlert()
            
            // Reset inactivityDuration after showing the alert
            inactivityDuration = 0
        }
    }
    
    func showInactivityAlert() {
        // Check if the ExplorationViewController is currently visible
        if self.tabBarController?.selectedViewController == self {
            // Show an alert to the user about inactivity
            let alertStoppedTooLong = UIAlertController(
                title: "Stopped Too Long",
                message: "You have stopped too long, please resume walking.",
                preferredStyle: .alert
            )

            alertStoppedTooLong.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                // Do nothing
            }))

            alertStoppedTooLong.addAction(UIAlertAction(title: "Okay", style: .destructive))
            present(alertStoppedTooLong, animated: true)
        }
    }
    
    // MARK: - Annotation Movement (Currently Not Used)

    func checkCollision() {
        for annotation in explorationMap.annotations {
            // Skip the aAnnotation itself
            if annotation === aAnnotation { continue }

            // Check if the distance between the two annotations is less than a threshold (e.g., 5 meters)
            let distance = calculateDistance(from: aAnnotation.coordinate, to: annotation.coordinate)
            
            if distance < 10 {
                
                // Check if this annotation has already collided
                guard !collidedAnnotations.contains(annotation as! MKPointAnnotation) else { continue }

                // Increment the score
                score += 4
                
                pointsLabel.text = "\(score)" // Update the pointsLabel

                ExplorationData.shared.score = score // Update the shared score

                // Collision detected! Show the alert
                let alertLocationReached = UIAlertController(
                    title: "Reached Treasure Location",
                    message: "You have arrived at a Treasure Location",
                    preferredStyle: .alert
                )
                
                alertLocationReached.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                    //do nothing
                }))
                
                alertLocationReached.addAction(UIAlertAction(title: "Okay", style: .destructive))
                
                present(alertLocationReached, animated: true)

                // Optionally, you can remove the collided annotation or perform other actions here
                                
                // Add the collided annotation to the set
                collidedAnnotations.insert(annotation as! MKPointAnnotation)

                // Exit the loop after finding a collision
                break
            }
        }
    }
    
    func calculateDistance(from coordinate1: CLLocationCoordinate2D, to coordinate2: CLLocationCoordinate2D) -> Double
    {
        let location1 = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)

        let location2 = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
        
        return location1.distance(from: location2)
        
        // Distance in meters
    }
    
    // 2. Implement the delegate methods
    func didUnlockExploration() {
        // Unlock the button
        explorationBtn.isEnabled = true
    }
    
    func didLockExploration() {
        // Lock the button
        explorationBtn.isEnabled = false
    }
    
    @IBAction func resetTimerTapped(_ sender: UIButton)
    {
        // Reset the initialStart flag when exploration is reset
        initialStart = true
        
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            // do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.randomTreasures_timeUsedCount = 0
            self.timer_one.invalidate()
            self.timeUsedLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.explorationBtn.setTitle("Start Exploration", for: .normal)
            self.explorationBtn.setTitleColor(UIColor.blue, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetExplorationTapped(_ sender: Any)
    {
        longSlider.isHidden = true
        latSlider.isHidden = true
        
        leftRightLabel.isHidden = true
        upDownLabel.isHidden = true
        
        
        score = 0 // Reset the score
        pointsLabel.text = "0" // Update the pointsLabel
        
        let alert = UIAlertController(title: "Start Exploration?", message: "Are you sure you would like to reset the Exploration?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            // do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            
            // 1. Reset the map view
            self.explorationMap.removeAnnotations(self.explorationMap.annotations)
            
            // 2. Reset the explorationBtn
            self.explorationBtn.isEnabled = false
            self.explorationBtn.setTitle("Start Exploration", for: .normal)
            self.explorationBtn.setTitleColor(UIColor.blue, for: .normal)
            
            // 3. Reset the TimerLabel
            self.randomTreasures_timeUsedCount = 0
            self.timer_one.invalidate()
            self.timeUsedLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            
            // 4. Reset the treasure selection switches
            if let tabBarController = self.tabBarController,
               let viewControllers = tabBarController.viewControllers {
                for viewController in viewControllers {
                    if let treasureSelectionVC = viewController as? TreasureSelectionViewController {
                        treasureSelectionVC.resetSwitches() // Call a function to reset switches in TreasureSelectionViewController
                    }
                }
            }
            
            // 5. Reset the timeRemainingLabel
            self.timeRemainingLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            
            self.resetTimerBtn.isHidden = true
            
            // Hide the resetExplorationBtn after reset
            self.resetExplorationBtn.isHidden = true
        }))
        self.present(alert, animated: true, completion: nil)

        // Clear the collidedAnnotations set when resetting the exploration
        collidedAnnotations.removeAll()
    }
    
    @IBAction func explorationBtnDoubleTapped(_ sender: UIButton)
        {

            totalDistance = 0 // Reset distance when a new exploration starts

            // Add the annotation to the map
            explorationMap.addAnnotation(aAnnotation)
            
            // Show the resetExplorationBtn when the exploration starts
            longSlider.isHidden = false
            latSlider.isHidden = false
            
            leftRightLabel.isHidden = false
            upDownLabel.isHidden = false
            
            resetTimerBtn.isHidden = false
            
            resetExplorationBtn.isHidden = false
              
            // Access the Tab Bar Controller and then the TreasureSelectionViewController
            guard let tabBarController = self.tabBarController,
                  let viewControllers = tabBarController.viewControllers else { return }
              
            for viewController in viewControllers {
                if let treasureSelectionVC = viewController as? TreasureSelectionViewController {
                      
                    // Get the selected locations and their difficulty from TreasureSelectionViewController
                    let selectedLocations = treasureSelectionVC.selectedLocations
                      
                    if selectedLocations.isEmpty {
                        // No location selected, handle this case (e.g., show an alert)
                        return
                    }
                      
                    // Clear existing pins on the map
                    explorationMap.removeAnnotations(explorationMap.annotations)
                      
                    if selectedLocations.count == 1 && selectedLocations.keys.contains(0) {
                          
                        // Random location selected
                        _ = treasurelocations[0] // Get the Random Treasure Locations object
                          
                        let difficulty = selectedLocations[0]! // Get the selected difficulty
                          
                        // Set timeRemainingCount only on initial start
                        if initialStart {
                            switch difficulty {
                            case .easy:
//                                 randomTreasures_timeRemainingCount = 11 * 60 // 11 minute in seconds
                                
//                                 randomTreasures_timeRemainingCount = 1 * 60 // 1 minute in seconds
                                
                                randomTreasures_timeRemainingCount = 5 * 60 * 60 // 5 hours in seconds
                                
                            case .medium:
                                randomTreasures_timeRemainingCount = 2 * 60 * 60 + 30 * 60 // 2.5 hours in seconds
                            case .hard:
                                randomTreasures_timeRemainingCount = 1 * 60 * 60 + 15 * 60 // 1.25 hours in seconds
                            }
                            initialStart = false // Set the flag to false after initial start
                        }
                          
                        // Shuffle the treasurelocations array to randomize
                        let shuffledLocations = treasurelocations.shuffled()
                          
                        // Add only the first 5 pins from the shuffled array
                        for i in 0..<5 {
                            let location = shuffledLocations[i]
                            let pin = MKPointAnnotation()
                            pin.coordinate = location.coordinate
                            pin.title = location.location
                            pin.subtitle = location.description
                            explorationMap.addAnnotation(pin)
                            explorationMap.addAnnotation(aAnnotation)
        
                        }
                    }
                      
                    else {
                        for (row, difficulty) in selectedLocations
                        {
                            let location = treasurelocations[row] // Get the TreasureLocation object
                              
                            // Add the pin to the map
                            let pin = MKPointAnnotation()
                            pin.coordinate = location.coordinate
                            pin.title = location.location
                            pin.subtitle = location.description
                            explorationMap.addAnnotation(pin)
                            explorationMap.addAnnotation(aAnnotation)
                              
                            // Set timeRemainingCount only on initial start
                            if initialStart {
                                switch difficulty {
                                case .easy:
                                    
//                                    randomTreasures_timeRemainingCount = 1 * 60 // 1 minute
//                                    randomTreasures_timeRemainingCount = 11 * 60 // 11 minute
                                    
                                    randomTreasures_timeRemainingCount = 1 * 60 * 60 // 5 hours in seconds
                                    
                                case .medium:
                                    randomTreasures_timeRemainingCount = 30 * 60 // 30 minutes in seconds
                                case .hard:
                                    randomTreasures_timeRemainingCount = 15 * 60 // 15 minutes in seconds
                                }
                                
                                // Set the flag to false after initial start
                                initialStart = false
                            }
                        }
                    }
                      
                    break
                }
            }
              
            if(timerCounting)
            {
                timerCounting = false
                  
                timer_one.invalidate()
                timer_two.invalidate()
                  
                explorationBtn.setTitle("Start Exploration", for: .normal)
                explorationBtn.setTitleColor(UIColor.blue, for: .normal)
                
                // Stop playing the audio
                playerAudio.stop()
                
                statusViewBtn.isHidden = false
            }
            else
            {
                timerCounting = true
                explorationBtn.setTitle("End Exploration", for: .normal)
                explorationBtn.setTitleColor(UIColor.red, for: .normal)
                  
                // Initialize timers here
                timer_one = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
                timer_two = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeRemainingCounter), userInfo: nil, repeats: true)
                
                // Start playing the audio from the beginning
                playerAudio.currentTime = 0
                playerAudio.play()
            }
        }
    
    // Map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        guard annotation is MKPointAnnotation else { return nil }
        
        var annotationView = explorationMap.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            // Create the view
            annotationView = MKAnnotationView(
                annotation: annotation,
                reuseIdentifier: "custom"
            )
            annotationView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
            annotationView?.canShowCallout = true
            
            annotationView?.calloutOffset = CGPoint(x: -10, y: -10)
        }
        else {
            // Reuse the annotation view
            annotationView?.annotation = annotation
        }
        
        // Set the hand-drawn pin image for aAnnotation
        if annotation === aAnnotation {
            annotationView?.image = UIImage(named: "icons8-pin-80")
            
        } else {
            annotationView?.image = UIImage(named: "icons8-pin-48") // For other annotations
            
        }
        
        return annotationView
    }
    
    // Handle annotation selection
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let annoteTitle = view.annotation?.title
        {
            print("tapped on:", annoteTitle!)
        }
    }
    
    // Handle taps on the callout accessory
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        let alertWin = UIAlertController(
            title: "Treasure Location",
            message: "There is hidden treasure here.",
            preferredStyle: .alert
        )
        
        alertWin.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            //do nothing
        }))
        
        alertWin.addAction(UIAlertAction(
            title: "Okay",
            style: .destructive
        )
        )
        present(alertWin, animated: true)
    }
    
    @objc func timerCounter() -> Void
    {
        randomTreasures_timeUsedCount = randomTreasures_timeUsedCount + 1
        let time = secondsToHoursMinutesSeconds(seconds: randomTreasures_timeUsedCount)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timeUsedLabel.text = timeString
        
        
        // Update the shared data
        ExplorationData.shared.timeUsed = timeString
        
        ExplorationData.shared.distanceCovered = totalDistance
        
        
        
        // Calculate velocity in meters per second
        let velocity = randomTreasures_timeUsedCount > 0 ? totalDistance / Double(randomTreasures_timeUsedCount) : 0
        
        ExplorationData.shared.currentVelocity = velocity
        
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    @objc func timeRemainingCounter() -> Void
    {
        if randomTreasures_timeRemainingCount > 0 {
            randomTreasures_timeRemainingCount -= 1
            let time = secondsToHoursMinutesSeconds(seconds: randomTreasures_timeRemainingCount)
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
            timeRemainingLabel.text = timeString
            
            // Update the shared data
            ExplorationData.shared.timeRemaining = timeString
        }
        
        if treasure_timeRemainingCount > 0 {
            treasure_timeRemainingCount -= 1
            let time = secondsToHoursMinutesSeconds(seconds: treasure_timeRemainingCount)
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
            timeRemainingLabel.text = timeString
            
            // Update the shared data
            ExplorationData.shared.timeRemaining = timeString
        }
        
        
        // Check for 10 minutes remaining
        if randomTreasures_timeRemainingCount == 10 * 60 && !hasPresentedAlert {
            hasPresentedAlert = true
            let alertExplorationEnd = UIAlertController(
                title: "10 minutes left",
                message: "You have 10 minutes left, please complete your exploration.",
                preferredStyle: .alert
            )
            alertExplorationEnd.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                // Do nothing
            }))
            alertExplorationEnd.addAction(UIAlertAction(title: "Okay", style: .destructive))
            present(alertExplorationEnd, animated: true)
        }
        
        if randomTreasures_timeRemainingCount == 0 {
            timer_two.invalidate()
            // Use a boolean flag to track if the alert has been presented
            if !hasPresentedAlert { // Check the flag
                hasPresentedAlert = true // Set the flag to true
                // Show the alert when timeRemainingLabel reaches 0
                let alertExplorationEnd = UIAlertController(
                    title: "Times Up",
                    message: "Your allotted time has ended.",
                    preferredStyle: .alert
                )
                
                alertExplorationEnd.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                    // Do nothing
                }))
                
                alertExplorationEnd.addAction(UIAlertAction(title: "Okay", style: .destructive))
                present(alertExplorationEnd, animated: true)
            }
        }
    }
}
