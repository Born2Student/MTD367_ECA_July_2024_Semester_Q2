
import UIKit

// We need a way to store the redeemed gifts. Let's create a new structure to hold the redemption details:
struct RedeemedGift: Codable { // Make it Codable for storage
    let title: String
    let points: Int
    let redemptionDate: Date
    let imageName: String // Store the image name or identifier
}
