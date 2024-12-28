
import UIKit

class EntryViewController: UIViewController {

    // Outlets for the title input field and the note text view
    @IBOutlet var titleField: UITextField!   // Reference to a UITextField for entering the note's title
    @IBOutlet var noteField: UITextView!     // Reference to a UITextView for entering the note's content

    // Optional closure to be called when the note is saved
    // This will be set by the presenting view controller to handle the saved note data
    public var completion: ((String, String) -> Void)?
//
//    // Called when the view controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()

//        // Make the titleField the first responder, so the keyboard appears automatically
        titleField.becomeFirstResponder()
//
//        // Create a "Save" button on the right side of the navigation bar
//        // When tapped, it will trigger the didTapSave function
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }

    // Function called when the "Save" button is tapped
    @objc func didTapSave() {
        // Check if there's text in both the titleField and noteField
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
            // If so, call the completion handler with the title and note text
            completion?(text, noteField.text)
        }
        // If either field is empty, do nothing (no saving)
    }
}
