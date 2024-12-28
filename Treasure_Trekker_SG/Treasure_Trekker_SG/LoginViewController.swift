
import UIKit

class LoginViewController: UIViewController
{
    // MARK: - Outlets
    // These connect to UI elements in your Storyboard
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var emailError: UILabel!
    
    @IBOutlet weak var passwordError: UILabel!
    
    @IBOutlet weak var phoneError: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Create the swipe gesture recognizer
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(submitButtonSwiped(_:)))
        swipeRight.direction = .right // Set the desired swipe direction
        submitButton.addGestureRecognizer(swipeRight)
        
        // Reset the form to its initial state
        resetForm()
    }
    
    // MARK: - Actions
    // These functions are called when the corresponding UI elements are interacted with

    @IBAction func emailChanged(_ sender: UITextField)
    {
        if let email = emailTF.text
        {
            // Validate the email address
            if let errorMessage = invalidEmail(email)
            {
                emailError.text = errorMessage
                emailError.isHidden = false
            }
            else
            {
                emailError.isHidden = true
            }
        }
        
        // Check if the form is valid
        checkForValidForm()
    }
    
    
    @IBAction func passwordChanged(_ sender: UITextField)
    {
        if let password = passwordTF.text
        {
            if let errorMessage = invalidPassword(password)
            {
                passwordError.text = errorMessage
                passwordError.isHidden = false
            }
            else
            {
                passwordError.isHidden = true
            }
        }
        
        // Check if the form is valid
        checkForValidForm()
    }

    
    @IBAction func phoneChanged(_ sender: UITextField)
    {
        if let phoneNumber = phoneTF.text
        {
            // Validate the phone number
            if let errorMessage = invalidPhoneNumber(phoneNumber)
            {
                phoneError.text = errorMessage
                phoneError.isHidden = false
            }
            else
            {
                phoneError.isHidden = true
            }
        }
        
        // Check if the form is valid
        checkForValidForm()
    }
    
    // This function is called when the submit button is swiped right
    @IBAction func submitButtonSwiped(_ sender: Any)
    {
        // MARK - Using Story board
        
        // Instantiate the TabBarController from the storyboard
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController

        // Push the TabBarController onto the navigation stack
        self.navigationController?.pushViewController(storyboard, animated: true)
        
        // Reset the form to its initial state
        resetForm()
    }
    
    // MARK: - Helper Functions
    // These functions perform specific tasks within the view controller
        
    // Resets the form to its initial state
    func resetForm()
    {
        submitButton.isEnabled = false
        
        emailError.isHidden = false
        phoneError.isHidden = false
        passwordError.isHidden = false
        
        emailError.text = "Required"
        phoneError.text = "Required"
        passwordError.text = "Required"
        
        emailTF.text = ""
        passwordTF.text = ""
        phoneTF.text = ""
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
    
    // Validates the password
    func invalidPassword(_ value: String) -> String?
    {
        if value.count < 8
        {
            return "Password must be at least 8 characters"
        }
        if containsDigit(value)
        {
            return "Password must contain at least 1 digit"
        }
        if containsLowerCase(value)
        {
            return "Must contain 1 lowercase character"
        }
        if containsUpperCase(value)
        {
            return "Must contain 1 uppercase character"
        }
        return nil
    }
    
    // Checks if the string contains a digit
    func containsDigit(_ value: String) -> Bool
    {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    // Checks if the string contains a lowercase character
    func containsLowerCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    // Checks if the string contains an uppercase character
    func containsUpperCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    // Validates the phone number
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
        if emailError.isHidden && passwordError.isHidden && phoneError.isHidden
        {
            submitButton.isEnabled = true
        }
        else
        {
            submitButton.isEnabled = false
        }
    }
}
