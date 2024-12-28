
import UIKit

class StatusViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var StatusTimedUsedLabel: UILabel!
    
    @IBOutlet weak var StatusTimeRemainingLabel: UILabel!
    
    @IBOutlet weak var StatusDistanceCoveredLabel: UILabel!
    
    @IBOutlet weak var StatusCurrentVelocityLabel: UILabel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Retrieve and display the initial data from the shared ExplorationData singleton
        StatusTimedUsedLabel.text = ExplorationData.shared.timeUsed
        
        StatusTimeRemainingLabel.text = ExplorationData.shared.timeRemaining

        let distanceMeters = ExplorationData.shared.distanceCovered
        
        let distanceKm = distanceMeters / 1000
        
        StatusDistanceCoveredLabel.text = String(format: "%.2f Kilometres", distanceKm)
        
        StatusCurrentVelocityLabel.text = String(format: "%.2f m/s", ExplorationData.shared.currentVelocity)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Refresh the labels with the latest data from ExplorationData whenever the view appears
        StatusTimedUsedLabel.text = ExplorationData.shared.timeUsed
        
        StatusTimeRemainingLabel.text = ExplorationData.shared.timeRemaining
        
        let distanceMeters = ExplorationData.shared.distanceCovered
        
        let distanceKm = distanceMeters / 1000
        
        StatusDistanceCoveredLabel.text = String(format: "%.2f Kilometres", distanceKm)
        
        StatusCurrentVelocityLabel.text = String(format: "%.2f m/s", ExplorationData.shared.currentVelocity)
    }
}
