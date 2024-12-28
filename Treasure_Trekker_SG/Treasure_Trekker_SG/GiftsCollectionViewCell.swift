
import UIKit

class GiftsCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var giftImageView: UIImageView!
    
    @IBOutlet weak var giftTitleLabel: UILabel!
    
    @IBOutlet weak var giftPriceLabel: UILabel!
    
    @IBOutlet weak var giftBtn: UIButton!
    
    // MARK: - Properties
    
    var currentPoints: Int = 0
    
    // Reference to the RedemptionDetailsViewController
    var redemptionVC: RedemptionDetailsViewController!
    
    // Stores the index path of the cell
    var indexPath: IndexPath!
    
    // MARK: - Setup Function
    
    func setup(with gift: Gift) {
        giftImageView.image = gift.image
        
        giftTitleLabel.text = gift.title
        
        giftPriceLabel.text = "\(gift.points_needed)"
        
        // Enable/disable the redeem button based on whether the user has enough points
        giftBtn.isEnabled = currentPoints >= gift.points_needed
    }
    
    // MARK: - Actions
    
    @IBAction func giftBtnTapped(_ sender: UIButton)
    {
        print("Redeem Gift Button Tapped")
        
        // Set the selected gift in the redemptionVC
        redemptionVC.selectedGift = gifts[indexPath.row]
        
        // In GiftsCollectionViewCell, in the giftBtnTapped method, set the delegate of redemptionVC to the GiftShopViewController instance:
        redemptionVC.delegate = self.window?.rootViewController as? GiftShopViewController
        
        // Present the redemptionVC modally
        self.window?.rootViewController?.present(redemptionVC, animated: true, completion: nil)
    }
}
