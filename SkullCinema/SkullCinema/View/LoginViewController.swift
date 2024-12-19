//
//  LoginViewController.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 14/12/2024.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        txtPassword.isSecureTextEntry = true
    }
    
    //funciones
    //función para navegar al HomeViewController
    func goToPush() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "BienvenidaViewController") as? BienvenidaViewController
         viewcontroller?.modalPresentationStyle = .overFullScreen
        self.present (viewcontroller ?? ViewController(), animated: true, completion: nil)
    }
    
    //función para crear una alerta
    func configureAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    //función para ver si estamos logueados o no
    func getUser() {
        let _ = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                print("Usuario autenticado: \(user.email ?? "Sin correo")")
                self.goToPush()
            } else {
                print("No hay usuario autenticado")
            }
        }
    }
    
        //función de login en firebase
        func loginWithFirebase(email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in guard let self = self else { return }
            //si es que hay un error
            if error != nil {
                self.configureAlert(title: "Error de inicio de sesión", message: "Email o contraseña incorrectos. Por favor, verifica tus datos.")
            } else{
                self.goToPush()
            }
        }
    }
    
    //función para el registro de usuario en firebase
    func registerWithFirebase(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if error != nil {
                self.configureAlert(title: "Error de registro", message: "No se pudo registrar el usuario. Por favor, verifica los datos ingresados.")
            } else {
                self.goToPush ()
            }
        }
    }
    
    func validateFields() -> String? {
        // Verifica que los campos no estén vacíos
        guard let email = txtCorreo.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else {
            return "Por favor, ingresa un correo válido."
        }
        
        guard let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), !password.isEmpty else {
            return "Por favor, ingresa una contraseña."
        }
        
        // Valida que la contraseña tenga al menos 5 caracteres
        if password.count < 6 {
            return "La contraseña debe tener al menos 7 caracteres."
        }
        
        // Valida que el email tenga formato válido
        if !isValidEmail(email) {
            return "Por favor, ingresa un correo válido."
        }
        
        return nil // Todo está válido
    }

    // Valida el formato del correo
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    
    //función de login
    func loginUser() {
        view.endEditing(true) // Cierra el teclado activo
        let email = txtCorreo.text ?? ""
        let password = txtPassword.text ?? ""
        loginWithFirebase (email: email, password: password)
    }
    
    //función de registro
    func registerUser() {
        view.endEditing(true) // Cierra el teclado activo
        
        // Valida los campos
        if let errorMessage = validateFields() {
            configureAlert(title: "Error", message: errorMessage)
            return
        }
        
        // Si las validaciones pasan, procede con el registro
        let email = txtCorreo.text ?? ""
        let password = txtPassword.text ?? ""
        registerWithFirebase(email: email, password: password)
    }
    
    @IBAction func didTapRegister(_ sender: UIButton) {
        registerUser()
    }
    
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        loginUser()
    }
    
    
}
