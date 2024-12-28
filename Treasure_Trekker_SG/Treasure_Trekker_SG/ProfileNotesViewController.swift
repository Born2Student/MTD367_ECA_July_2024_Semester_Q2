
import UIKit

class ProfileNotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var testLabel: UILabel!
    
    // Outlets for the table view and label in the UI
    @IBOutlet var table: UITableView!  // Reference to the UITableView in the storyboard
    @IBOutlet var label: UILabel!     // Reference to a UILabel (likely for placeholder text when no notes exist)
    
    // Array to store the notes. Each note is a tuple with a title and the actual note content
    var models: [(title: String, note: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title of the navigation bar
        title = "Notes"

        // Set this view controller as the delegate and data source for the table view
        // This means this class will handle providing data to the table and responding to user interactions
        table.delegate = self
        table.dataSource = self


    }
    
    // Action triggered when the "New Note" button is tapped
    @IBAction func didTapNewnote() {
        // Attempt to instantiate the "EntryViewController" from the storyboard
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "new") as? EntryViewController else {
            return // If instantiation fails, do nothing and exit the function
        }

        // Set the title of the new note view controller
        vc.title = "New Note"

        // Disable large titles for this view controller
        vc.navigationItem.largeTitleDisplayMode = .never

        // Set a completion handler to be called when the new note is saved
        vc.completion = { noteTitle, note in
            // Navigate back to the root view controller (this view controller)
            self.navigationController?.popToRootViewController(animated: true)

            // Append the new note to the models array
            self.models.append((title: noteTitle, note: note))

            // Hide the label (likely a placeholder) and show the table
            self.label.isHidden = true
            self.table.isHidden = false

            // Reload the table view to display the new note
            self.table.reloadData()
        }

        // Push the new note view controller onto the navigation stack
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    // MARK: - Table View Data Source Methods

    // Return the number of rows (notes) to display in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    // Configure and return a cell to display at the specified index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell with the identifier "cell"

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Set the title and note text for the cell
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].note

        return cell
    }

    // MARK: - Table View Delegate Methods

    // Called when a row (note) is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // Deselect the row with animation
        tableView.deselectRow(at: indexPath, animated: true)

        // Get the selected note model
        let model = models[indexPath.row]

        // Attempt to instantiate the "NoteViewController" from the storyboard
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else {
            return
        }

        // Disable large titles for this view controller
        vc.navigationItem.largeTitleDisplayMode = .never

        // Set the title of the note view controller
        vc.title = "Note"

//         Pass the note title and content to the note view controller
        vc.noteTitle = model.title
        vc.note = model.note

        // Push the note view controller onto the navigation stack
        navigationController?.pushViewController(vc, animated: true)
    }

}
