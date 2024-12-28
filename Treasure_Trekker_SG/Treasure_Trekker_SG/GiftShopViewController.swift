
import UIKit

// This view controller manages the gift shop where users can redeem gifts using their points.
class GiftShopViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var currentPointsLabel: UILabel!
    
    @IBOutlet weak var giftCollectionView: UICollectionView!

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display the initial score from ExplorationData
        currentPointsLabel.text = "\(ExplorationData.shared.score)"
        
        // Set up the collection view
        giftCollectionView.dataSource = self
        giftCollectionView.delegate = self
        giftCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update the score label with the latest value from ExplorationData
        currentPointsLabel.text = "\(ExplorationData.shared.score)"
        
        // Refresh the collection view to update button states (enable/disable based on points)
        giftCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension GiftShopViewController: UICollectionViewDataSource {
    
    // Returns the number of gifts to display in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifts.count
    }
    
    // Configures and returns a cell to display in the collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GiftsCollectionViewCell", for: indexPath) as! GiftsCollectionViewCell
        
        // Configure the cell with gift data
        cell.setup(with: gifts[indexPath.row])
        
        // Provide the current points to the cell
        cell.currentPoints = ExplorationData.shared.score

        // Instantiate RedemptionDetailsViewController
        let redemptionVC = self.storyboard!.instantiateViewController(withIdentifier: "RedemptionDetailsViewController") as! RedemptionDetailsViewController
        
        // Set the redemptionVC property of the cell
        cell.redemptionVC = redemptionVC
        
        // Set the indexPath property of the cell
        cell.indexPath = indexPath

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GiftShopViewController: UICollectionViewDelegateFlowLayout {
    
    // Defines the size of each item (gift cell) in the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }
}

// MARK: - UICollectionViewDelegate

extension GiftShopViewController: UICollectionViewDelegate {
    
    // Called when an item (gift cell) in the collection view is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(gifts[indexPath.row].title)
    }
}

// MARK: - RedemptionDelegate

// Make GiftShopViewController conform to the RedemptionDelegate protocol:
extension GiftShopViewController: RedemptionDelegate {
    
    func didRedeemGift() {
        // Update the points label and refresh the collection view after a gift is redeemed
        currentPointsLabel.text = "\(ExplorationData.shared.score)"
        giftCollectionView.reloadData()
    }
}
