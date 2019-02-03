//
//  ManageMonumentsViewController.swift
//  ProjektGrupowy
//
//  Created by Artur Sulinski on 03/02/2019.
//  Copyright © 2019 Artur Sulinski. All rights reserved.
//

import UIKit

class ManageMonumentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var monuments: [Monument]!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noMonumentsLabel: UILabel!
    init(monuments: [Monument]){
        super.init(nibName: "ManageMonumentsViewController", bundle: Bundle.main)
        self.monuments = monuments
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
        if(monuments.count == 0){
            tableView.isHidden = true
        } else {
            noMonumentsLabel.isHidden = true
        }
        title = "Projekt grupowy"
        // Do any additional setup after loading the view.
    }

    @objc func didTapCloseButton(){
        self.dismiss(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monuments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row at")
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
