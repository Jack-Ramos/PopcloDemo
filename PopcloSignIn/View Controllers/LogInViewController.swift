//
//  LogInViewController.swift
//  PopcloSignIn
//
//  Created by Jack Ramos on 8/2/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        
        //hide error label
        errorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
    }
    
    
    func validateFields()-> String?{
        
        //check that all fields are filled in
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidEmail(cleanedEmail) == false{
            //email not legit
            return "Please enter a valid email"
            
        }
        
        
        
        //check if password is secure
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if  Utilities.isPasswordValid(cleanedPassword) == false{
            //password not secure
            
            return "Password must have 8 characters, include a number and a special character"
        }
        return nil
    }

    
    @IBAction func loginTapped(_ sender: Any) {
        
        //validate text fields
        let error = validateFields()
        
        if error != nil {
            //there is something wrong with the fields
            showError(error!)
        }
        else{
            
            //create cleaned versions of data
            let email = emailTextField.text!.trimmingCharacters(in:.whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Signin user
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error != nil {
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                    
                }
                else{
                    self.transitionToHome()
                }
            }
        }
            
            
        
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    func transitionToHome(){
            
        let homeViewContoller = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController)as?
                HomeViewController
            
        view.window?.rootViewController = homeViewContoller
        view.window?.makeKeyAndVisible()
    }
            
    

}
