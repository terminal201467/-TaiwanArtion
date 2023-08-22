//
//  NearViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/12.
//

import UIKit
import RxSwift
import MapKit

class NearViewController: UIViewController {
    
    private let disposeBag = DisposeBag()

    private let nearView = NearView()
    
    private let viewModel = NearViewModel.shared
    
    private let resultViewController = NearSearchResultViewController()
    
    private lazy var searchResultViewController = UINavigationController(rootViewController: self.resultViewController)
    
    private lazy var searchViewController: UISearchController = {
       let searchViewController = UISearchController(searchResultsController: searchResultViewController)
        searchViewController.searchBar.searchTextField.roundCorners(cornerRadius: 20)
        searchViewController.searchBar.searchTextField.placeholder = "搜尋附近展覽館"
        searchViewController.showsSearchResultsController = true
        return searchViewController
    }()
    
    private let bottomUpView = BottomUpPopUpView(frame: .zero, type: .filter)
    
    private lazy var popUpViewController: PopUpViewController = {
        let popUpViewController = PopUpViewController(popUpView: bottomUpView)
        popUpViewController.modalPresentationStyle = .overFullScreen
        popUpViewController.modalTransitionStyle = .coverVertical
        bottomUpView.dismissFromController = {
            popUpViewController.dismiss(animated: true)
            self.nearView.filterButtonIsSelected.toggle()
        }
        return popUpViewController
    }()
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = nearView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setNearView()
        setMapFeature()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.nearView.exhibitionMapView.locationInterface.checkLocationAuthorization()
    }
    
    private func setNavigationBar() {
        navigationItem.titleView = searchViewController.searchBar
    }
    
    private func setNearView() {
        nearView.filterSubject.subscribe(onNext: {
            self.present(self.popUpViewController, animated: true)
        })
        .disposed(by: disposeBag)
    }
    
    private func showCurrentLocation() {
        self.nearView.exhibitionMapView.locationInterface.checkLocationAuthorization()
        let locationCoordinate = self.nearView.exhibitionMapView.locationInterface.getCurrentLocation().coordinate
        let region = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.nearView.exhibitionMapView.mapView.setRegion(region, animated: true)
    }
    
    private func setMapFeature() {
        //顯示現在位置＋周邊展覽館
        nearView.exhibitionMapView.locatedNearSignal.emit(onNext: {
            self.showCurrentLocation()
            //這邊還要另外顯示4個展覽館
        })
        .disposed(by: disposeBag)
        
        //顯示現在位置
        nearView.exhibitionMapView.locatedCurrentMyLocationSignal.emit(onNext: {
            self.showCurrentLocation()
        })
        .disposed(by: disposeBag)
        
        self.nearView.exhibitionMapView.locationInterface.mapUpdateCenter = { centerRegion in
            print("centerRegion:\((centerRegion))")
            self.nearView.exhibitionMapView.mapView.setRegion(centerRegion, animated: true)
        }
    }
}

extension NearViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("searchTextField:\(textField.text)")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("textField:\(textField.text)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //紀錄到UserDefault裡面
        return true
    }
}


