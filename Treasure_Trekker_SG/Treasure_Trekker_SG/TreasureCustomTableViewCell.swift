
import UIKit

// This class defines a custom table view cell for selecting treasure locations and their difficulty levels
class TreasureCustomTableViewCell: UITableViewCell
{
    // MARK: - Outlets
    
    // Connect to UI elements in the cell's design in the Storyboard
    @IBOutlet weak var treasureLocationLabel: UILabel!
    
    @IBOutlet weak var selectLocationLabel: UILabel!
    
    @IBOutlet weak var selectLocationSwitch: UISwitch!
    
    @IBOutlet weak var challengeTimeLevelsLabel: UILabel!
    
    @IBOutlet weak var easyLabel: UILabel!
    
    @IBOutlet weak var easySwitch: UISwitch!
    
    @IBOutlet weak var mediumLabel: UILabel!
    
    @IBOutlet weak var mediumSwitch: UISwitch!
    
    @IBOutlet weak var hardLabel: UILabel!
    
    @IBOutlet weak var hardSwitch: UISwitch!
    
    // MARK: - Cell Lifecycle
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        // Set labels with proper text
        
        // Rename labels
        selectLocationLabel.text = "Select Location"
        challengeTimeLevelsLabel.text = "Challenge Time Levels"
        easyLabel.text = "Easy"
        mediumLabel.text = "Medium"
        hardLabel.text = "Hard"
        
        // Set all switches to off initially
        selectLocationSwitch.isOn = false
        easySwitch.isOn = false
        mediumSwitch.isOn = false
        hardSwitch.isOn = false
        
        // Hide challenge options initially
        hideChallengeOptions()
    }
    
    // MARK: - Actions
    // These functions are called when UI elements are interacted with

    // Called when the "Select Location" switch is toggled
    @IBAction func selectLocationSwitchToggled(_ sender: UISwitch)
    {
        if sender.isOn
        {
            // Show difficulty options when location is selected
            showChallengeOptions()
        } else {
            // Hide difficulty options when location is deselected
            hideChallengeOptions()
        }
    }
    
    // Called when the "Easy" switch is toggled
    @IBAction func easySwitchToggled(_ sender: UISwitch)
    {
        if sender.isOn
        {
            // Ensure only one difficulty is selected at a time
            mediumSwitch.isOn = false
            hardSwitch.isOn = false
        }
    }
    
    // Called when the "Medium" switch is toggled
    @IBAction func mediumSwitchToggled(_ sender: UISwitch)
    {
        if sender.isOn
        {
            // Ensure only one difficulty is selected at a time
            easySwitch.isOn = false
            hardSwitch.isOn = false
        }
    }
    
    // Called when the "Hard" switch is toggled
    @IBAction func hardSwitchToggled(_ sender: UISwitch)
    {
        if sender.isOn
        {
            // Ensure only one difficulty is selected at a time
            mediumSwitch.isOn = false
            easySwitch.isOn = false
            mediumSwitch.isOn = false
        }
    }
    
    // MARK: - Helper Functions
    // These functions perform specific tasks within the cell

    // Shows the difficulty level options
    func showChallengeOptions() {
        challengeTimeLevelsLabel.isHidden = false
        easyLabel.isHidden = false
        easySwitch.isHidden = false
        mediumLabel.isHidden = false
        mediumSwitch.isHidden = false
        hardLabel.isHidden = false
        hardSwitch.isHidden = false
    }

    // Hides the difficulty level options
    func hideChallengeOptions() {
        challengeTimeLevelsLabel.isHidden = true
        easyLabel.isHidden = true
        easySwitch.isHidden = true
        mediumLabel.isHidden = true
        mediumSwitch.isHidden = true
        hardLabel.isHidden = true
        hardSwitch.isHidden = true
    }

}
