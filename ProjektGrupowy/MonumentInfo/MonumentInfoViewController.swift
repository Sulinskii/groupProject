//
//  MonumentInfoViewController.swift
//  ProjektGrupowy
//
//  Created by Artur Sulinski on 03/02/2019.
//  Copyright © 2019 Artur Sulinski. All rights reserved.
//

import UIKit

class MonumentInfoViewController: UIViewController {

    private var monument: Monument!

    @IBOutlet weak var nameInfoLabel: UILabel!
    @IBOutlet weak var streetInfoLabel: UILabel!
    @IBOutlet weak var cityInfoLabel: UILabel!
    @IBOutlet weak var countryInfoLabel: UILabel!
    @IBOutlet weak var addedInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Zamknij", style: .plain, target: self, action: #selector(didTapCloseButton))
        title = "Projekt grupowy"
        displayDetails()
        // Do any additional setup after loading the view.
    }

    init(monument: Monument){
        self.monument = monument
        super.init(nibName: "MonumentInfoViewController", bundle: Bundle.main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didTapCloseButton(){
        self.dismiss(animated: true)
    }

    private func displayDetails(){
        nameInfoLabel.text = monument.name
        streetInfoLabel.text = " \(String(monument.address.street)) \(String(monument.address.houseNumber))"
        cityInfoLabel.text = monument.address.city
        countryInfoLabel.text = monument.address.country
        addedInfoLabel.text = monument.creationDate
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
