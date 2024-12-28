
import UIKit

// This view controller manages a collection view to display photos.
class ProfileSecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Outlets

    @IBOutlet weak var noImageLabel: UILabel!
    
    // MARK: - Properties
    
    // The collection view to display photos
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // An array to store the images to be displayed
    private var images: [UIImage] = []
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initially hide the "no images" label
        noImageLabel.isHidden = true
        
        // Register the PhotoCollectionViewCell for use in the collection view
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)

        // Set the collection view's delegate
        collectionView.delegate = self
        
        // Set the collection view's data source
        collectionView.dataSource = self
        
        // Add the collection view to the view controller's view
        view.addSubview(collectionView)
        
        // This line of code tells the view to rearrange its subviews so that noImageLabel is placed at the top of the stack, ensuring it's visible above other elements like the collectionView and the UIView container.
        view.bringSubviewToFront(noImageLabel)
    }
    
    // Called when the view's layout has been calculated and subviews are about to be positioned
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Make the collection view fill the entire view
        collectionView.frame = view.bounds
    }
    
    // MARK: - Public Function
    
    // Adds an image to the images array and reloads the collection view
    func addImage(_ image: UIImage) {
        images.append(image)
        collectionView.reloadData()
        
        // Hide the label after adding an image
        noImageLabel.isHidden = true
    }
    
    // MARK: - UICollectionViewDataSource
    // These functions provide data to the collection view

    // Returns the number of photos to display
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if images.count == 0 {
            // Show the label if no images
            noImageLabel.isHidden = false
        } else {
            // Hide the label if images are present
            noImageLabel.isHidden = true
        }
        
        return images.count
    }

    // Returns a configured cell for the collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        
        // Set the image for the cell
        cell.setImage(images[indexPath.item])

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    // These functions control the layout of the collection view

    // Sets the size of each photo item in the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(
            width: (view.frame.size.width/3)-3,
            height: (view.frame.size.width/3)-3
        )
    }
    
    // Sets the spacing between items in the same row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // Sets the spacing between rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // Sets the insets for the collection view section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    // Called when an item in the collection view is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Deselect the item with animation
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("Selected section \(indexPath.section) and row \(indexPath.row)")
    }
}
