
import UIKit

// 1. Define the delegate protocol
// This protocol allows this view controller to communicate with other parts of your app
protocol TreasureSelectionDelegate: AnyObject
{
    // Called when an exploration becomes available
    func didUnlockExploration()
    
    // Called when an exploration is no longer available
    func didLockExploration()
}


class TreasureSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var table: UITableView!
    
    // MARK: - Properties
    
    // Dictionary to store selected locations and their difficulties
    var selectedLocations: [Int: Difficulty] = [:]
    
    // Flag to indicate if the "Random" location is selected
    var isRandomLocationSelected = false
    
    // Delegate to communicate with other view controllers
    weak var delegate: TreasureSelectionDelegate?

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source for the table view
        table.dataSource = self
        
        // Set the delegate for the table view
        table.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    // These functions provide data to the table view

    // Returns the number of treasure locations to display in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return treasurelocations.count
    }
    
    // Configures and returns a cell to display in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Get the TreasureLocation for this row
        let sunset = treasurelocations[indexPath.row]
        
        // Set the location label text
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TreasureCustomTableViewCell
        
        // Set the location label text
        cell.treasureLocationLabel.text = sunset.location

        // Add targets for switches to call the switchToggled function when their value changes
        cell.selectLocationSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        
        cell.easySwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        
        cell.mediumSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        
        cell.hardSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
                
        // Set the switch state based on the selectedLocations dictionary
        if let difficulty = selectedLocations[indexPath.row] {
            cell.selectLocationSwitch.isOn = true
            cell.showChallengeOptions()
            switch difficulty {
            case .easy:
                cell.easySwitch.isOn = true
                cell.mediumSwitch.isOn = false
                cell.hardSwitch.isOn = false
            case .medium:
                cell.easySwitch.isOn = false
                cell.mediumSwitch.isOn = true
                cell.hardSwitch.isOn = false
            case .hard:
                cell.easySwitch.isOn = false
                cell.mediumSwitch.isOn = false
                cell.hardSwitch.isOn = true
            }
        } else {
            cell.selectLocationSwitch.isOn = false
            cell.hideChallengeOptions()
        }

        // Disable/enable cells based on isRandomLocationSelected
        if isRandomLocationSelected && indexPath.row > 0
        {
            // Disable other locations if "Random" is selected
            cell.selectLocationSwitch.isEnabled = false
        } else if !isRandomLocationSelected && indexPath.row > 0 {
            // Only disable other locations if Random is selected
            cell.selectLocationSwitch.isEnabled = true
        } else {
            // Always enable the "Random" location cell
            cell.selectLocationSwitch.isEnabled = true
        }
        
        return cell
    }
    
    // Sets the height of each row in the table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // MARK: - Actions
    
    // Called when a switch is toggled
    @objc func switchToggled(_ sender: UISwitch) {

        // Get the cell that contains the switch that was toggled
        let cell = sender.superview?.superview as! TreasureCustomTableViewCell // Access the custom cell
        
        // Check which difficulty switch was toggled
        if sender == cell.easySwitch {
            print("easy switch toggled")
        } else if sender == cell.mediumSwitch {
            print("medium switch toggled")
        } else if sender == cell.hardSwitch {
            print("hard switch toggled")
        }

        // Get the index path of the cell
        guard let indexPath = table.indexPath(for: cell) else { return }
        
        // "Random Treasure Locations" cell
        if indexPath.row == 0 {
            isRandomLocationSelected = cell.selectLocationSwitch.isOn
            
            // Disable/enable other cells
            for i in 1..<treasurelocations.count {
                table.cellForRow(at: IndexPath(row: i, section: 0))?.isUserInteractionEnabled = !isRandomLocationSelected
            }
            
        } else {
            // Other treasure location cells
            if cell.selectLocationSwitch.isOn {
                // Disable the "Random Treasure Locations" cell
                isRandomLocationSelected = false
                
                table.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = false
                
                var difficulty: Difficulty
                
                if cell.easySwitch.isOn { difficulty = .easy }
                
                else if cell.mediumSwitch.isOn { difficulty = .medium }
                
                else { difficulty = .hard }
                
                selectedLocations[indexPath.row] = difficulty

                // Update the difficulty in the treasurelocations array
                treasurelocations[indexPath.row].difficulty = difficulty
            } else {
                // Check if any other location is selected before enabling "Random Treasure Locations"
                var anyOtherLocationSelected = false
                
                for i in 1..<treasurelocations.count where i != indexPath.row {
                    if let otherCell = table.cellForRow(at: IndexPath(row: i, section: 0)) as? TreasureCustomTableViewCell,
                       otherCell.selectLocationSwitch.isOn {
                        anyOtherLocationSelected = true
                        break
                    }
                }
                
                table.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = !anyOtherLocationSelected
                
                // Remove the location from selectedLocations
                selectedLocations.removeValue(forKey: indexPath.row)

            }
        }
        
        // Check if the selectLocationSwitch and at least one difficulty switch is on
        if cell.selectLocationSwitch.isOn &&
           (cell.easySwitch.isOn || cell.mediumSwitch.isOn || cell.hardSwitch.isOn) {
            delegate?.didUnlockExploration()
        } else {
            delegate?.didLockExploration()
        }

        // Update the selectedLocations dictionary
        if cell.selectLocationSwitch.isOn {
            let difficulty: Difficulty
            if cell.easySwitch.isOn { difficulty = .easy }
            else if cell.mediumSwitch.isOn { difficulty = .medium }
            else { difficulty = .hard }
            selectedLocations[indexPath.row] = difficulty
        } else {
            selectedLocations.removeValue(forKey: indexPath.row)
        }

    }

    // MARK: - Helper Functions
    
    // Resets all switches to their initial state
    func resetSwitches() {
        selectedLocations = [:] // Clear the selectedLocations dictionary
        isRandomLocationSelected = false

        // Reload the table view to reflect the changes
        table.reloadData()
    }
}
