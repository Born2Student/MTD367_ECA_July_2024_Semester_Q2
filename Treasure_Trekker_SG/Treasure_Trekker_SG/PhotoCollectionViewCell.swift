
import UIKit

// This class defines a custom collection view cell to display photos.
class PhotoCollectionViewCell: UICollectionViewCell {
    
    // A static identifier for reusing cells
    static let identifier = "PhotoCollectionViewCell"
    
    // A private UIImageView to display the photo within the cell
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        // Set content mode to fill the entire image view
        imageView.contentMode = .scaleAspectFill
        
        // Clip any content that goes beyond the bounds
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    // MARK: - Initializers
    
    // This initializer is called when creating the cell programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add the imageView to the cell's content view
        contentView.addSubview(imageView)
        
        // Create an array of UIImages (using optional chaining to handle potential nil images)
        let images = [
            UIImage(named: "1. Dover MRT Station"),
            
            UIImage(named: "2. Blk 21 Dover Crescent Playground"),
            
            UIImage(named: "3. One-north Park"),
            
            UIImage(named: "4. National University Hospital (NUH)"),
            
            UIImage(named: "5. Singapore Polytechnic (SP)"),
            
            UIImage(named: "6. The Japanese Cemetery Park")
        ].compactMap({ $0 })
        
        // Set a random image from the array to the imageView
        imageView.image = images.randomElement()
    }
    
    // This initializer is required when using the cell from a Storyboard/XIB
    required init?(coder: NSCoder) {
        // This should not be called, as we're creating the cell programmatically
        fatalError()
    }
    
    // MARK: - Layout
    
    // This function is called when the cell's layout needs to be updated
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Make the imageView fill the entire cell
        imageView.frame = contentView.bounds
    }
    
    // MARK: - Reuse
    
    // This function is called when the cell is about to be reused
    override func prepareForReuse() {
        super.prepareForReuse()
        // You can add any cleanup code here if needed (e.g., resetting the image)
    }
    
    // MARK: - Public Function
    
    // Sets the image of the cell's imageView
    public func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
