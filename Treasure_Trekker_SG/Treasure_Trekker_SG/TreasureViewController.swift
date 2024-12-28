
import UIKit

class TreasureViewController: UIViewController
{
    // MARK: - Outlets
    
    // Outlet for the collection view that displays treasures
    @IBOutlet weak var collectionView: UICollectionView!
        
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set the data source and delegate for the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Set the collection view layout to a flow layout
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
}

// MARK: - UICollectionViewDataSource

// This extension provides data to the collection view
extension TreasureViewController: UICollectionViewDataSource
{
    // Returns the number of treasures to display in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return treasures.count
    }
    
    // Configures and returns a cell to display in the collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        // Dequeue a reusable cell with the specified identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TreasureCollectionViewCell", for: indexPath) as! TreasureCollectionViewCell
        
        // Configure the cell with data from the corresponding Treasure object
        cell.setup(with: treasures[indexPath.row])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

// This extension allows you to customize the layout of items in the collection view
extension TreasureViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 392, height: 440)
    }
}

// MARK: - UICollectionViewDelegate

// This extension handles user interaction with the collection view
extension TreasureViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(treasures[indexPath.row].location)
    }
}

