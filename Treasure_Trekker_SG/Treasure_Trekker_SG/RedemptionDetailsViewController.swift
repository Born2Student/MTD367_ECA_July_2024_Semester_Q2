
import UIKit

// Protocol that allows this view controller to communicate with the GiftShopViewController
protocol RedemptionDelegate: AnyObject {
    // Called when a gift is successfully redeemed
    func didRedeemGift()
}

class RedemptionDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var giftRedemptionEmailTF: UITextField!
        
    @IBOutlet weak var giftRedemptionPhoneTF: UITextField!
    
    @IBOutlet weak var giftRedemptionEmailError: UILabel!
        
    @IBOutlet weak var giftRedemptionPhoneError: UILabel!
    
    @IBOutlet weak var giftRedemptionSubmitBtn: UIButton!
    
    // MARK: - Properties
    
    // Pass gift data to RedemptionDetailsViewController
    var selectedGift: Gift?
    
    // In RedemptionDetailsViewController, add a delegate property:
    weak var delegate: RedemptionDelegate?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Reset the form to its initial state
        resetForm()
    }
    
    // MARK: - Actions
    
    // These functions are called when the corresponding UI elements are interacted with
    @IBAction func emailChanged(_ sender: UITextField)
    {
        if let email = giftRedemptionEmailTF.text
        {
            // Validate the email address
            if let errorMessage = invalidEmail(email)
            {
                giftRedemptionEmailError.text = errorMessage
                giftRedemptionEmailError.isHidden = false
            }
            else
            {
                giftRedemptionEmailError.isHidden = true
            }
        }
        
        // Check if the form is valid
        checkForValidForm()
    }
    
    @IBAction func phoneChanged(_ sender: UITextField)
    {
        if let phoneNumber = giftRedemptionPhoneTF.text
        {
            // Validate the phone number
            if let errorMessage = invalidPhoneNumber(phoneNumber)
            {
                giftRedemptionPhoneError.text = errorMessage
                giftRedemptionPhoneError.isHidden = false
            }
            else
            {
                giftRedemptionPhoneError.isHidden = true
            }
        }
        
        // Check if the form is valid
        checkForValidForm()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any)
    {
        if let gift = selectedGift {
            // Deduct points for the redeemed gift
            ExplorationData.shared.score -= gift.points_needed
            
            // Create a RedeemedGift object and add it to the redeemedGifts array in ExplorationData
            let redeemedGift = RedeemedGift(title: gift.title, points: gift.points_needed, redemptionDate: Date(), imageName: gift.imageName)

            ExplorationData.shared.redeemedGifts.append(redeemedGift)
        }
        
        // Notify the delegate (GiftShopViewController) that a gift has been redeemed
        delegate?.didRedeemGift()

        // Show an alert to confirm gift redemption
        let alertGiftRedemption = UIAlertController(
            title: "Gift Redeemed",
            message: "Congratulations, you have redeemed a gift.",
            preferredStyle: .alert
        )
        
        alertGiftRedemption.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            // Do nothing
        }))
        
        alertGiftRedemption.addAction(UIAlertAction(title: "Okay", style: .destructive))
        
        present(alertGiftRedemption, animated: true)
        
        // Reset the form after submission
        resetForm()
    }
    
    // MARK: - Helper Functions
    // These functions perform specific tasks within the view controller
    
    // Resets the form to its initial state
    func resetForm()
    {
        giftRedemptionSubmitBtn.isEnabled = false
        
        giftRedemptionEmailError.isHidden = false
        giftRedemptionPhoneError.isHidden = false
        
        giftRedemptionEmailError.text = "Required"
        giftRedemptionPhoneError.text = "Required"
        
        giftRedemptionEmailTF.text = ""
        giftRedemptionPhoneTF.text = ""
    }
    
    // Validates the email address
    func invalidEmail(_ value: String) -> String?
    {
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value)
        {
            return "Invalid Email Address"
        }
        
        return nil
    }

    func containsDigit(_ value: String) -> Bool
    {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsLowerCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsUpperCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func invalidPhoneNumber(_ value: String) -> String?
    {
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set)
        {
            return "Phone Number must contain only digits"
        }
        
        if value.count != 8
        {
            return "Phone Number must have 8 Digits"
        }
        return nil
    }
    
    // Checks if the form is valid and enables/disables the submit button accordingly
    func checkForValidForm()
    {
        if giftRedemptionEmailError.isHidden && giftRedemptionPhoneError.isHidden
        {
            giftRedemptionSubmitBtn.isEnabled = true
        }
        else
        {
            giftRedemptionSubmitBtn.isEnabled = false
        }
    }
}
