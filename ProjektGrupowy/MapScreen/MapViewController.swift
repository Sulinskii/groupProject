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
    private var allMarkers: [PlaceMarker] = []
    private var monuments: [Monument] = []
    private var nv: UINavigationController!
    private var manageNavigationController: UINavigationController!
    private var addButtonIsTapped: Bool = false
    private var manageButtonIsTapped: Bool = false
    private var addMonumentViewController: AddMonumentViewController!
    private var addMonumentViewModel: AddMonumentViewModel!
    private var manageMonumentsViewController: AddMonumentViewController!
    private var manageMonumentsViewModel: AddMonumentViewModel!
    @IBOutlet weak var addButtonWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        print("view did load")
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
//        self.setNeedsStatusBarAppearanceUpdate()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Wyloguj", style: .plain, target: self, action: #selector(didTapLogoutButton))
        setupMonumentsObservables()
        self.addMap(location: self.location)
        if(!(UserRepository.shared.readUser()?.superUser)!){
            addButtonWidth.constant = self.view.frame.width/2
            manageButton.isHidden = true
        }
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        manageButton.addTarget(self, action: #selector(didTapManageButton), for: .touchUpInside)
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
        print("view will appear")
        viewModel.loadMonuments()
        print("IS MANAGE BUTTON TAPPED: \(self.manageButtonIsTapped) first")
//        self.navigationController?.navigationBar.backgroundColor = .red
//        navigationController?.navigationBar.backgroundColor = .red
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        addButton.backgroundColor = .white
        addButton.isEnabled = true
        addButton.alpha = 1
        if((UserRepository.shared.readUser()?.superUser)!) {
            manageButton.backgroundColor = .white
            manageButton.isEnabled = true
            manageButton.alpha = 1
        }
        title = "Projekt grupowy"
        
    }

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        super.init(nibName: "MapViewController", bundle: Bundle.main)
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        location = locationManager.location!
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
//        addButton.layer.zPosition = 1
//        manageButton.layer.zPosition = 1
//        view.layoutIfNeeded()
    }

    private func setupMonumentsObservables(){
        self.viewModel.monumentsObservable.skip(1).subscribe(onNext: {
            [unowned self] monument in
            self.monuments = monument
            self.mapView.clear()
            print("IS MANAGE BUTTON TAPPED: \(self.manageButtonIsTapped) second")
            if(!self.manageButtonIsTapped) {
                for index in 0...self.monuments.count - 1 {
                    if (self.monuments[index].approved) {
                        let marker = PlaceMarker(monument: self.monuments[index])
                        self.allMarkers.append(marker)
                        marker.map = self.mapView
                    }
                }
            } else {
                for index in 0...self.monuments.count - 1 {
                    if (!self.monuments[index].approved) {
                        let marker = PlaceMarker(monument: self.monuments[index])
                        self.allMarkers.append(marker)
                        marker.map = self.mapView
                    }
                }
            }
        }).disposed(by: disposeBag)
    }

    @objc func didTapAddButton() {
        if((UserRepository.shared.readUser()?.superUser)!) {
            if (!addButtonIsTapped) {
                addButtonIsTapped = true
                manageButtonIsTapped = false
                manageButton.isEnabled = false
                UIView.animate(withDuration: 0.5){
                    self.addButton.backgroundColor = .red
                    self.manageButton.alpha = 0.3
                }
                for index in 0...self.monuments.count - 1 {
                    if (self.monuments[index].approved) {
                        let marker = PlaceMarker(monument: self.monuments[index])
                        self.allMarkers.append(marker)
                        marker.icon = GMSMarker.markerImage(with: UIColor.red)
                        marker.map = self.mapView
                    }
                }

            } else {
                addButtonIsTapped = false
                manageButton.isEnabled = true
                UIView.animate(withDuration: 0.5){
                    self.addButton.backgroundColor = .white
                    self.manageButton.alpha = 1
                }
            }
        } else {
            if (!addButtonIsTapped) {
                addButtonIsTapped = true
                UIView.animate(withDuration: 0.5){
                    self.addButton.backgroundColor = .red
                }
            } else {
                addButtonIsTapped = false
                UIView.animate(withDuration: 0.5){
                    self.addButton.backgroundColor = .white
                }
            }
        }

    }

    @objc func didTapManageButton() {
        mapView.clear()
//        monuments.removeAll()
        if(!manageButtonIsTapped) {
            manageButtonIsTapped = true
            addButtonIsTapped = false
            addButton.isEnabled = false
            print("IS MANAGE BUTTON TAPPED: \(self.manageButtonIsTapped) third")
            UIView.animate(withDuration: 0.5){
                self.manageButton.backgroundColor = .red
                self.addButton.alpha = 0.3
            }
            for index in 0...self.monuments.count - 1 {
                if (!self.monuments[index].approved) {
                    let marker = PlaceMarker(monument: self.monuments[index])
                    self.allMarkers.append(marker)
                    marker.icon = GMSMarker.markerImage(with: UIColor.orange)
                    marker.map = self.mapView
                }
            }
        } else {
            manageButtonIsTapped = false
            addButton.isEnabled = true
            print("IS MANAGE BUTTON TAPPED: \(self.manageButtonIsTapped) fourth")
            UIView.animate(withDuration: 0.5){
                self.manageButton.backgroundColor = .white
                self.addButton.alpha = 1
            }
            for index in 0...self.monuments.count - 1 {
                if (self.monuments[index].approved) {
                    let marker = PlaceMarker(monument: self.monuments[index])
                    self.allMarkers.append(marker)
                    marker.icon = GMSMarker.markerImage(with: UIColor.red)
                    marker.map = self.mapView
                }
            }
        }
//        self.present(manageNavigationController, animated: true)
    }

    public func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate)
        if (addButtonIsTapped && !manageButtonIsTapped) {
            addMonumentViewModel = AddMonumentViewModel()
            addMonumentViewController = AddMonumentViewController(viewModel: addMonumentViewModel, coordinates: coordinate, manage: 1)
            nv = UINavigationController(rootViewController: addMonumentViewController)
            self.present(nv, animated: true)
            addButtonIsTapped = false
        }
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let marker = marker as? PlaceMarker else {
            return true
        }
        if(manageButtonIsTapped) {
            presentManageMonumentScreen(monument: marker.monument)
        } else if(!manageButtonIsTapped && !addButtonIsTapped){
            presentMonumentInfoScreen(monument: marker.monument)
        }
        return true
    }

    private func presentManageMonumentScreen(monument: Monument){
        manageMonumentsViewModel = AddMonumentViewModel(monument: monument)
        manageMonumentsViewController = AddMonumentViewController(viewModel: manageMonumentsViewModel, manage: 0)
        manageNavigationController = UINavigationController(rootViewController: manageMonumentsViewController)
        self.present(manageNavigationController, animated: true)
        manageButtonIsTapped = false
    }

    private func presentMonumentInfoScreen(monument: Monument){
        let monumentInfoViewModel = AddMonumentViewModel(monument: monument)
        let monumentInfoViewController = AddMonumentViewController(viewModel: monumentInfoViewModel, manage: 2)
        let nv = UINavigationController(rootViewController: monumentInfoViewController)
        self.present(nv, animated: true)
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
