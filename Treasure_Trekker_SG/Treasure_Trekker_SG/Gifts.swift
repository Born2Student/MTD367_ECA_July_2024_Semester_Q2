
import UIKit

// Defines a structure to hold information about each gift
struct Gift {
    let title: String
    let points_needed: Int
    let image: UIImage
    // Add imageName property
    let imageName: String
}

// Creates an array of Gift objects, each representing a different gift in the gift shop
let gifts: [Gift] = [
    Gift(title: "$5 SGD Voucher", points_needed: 8, image: #imageLiteral(resourceName: "gift voucher"), imageName: "gift voucher"),
    
    Gift(title: "$5 SGD Voucher", points_needed: 8, image: #imageLiteral(resourceName: "gift voucher"), imageName: "gift voucher"),
    
    Gift(title: "$10 SGD Voucher", points_needed: 12, image: #imageLiteral(resourceName: "gift voucher"), imageName: "gift voucher"),
    
    Gift(title: "$10 SGD Voucher", points_needed: 12, image: #imageLiteral(resourceName: "gift voucher"), imageName: "gift voucher"),
    
    Gift(title: "$20 SGD Voucher", points_needed: 16, image: #imageLiteral(resourceName: "gift voucher"), imageName: "gift voucher"),
    
    Gift(title: "$20 SGD Voucher", points_needed: 16, image: #imageLiteral(resourceName: "gift voucher"), imageName: "gift voucher"),
    
    Gift(title: "Creative Zen Air DOT", points_needed: 20, image: #imageLiteral(resourceName: "Creative Zen Air DOT"), imageName: "Creative Zen Air DOT"),
    
    Gift(title: "Cyxus Aviator Polarized Sunglasses", points_needed: 24, image: #imageLiteral(resourceName: "Cyxus Aviator Polarized Sunglasses"), imageName: "Creative Live Cam Sync 1080p V2"),
    
    Gift(title: "2 GV Tickets for Transformers One", points_needed: 20, image: #imageLiteral(resourceName: "2 GV Tickets for Transformers One"), imageName: "2 GV Tickets for Transformers One"),
    
    Gift(title: "Creative Live Cam Sync 1080p V2", points_needed: 24, image: #imageLiteral(resourceName: "Creative Live Cam Sync 1080p V2"), imageName: "Creative Live Cam Sync 1080p V2"),
    
    Gift(title: "Casio Sports Watch F91W-1D", points_needed: 16, image: #imageLiteral(resourceName: "Casio Digital Watch F91W-1D"), imageName: "Casio Digital Watch F91W-1D")
]
