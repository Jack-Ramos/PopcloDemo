//
//  SignUpViewController.swift
//  PopcloSignIn
//
//  Created by Jack Ramos on 8/2/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseCore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements(){
        //hide error label
        errorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //check the fields and validate data, if correct return nill, if wrong return error message as string
    func validateFields()-> String?{
        
        //check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        //check if email is real
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidEmail(cleanedEmail) == false{
            //email not legit
            return "Please enter a valid email"
            
        }
        
        
        
        //check if password is secure
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if  Utilities.isPasswordValid(cleanedPassword) == false{
            //password not secure
            
            return "Please make sure your password is at least 8 characters and contains a special character and a number"
        }
        
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        //validate the fields
        
        let error = validateFields()
        
        if error != nil {
            //there is something wrong with the fields
            showError(error!)
        }
        else{
            
            //create cleaned versions of data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in:.whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for errors
                if err != nil{
                    //there was an error creating user
                    self.showError("Error Creating User")
                }
                else{
                    //user created, store first name and last name
                    let db = Firestore.firestore()
                    db.collection("Users").addDocument(data:["first_name": firstName, "last_name": lastName, "email": email, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil{
                            self.showError("User Data Could not be saved")
                        }
                    }
                    //transition to homescreen
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
