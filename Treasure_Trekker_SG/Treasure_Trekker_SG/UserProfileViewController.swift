
import UIKit

// This view controller manages the user's profile, which has two segments controlled by a UISegmentedControl.
class UserProfileViewController: UIViewController {

    // MARK: - Outlets
    
    // Segmented control to switch between profile views
    @IBOutlet weak var control: UISegmentedControl!
    
    // Container view to hold the currently active profile view
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var postPhotoBtn: UIButton!
    
    // MARK: - Properties

    // Stores the image selected by the user
    var selectedImage: UIImage?
    
    // MARK: - Child View Controllers
    
    // These are the two view controllers that will be displayed in the container view
    private lazy var firstViewController: ProfileFirstViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(identifier: "ProfileFirstViewController") as! ProfileFirstViewController
        // Add the first view controller as a child
        self.add(asChildViewController: viewController)
        return viewController
    }()

    
    private lazy var secondViewController: ProfileSecondViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(identifier: "ProfileSecondViewController") as! ProfileSecondViewController
        // Add the second view controller as a child
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color of the segmented control
        control.backgroundColor = .cyan
        
        // Initially display the first view controller
        updateView()
    }

    // MARK: - Actions

    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        // Update the displayed view controller when the segment changes
        updateView()
    }
    
    @IBAction func postPhotoBtnDidTap(_ sender: UIButton)
    {
        // Allow the user to select a photo from their library
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    // MARK: - Helper Functions
    
    // These functions manage adding and removing child view controllers

    // Updates the displayed view controller based on the selected segment
    private func updateView() {
        if control.selectedSegmentIndex == 0 {
            // Remove the second view controller
            remove(asChildViewController: secondViewController)
            
            // Add the first view controller
            add(asChildViewController: firstViewController)
        } else if control.selectedSegmentIndex == 1 {
            // Remove the first view controller
            remove(asChildViewController: firstViewController)
            
            // Add the second view controller
            add(asChildViewController: secondViewController)
        }
    }

    // Adds a view controller as a child to this view controller
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }

    // Removes a child view controller from this view controller
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

// This extension handles the image picker delegate methods
extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        // Dismiss the image picker if canceled
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        // Dismiss the image picker
        picker.dismiss(animated: true, completion: nil)

        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else
        {
            // Return if no edited image is found
            return
        }

        self.selectedImage = image

        // Pass the selected image to the ProfileSecondViewController if it's the active view
        if control.selectedSegmentIndex == 1
        {
            if let secondVC = self.children.first(where: { $0 is ProfileSecondViewController }) as? ProfileSecondViewController {
                secondVC.addImage(image)
            }
        }
    }
}
