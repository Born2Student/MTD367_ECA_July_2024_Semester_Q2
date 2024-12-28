/*
    We'll use a singleton pattern to hold the data that needs to be shared between the two view controllers.
 
    This singleton will be accessible from anywhere in your app.
*/

import Foundation

// This class uses the singleton pattern to store and manage data shared across the application during an exploration.
class ExplorationData: ObservableObject
{
    // MARK: - Published Properties
    
    // These properties, when changed, will automatically update any parts of your UI that observe them.

    // The user's current score
    @Published var score: Int = 0
    
    // An array to store redeemed gifts (assuming you have a RedeemedGift type)
    @Published var redeemedGifts: [RedeemedGift] = []
    
    // MARK: - Shared Instance
    
    // This creates a single, shared instance of the ExplorationData class that can be accessed from anywhere in your app.
    static let shared = ExplorationData()
    
    // MARK: - Properties
    
    var timeUsed: String = ""
    
    var timeRemaining: String = ""
    
    var distanceCovered: Double = 0
    
    var currentVelocity: Double = 0
    
    // MARK: - Private Initializer
    
    // This private initializer ensures that only one instance of ExplorationData can be created.
    private init() {}
}
