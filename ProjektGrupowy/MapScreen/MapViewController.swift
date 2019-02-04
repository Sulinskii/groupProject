//
//  MapViewController.swift
//  ProjektGrupowy
//
//  Created by Artur Sulinski on 03/12/2018.
//  Copyright © 2018 Artur Sulinski. All rights reserved.
//

import UIKit
import GoogleMaps
import RxSwift

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager!
    private let disposeBag = DisposeBag()
    private var mapView: GMSMapView!
    private let viewModel: MapViewModel!
    private var location = CLLocation()
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var manageButton: UIButton!
    private var nv: UINavigationController!
    private var manageNavigationController: UINavigationController!
    private var addButtonIsTapped: Bool = false
    private var addMonumentViewController: AddMonumentViewController!
    private var addMonumentViewModel: AddMonumentViewModel!
    private var manageMonumentsViewController: ManageMonumentsViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
//        self.setNeedsStatusBarAppearanceUpdate()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogoutButton))
        // Do any additional setup after loading the view.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @objc func didTapLogoutButton() {
        mapView.removeFromSuperview()
        viewModel.onLogoutTapped()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        self.navigationController?.navigationBar.backgroundColor = .red
//        navigationController?.navigationBar.backgroundColor = .red
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "Projekt grupowy"
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        manageButton.addTarget(self, action: #selector(didTapManageButton), for: .touchUpInside)
        let monuments: [Monument] = []
        manageMonumentsViewController = ManageMonumentsViewController(monuments: monuments)
        manageNavigationController = UINavigationController(rootViewController: manageMonumentsViewController)
    }

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        super.init(nibName: "MapViewController", bundle: Bundle.main)
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        location = locationManager.location!
        addMap(location: location)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addMap(location: CLLocation) {
        let startLocation: CLLocationCoordinate2D!
        let camera: GMSCameraPosition!
        var bounds = GMSCoordinateBounds()
        let mapFrame = CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 40)
        startLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        camera = GMSCameraPosition.camera(withTarget: startLocation, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: mapFrame, camera: camera)
        bounds = bounds.includingCoordinate(startLocation)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        edgesForExtendedLayout = []
        view.addSubview(mapView)
    }

    @objc func didTapAddButton() {
        addButtonIsTapped = true
    }

    @objc func didTapManageButton() {
        self.present(manageNavigationController, animated: true)
    }

    public func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate)
        if (addButtonIsTapped) {
            addMonumentViewModel = AddMonumentViewModel(coordinates: coordinate)
            addMonumentViewController = AddMonumentViewController(viewModel: addMonumentViewModel)
            nv = UINavigationController(rootViewController: addMonumentViewController)
            self.present(nv, animated: true)
        }
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
