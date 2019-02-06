//
//  LoginViewController.swift
//  ProjektGrupowy
//
//  Created by Artur Sulinski on 02/12/2018.
//  Copyright © 2018 Artur Sulinski. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservables()
        // Do any additional setup after loading the view.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


    @IBOutlet weak var invalidLogin: UILabel! {
        didSet {
            invalidLogin.isHidden = true
        }
    }
    @IBOutlet weak var invalidPassword: UILabel! {
        didSet {
            invalidPassword.isHidden = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        title = "Projekt grupowy"
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController!.setNavigationBarHidden(false, animated: false)
    }

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoginViewController", bundle: Bundle.main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
        }
    }

    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton.layer.cornerRadius = 3
            signInButton.clipsToBounds = true
        }
    }

    @IBAction func didTapSignInButton(_ sender: Any) {
        if (checkLogin()) {
            invalidLogin.isHidden = true
            if (checkPassword()) {
                print(loginTextField.text!)
                print(passwordTextField.text!)
                let user = LoginUser(login: self.loginTextField.text!, password: self.passwordTextField.text!)
                self.viewModel.loginUser(user: user)
            } else {
                invalidPassword.isHidden = false
            }
        } else {
            invalidLogin.isHidden = false
            if (!checkPassword()) {
                invalidPassword.isHidden = false
            } else {
                invalidPassword.isHidden = true
            }
        }
    }

    func checkLogin() -> Bool {
        if ((loginTextField.text?.count)! > 1) {
            return true
        } else {
            return false
        }
        print(loginTextField.text)
        print(passwordTextField.text)
    }

    func checkPassword() -> Bool {
        if ((passwordTextField.text?.count)! > 1) {
            return true
        } else {
            return false
        }
    }

    private func setupObservables() {
        self.viewModel.responseObservable.skip(1).subscribe(onNext: {
            [weak self] error in
            if(error){
                self?.presentAlert(title: "Coś poszło nie tak", message: "Spróbuj jeszcze raz")
            }
        })
    }

    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        navigationController!.present(alert, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
