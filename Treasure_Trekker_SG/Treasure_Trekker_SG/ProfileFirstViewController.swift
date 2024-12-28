
import UIKit

import Foundation

// If you are using SwiftUI elements
import SwiftUI

// This view controller manages the first view in the user's profile, likely displaying a list of redeemed gifts.
class ProfileFirstViewController: UIViewController {

    // MARK: - Outlets
    
    // Outlet for the table view
    @IBOutlet weak var redeemedGiftsTableView: UITableView!

    // MARK: - Properties

    // An observed object to access shared data
    @ObservedObject var explorationData = ExplorationData.shared
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the table view's data source
        redeemedGiftsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reload the table view data when the view appears
        redeemedGiftsTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

// This extension provides data to the table view
extension ProfileFirstViewController: UITableViewDataSource
{
    // Returns the number of redeemed gifts to display in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return explorationData.redeemedGifts.count
    }

    // Configures and returns a cell to display in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = redeemedGiftsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GiftRedeemdTableViewCell
        
        let redeemedGift = explorationData.redeemedGifts[indexPath.row]

        // Configure the cell with redeemedGift data
        cell.gift_redeemed.text = redeemedGift.title
        
        cell.points_required.text = "\(redeemedGift.points)"
        
        // Assuming you store image names
        cell.iconImageView.image = UIImage(named: redeemedGift.imageName)
   
        return cell
    }
    
    // This function currently returns 0, which means the cells will not be visible.
    // You likely want to return an appropriate height for your cells here.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
}
