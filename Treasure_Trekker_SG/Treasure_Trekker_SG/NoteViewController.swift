
import UIKit

class NoteViewController: UIViewController {

    // Outlets for displaying the note's title and content
    @IBOutlet var titleLabel: UILabel!     // Reference to a UILabel for displaying the note's title
    @IBOutlet var noteLabel: UITextView!   // Reference to a UITextView for displaying the note's content

    // Public variables to hold the note's title and content.
    // These will be set by the previous view controller when navigating to this one
    public var noteTitle: String = ""
    public var note: String = ""

    // Called when the view controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the text of the titleLabel and noteLabel with the passed-in values
        titleLabel.text = noteTitle
        noteLabel.text = note
    }
}
