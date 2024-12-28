
import UIKit

// This class defines the layout and behavior of a single cell within your Treasure Collection View
class TreasureCollectionViewCell: UICollectionViewCell
{
    // MARK: - Outlets
    // Connect to the UI elements within your cell's design in the Storyboard
    
    // Displays the treasure image
    @IBOutlet weak var treasureImageView: UIImageView!
    
    // Shows the treasure location name
    @IBOutlet weak var treasureLocationLabel: UILabel!
        
    // Shows the time limit for the treasure
    @IBOutlet weak var treasureTimeLimitLabel: UILabel!
    
    // Provides a description of the treasure or task
    @IBOutlet weak var treasureDescriptionLabel: UILabel!
    
    // Displays the reward for finding the treasure
    @IBOutlet weak var treasureRewardLabel: UILabel!
    
    // MARK: - Setup Function
    // This function configures the cell with data from a Treasure object
    
    func setup(with treasure: Treasure) {
        treasureImageView.image = treasure.image
        
        treasureLocationLabel.text = treasure.location
                
        treasureTimeLimitLabel.text = treasure.timeLimit
        
        treasureRewardLabel.text = treasure.reward
        
        treasureDescriptionLabel.text = treasure.description
    }
}
