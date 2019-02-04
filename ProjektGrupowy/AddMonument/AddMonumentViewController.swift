//
//  AddMonumentViewController.swift
//  ProjektGrupowy
//
//  Created by Artur Sulinski on 03/02/2019.
//  Copyright © 2019 Artur Sulinski. All rights reserved.
//

import UIKit
import CoreLocation

class AddMonumentViewController: UIViewController {

    private var viewModel: AddMonumentViewModel!

    init(viewModel: AddMonumentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AddMonumentViewController", bundle: Bundle.main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(didTapCloseButton))
        title = "Projekt grupowy"
        // Do any additional setup after loading the view.
    }

    @objc func didTapCloseButton(){
        self.dismiss(animated: true)
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
