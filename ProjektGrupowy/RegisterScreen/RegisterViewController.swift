//
//  RegisterViewController.swift
//  ProjektGrupowy
//
//  Created by Artur Sulinski on 02/02/2019.
//  Copyright © 2019 Artur Sulinski. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    var registerButtonTapped: () -> () = {}
    var viewModel: RegisterViewModel!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!{
        didSet {
            registerButton.layer.cornerRadius = 3
            registerButton.clipsToBounds = true
        }
    }

    init(viewModel: RegisterViewModel){
        self.viewModel = viewModel
        super.init(nibName: "RegisterViewController", bundle: Bundle.main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        setupObservables()
        // Do any additional setup after loading the view.
    }

    @objc func didTapRegisterButton(){
        let user = RegisterUser(login: self.loginTextField.text!, password: self.passwordTextField.text!,
                name: self.nameTextField.text!, surname: self.surnameTextField.text!)
        self.viewModel.registerUser(user: user)
    }

    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        navigationController!.present(alert, animated: true)
    }

    private func setupObservables() {
        self.viewModel.responseObservable.skip(1).subscribe(onNext: {
            [weak self] error in
            if(error){
                self?.presentAlert(title: "Coś poszło nie tak", message: "Spróbuj jeszcze raz")
            }
        })
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
