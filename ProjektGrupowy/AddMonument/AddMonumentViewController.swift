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
    private var coordinates: Coordinate!
    private var manage: Int!
    private var monument: Monument!
    @IBOutlet weak var nazwaTextField: UITextField!
    @IBOutlet weak var funkcjaTextField: UITextField!
    @IBOutlet weak var ulicaTextField: UITextField!
    @IBOutlet weak var nrBudynkuTextField: UITextField!
    @IBOutlet weak var nrMieszkaniaTextField: UITextField!
    @IBOutlet weak var kodPocztowyTextField: UITextField!
    @IBOutlet weak var miastoTextField: UITextField!
    @IBOutlet weak var krajTextField: UITextField!
    @IBOutlet weak var dataPowstaniaTextField: UITextField!
    @IBOutlet weak var zrodlaTextField: UITextField!
    @IBOutlet weak var rodzajObiektuTextField: UITextField!
    @IBOutlet weak var statusPrawnyTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!


    init(viewModel: AddMonumentViewModel, coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), manage: Int) {
        self.viewModel = viewModel
        self.manage = manage
        self.coordinates = Coordinate(latitude: coordinates.latitude, longitude: coordinates.longitude)
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Zamknij", style: .plain, target: self, action: #selector(didTapCloseButton))
        title = "Projekt grupowy"
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        setupMonumentsObservables()
        setupManageObservables()
        if(manage == 0 || manage == 2){
            monument = viewModel.getMonument()
            nazwaTextField.isEnabled = false
            nazwaTextField.placeholder = ""
            funkcjaTextField.isEnabled = false
            funkcjaTextField.placeholder = ""
            ulicaTextField.isEnabled = false
            ulicaTextField.placeholder = ""
            nrBudynkuTextField.isEnabled = false
            nrBudynkuTextField.placeholder = ""
            nrMieszkaniaTextField.isEnabled = false
            nrMieszkaniaTextField.placeholder = ""
            kodPocztowyTextField.isEnabled = false
            kodPocztowyTextField.placeholder = ""
            miastoTextField.isEnabled = false
            miastoTextField.placeholder = ""
            krajTextField.isEnabled = false
            krajTextField.placeholder = ""
            dataPowstaniaTextField.isEnabled = false
            dataPowstaniaTextField.placeholder = ""
            zrodlaTextField.isEnabled = false
            zrodlaTextField.placeholder = ""
            rodzajObiektuTextField.isEnabled = false
            rodzajObiektuTextField.placeholder = ""
            statusPrawnyTextField.isEnabled = false
            statusPrawnyTextField.placeholder = ""
            nazwaTextField.text = monument.name
            funkcjaTextField.text = monument.function
            ulicaTextField.text = monument.address.street
            nrBudynkuTextField.text = monument.address.houseNumber
            nrMieszkaniaTextField.text = monument.address.flatNumber
            kodPocztowyTextField.text = monument.address.postCode
            miastoTextField.text = monument.address.city
            krajTextField.text = monument.address.country
            dataPowstaniaTextField.text = monument.creationDate
            zrodlaTextField.text = monument.archivalSource
            rodzajObiektuTextField.text = " "
            statusPrawnyTextField.text = " "
            if(manage == 0) {
                addButton.setTitle("Zaakceptuj", for: .normal)
            } else {
                addButton.isHidden = true
            }
        }

        // Do any additional setup after loading the view.
    }

    @objc func didTapAddButton() {
        if(manage == 0){
            viewModel.setMonumentActive(id: monument.id)
        } else if (manage == 1) {
            let address = Address(city: miastoTextField.text!, country: krajTextField.text!, flatNumber: nrMieszkaniaTextField.text!,
                    houseNumber: nrBudynkuTextField.text!, postCode: kodPocztowyTextField.text!, street: ulicaTextField.text!)
            let monument = AddMonument(name: nazwaTextField.text!, function: funkcjaTextField.text!,
                    creationDone: dataPowstaniaTextField.text!, archivalSource: zrodlaTextField.text!,
                    coordinates: coordinates, address: address, status: statusPrawnyTextField.text!, type: rodzajObiektuTextField.text!)
            viewModel.addMonument(monument: monument)
        }
    }

    @objc func didTapCloseButton() {
        self.dismiss(animated: true)
    }

    private func setupMonumentsObservables() {
        self.viewModel.responseObservable.skip(1).subscribe(onNext: {
            [weak self] error in
            if(!error) {
                self?.presentAlert(title: "Gratulacje!", message: "Pomyślnie dodałeś obiekt!", onOK: {
                    self?.dismiss(animated: true)
                })
            } else {
                self?.presentAlert(title: "Coś poszło nie tak", message: "Spróbuj ponownie później", onOK: {
                  print("error")
                })
            }
        })
    }

    private func setupManageObservables() {
        self.viewModel.responseManageObservable.skip(1).subscribe(onNext: {
            [weak self] error in
            if(!error) {
                self?.presentAlert(title: "Gratulacje!", message: "Zaakceptowałeś obiekt!", onOK: {
                    self?.dismiss(animated: true)
                })
            } else {
                self?.presentAlert(title: "Coś poszło nie tak", message: "Spróbuj ponownie później", onOK: {
                    print("error")
                })
            }
        })
    }

    func presentAlert(title: String, message: String, onOK: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            onOK()
        }
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
