
import UIKit

// Defines a Treasure struct to hold information about each treasure location
struct Treasure
{
    // Name of the location
    let location: String
    
    // Image of the location
    let image: UIImage
    
    // Time limit for finding the treasure
    let timeLimit: String
    
    // Reward for finding the treasure
    let reward: String
    
    // Description of the treasure or task
    let description: String
}

// Creates an array of Treasure objects, each representing a different treasure location
let treasures: [Treasure] = [
        
    //  Treasure Location 1
    Treasure(
        location: "SIM Global Education",
        image: #imageLiteral(resourceName: "1. SIM Global Education"),
        timeLimit: "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15",
        reward: "Points: 4",
        description: "Description: Find the plaque commemorating SIM's founding."
    ),
    
    //  Treasure Location 2
    Treasure(
        location: "Lien Ying Chow Library",
        image: #imageLiteral(resourceName: "2. Lien Ying Chow Library"),
        timeLimit: "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15",
        reward: "Points: 4",
        description: "Description: How many floors does the library have?"
    ),
    
    //  Treasure Location 3
    Treasure(
        location: "Ngee Ann Poly Futsal Court",
        image: #imageLiteral(resourceName: "3. Ngee Ann Poly Futsal Court"),
        timeLimit: "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15",
        reward: "Points: 4",
        description: "Description: Take a panoramic photo of the entire court."
    ),
    
    //  Treasure Location 4
    Treasure(
        location: "King Albert Park",
        image: #imageLiteral(resourceName: "4. King Albert Park"),
        timeLimit: "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15",
        reward: "Points: 4",
        description: "Description: Locate the playground within the park."
    ),
    

    //  Treasure Location 5
    Treasure(
        location: "Ngee Ann Poly Block 50",
        image: #imageLiteral(resourceName: "5. Ngee Ann Poly Block 50"),
        timeLimit: "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15",
        reward: "Points: 4",
        description: "Description: Find the directory board in the building."
    ),
    
    //  Treasure Location 6
    Treasure(
        location: "Old Jurong Railway",
        image: #imageLiteral(resourceName: "6. Old Jurong Railway"),
        timeLimit: "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15",
        reward: "Points: 4",
        description: "Description: Take a selfie with the railway station."
    ),
    
    //  Treasure Location 7
    Treasure(
        location: "King Albert Lodge",
        image: #imageLiteral(resourceName: "7. King Albert Lodge"),
        timeLimit: "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15",
        reward: "Points: 4",
        description: "Description: How many windows on the front facade?"
    ),
    
    //  Treasure Location 8
    Treasure(
        location: "Methodist Girls' School",
        image: #imageLiteral(resourceName: "8. Methodist Girls' School"),
        timeLimit: "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15",
        reward: "Points: 4",
        description: "Description: Locate the main entrance to MGS."
    ),
    
    //  Treasure Location 9
    Treasure(
        location: "Rail Corridor (Bukit Timah)",
        image: #imageLiteral(resourceName: "9. Rail Corridor (Bukit Timah)"),
        timeLimit: "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15",
        reward: "Points: 4",
        description: "Description: Find a marker post along the Rail Corridor."
    ),

    //  Treasure Location 10
    Treasure(
        location: "Singapore Institute of Technology (SIT@NP)",
        image: #imageLiteral(resourceName: "10. Singapore Institute of Technology (SIT@NP)"),
        timeLimit: "Challenge Time Levels (Easy/Medium/Hard - Minutes): 60 / 30 / 15",
        reward: "Points: 4",
        description: "Description: Find the SIT logo."
    )
    
]

