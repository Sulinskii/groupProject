//
//  RegisterOrLoginViewController.swift
//  ProjektGrupowy
//
//  Created by Artur Sulinski on 02/02/2019.
//  Copyright © 2019 Artur Sulinski. All rights reserved.
//

import UIKit

class RegisterOrLoginViewController: UIViewController {

    var loginButtonTapped: () -> () = {}
    var registerButtonTapped: () -> () = {}

    @IBOutlet weak var loginButton: UIButton!{
        didSet {
            loginButton.layer.cornerRadius = 3
            loginButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var registerButton: UIButton!{
        didSet {
            registerButton.layer.cornerRadius = 3
            registerButton.clipsToBounds = true
        }
    }

    init(){
        super.init(nibName: "RegisterOrLoginViewController", bundle: Bundle.main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "Projekt grupowy"
    }

    @objc func didTapLoginButton(){
        loginButtonTapped()
    }

    @objc func didTapRegisterButton(){
        registerButtonTapped()
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
