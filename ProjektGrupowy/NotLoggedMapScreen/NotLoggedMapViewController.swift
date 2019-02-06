//
//  NotLoggedMapViewController.swift
//  ProjektGrupowy
//
//  Created by Artur Sulinski on 02/02/2019.
//  Copyright © 2019 Artur Sulinski. All rights reserved.
//

import UIKit
import GoogleMaps
import RxSwift

class NotLoggedMapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager!
    private var location: CLLocation!
    private var mapView: GMSMapView!
    private var viewModel: NotLoggedMapViewModel!
    private var allMarkers: [PlaceMarker] = []
    private var monuments: [Monument] = []
    private let disposeBag = DisposeBag()

    init(viewModel: NotLoggedMapViewModel){
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        self.viewModel = viewModel
        super.init(nibName: "NotLoggedMapViewController", bundle: Bundle.main)
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        location = locationManager.location!
        let rightBarImage = UIImageView(imageIdentifier: .loginHead)
        self.setNeedsStatusBarAppearanceUpdate()
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightBarImage.image, style: .plain,
                target: self, action: #selector(didTapRightBarButtonItem))
        setupMonumentsObservables()
    }

    @objc func didTapRightBarButtonItem(){
        viewModel.onLoginSelected()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "Projekt grupowy"
    }

    private func addMap(location: CLLocation) {
        let startLocation: CLLocationCoordinate2D!
        let camera: GMSCameraPosition!
        var bounds = GMSCoordinateBounds()
        let mapFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        startLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        camera = GMSCameraPosition.camera(withTarget: startLocation, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: mapFrame, camera: camera)
        bounds = bounds.includingCoordinate(startLocation)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        for index in 0...monuments.count - 1 {
            if(monuments[index].approved) {
                let marker = PlaceMarker(monument: monuments[index])
                allMarkers.append(marker)
                marker.map = self.mapView
            }
        }
//        self.allMarkers = monuments.map {
//            print(marker)
//            return marker
//        }
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        view.addSubview(mapView)
    }

    private func setupMonumentsObservables(){
        self.viewModel.monumentsObservable.skip(1).subscribe(onNext: {
            [unowned self] monument in
            self.monuments = monument
            self.addMap(location: self.location)
        }).disposed(by: disposeBag)
    }

    public func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){

        print(coordinate)
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let marker = marker as? PlaceMarker else {
            return true
        }
        presentMonumentInfoScreen(monument: marker.monument)
        return true
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
