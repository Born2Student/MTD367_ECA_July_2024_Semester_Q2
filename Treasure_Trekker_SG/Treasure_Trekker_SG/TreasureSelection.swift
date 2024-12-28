
import UIKit

import MapKit

import CoreLocation

// Defines a structure to hold information about each treasure location
struct TreasureLocation
{
    // Name of the location
    let location: String
    
    // Coordinates of the location
    let coordinate: CLLocationCoordinate2D
    
    // Description of the task or challenge
    let description: String
    
    // Difficulty level (easy, medium, hard)
    var difficulty: Difficulty
    
    // Time limit to find the treasure (in seconds)
    var timeLimit: Int
    
    // Reward points for finding the treasure
    var reward: Int
}

// Creates an array of TreasureLocation objects, each representing a different treasure location
var treasurelocations: [TreasureLocation] = [
    
    //  Treasure Location 1
    TreasureLocation(
        location: "Random Treasure Locations",
        coordinate: CLLocationCoordinate2D(latitude: 1.2867,longitude: 103.7910),
        description: "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15",
        // "Challenge Time Levels (Easy/Medium/Hard - Minutes): 300 / 150 / 75"
        difficulty: Difficulty.easy,
        timeLimit: 1,
        reward: 1
    ),
    
    // 1. SIM Global Education Coordinates
    TreasureLocation(
        location: "SIM Global Education",
        coordinate: CLLocationCoordinate2D(
                latitude: 1.3294,
                longitude: 103.7762
            ),
        description: "Find the plaque commemorating SIM's founding.",
        // "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15"
        difficulty: .easy,
        timeLimit: 1,
        reward: 1
    ),
    
    // 2. Lien Ying Chow Library Coordinates
    TreasureLocation(
        location: "Lien Ying Chow Library",
        coordinate: CLLocationCoordinate2D(
                latitude: 1.333586,
                longitude: 103.776868
            ),
        description: "How many floors does the library have?",
        // "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15"
        difficulty: .easy,
        timeLimit: 1,
        reward: 1
    ),
    
    // 3. Ngee Ann Poly Futsal Court Coordinates
    TreasureLocation(
        location: "Ngee Ann Poly Futsal Court",
        coordinate: CLLocationCoordinate2D(
                latitude: 1.332060,
                longitude: 103.777084
            ),
        description: "Take a panoramic photo of the entire court.",
        // "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15"
        difficulty: .easy,
        timeLimit: 1,
        reward: 1
    ),
    
    // 4. King Albert Park Coordinates
    TreasureLocation(
        location: "King Albert Park",
        coordinate: CLLocationCoordinate2D(
                latitude: 1.334044,
                longitude: 103.779700
            ),
        description: "Locate the playground within the park.",
        // "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15"
        difficulty: .easy,
        timeLimit: 1,
        reward: 1
    ),
    
    // 5. Ngee Ann Poly Block 50 Coordinates
    TreasureLocation(
        location: "Ngee Ann Poly Block 50",
        coordinate: CLLocationCoordinate2D(
                latitude: 1.331557,
                longitude: 103.773971
            ),
        description: "Find the directory board in the building.",
        // "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15"
        difficulty: .easy,
        timeLimit: 1,
        reward: 1
    ),
    
    // 6. Old Jurong Railway
    TreasureLocation(
        location: "Old Jurong Railway",
        coordinate: CLLocationCoordinate2D(
                latitude: 1.328323,
                longitude: 103.780313
            ),
        description: "Take a selfie with the railway station.",
        // "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15"
        difficulty: .easy,
        timeLimit: 1,
        reward: 1
    ),
    
    // 7. King Albert Lodge Coordinates
    TreasureLocation(
        location: "King Albert Lodge",
        coordinate: CLLocationCoordinate2D(
                latitude: 1.336467,
                longitude: 103.780312
            ),
        description: "How many windows on the front facade?",
        // "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15"
        difficulty: .easy,
        timeLimit: 1,
        reward: 1
    ),
    
    // 8. Maju Camp Coordinates
    TreasureLocation(
        location: "Methodist Girls' School",
        coordinate: CLLocationCoordinate2D(
                latitude: 1.332852,
                longitude: 103.783459
            ),
        description: "Locate the main entrance to MGS.",
        // "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15"
        difficulty: .easy,
        timeLimit: 1,
        reward: 1
    ),
    
    // 9. Rail Corridor (Bukit Timah) Coordinates
    TreasureLocation(
        location: "Rail Corridor (Bukit Timah)",
        coordinate: CLLocationCoordinate2D(
                latitude: 1.331612,
                longitude: 103.781242
            ),
        description: "Find a marker post along the Rail Corridor.",
        // "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15"
        difficulty: .easy,
        timeLimit: 1,
        reward: 1
    ),
    
    // 10. Singapore Institute of Technology (SIT@NP) Coordinates
    TreasureLocation(
        location: "Singapore Institute of Technology (SIT@NP)",
        coordinate: CLLocationCoordinate2D(
                latitude: 1.334106,
                longitude: 103.774496
            ),
        description: "Find the SIT logo.",
        // "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15"
        difficulty: .easy,
        timeLimit: 1,
        reward: 1
    )

]

// Defines an enumeration for the difficulty levels of treasure locations
enum Difficulty
{
    case easy, medium, hard
}
