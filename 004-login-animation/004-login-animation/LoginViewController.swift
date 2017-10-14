import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 淡入的效果
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = 1
        }
        
        // user name 效果
        userNameField.frame =  CGRect(x: -270, y: 50, width: 270, height: 40)
        userNameField.borderStyle = .roundedRect
        userNameField.placeholder = "UserName"
        
        UIView.animate(withDuration: 0.5, delay: 0.6, usingSpringWithDamping: 0.9, initialSpringVelocity: 2, options: .allowAnimatedContent, animations: {
            self.userNameField.center.x = self.view.center.x
        }, completion: nil)
        
        
        // password
        passwordField.frame =  CGRect(x: -270, y: 100, width: 270, height: 40)
        passwordField.borderStyle = .roundedRect
        passwordField.placeholder = "Password"
        
        UIView.animate(withDuration: 0.5, delay: 0.8, usingSpringWithDamping: 0.9, initialSpringVelocity: 2, options: .allowAnimatedContent, animations: {
            self.passwordField.center.x = self.view.center.x
        }, completion: nil)
        
        // login
        loginButton.frame = CGRect(x: -125, y: 160, width: 125, height: 40)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = UIColor(red: 22/255.0, green: 139/255.0, blue: 3/255.0, alpha: 1)
        
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn, animations: {
            self.loginButton.center.x = self.view.center.x
        }) { (isComplete) in
            
            // usingSpringWithDamping: 0-1, the less the more exaggerate
            // initialSpringVelocity: the bigger the faster init speed
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options:.allowAnimatedContent, animations: {
                self.loginButton.frame.size.width = 180
                self.loginButton.center.x = self.view.center.x
            }, completion: nil)
        }
    }
    
    @IBAction func loginAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
