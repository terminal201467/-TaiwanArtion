//
//  ExhibitionMapView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/21.
//

import Foundation
import MapKit
import RxCocoa
import RxSwift

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

class ExhibitionMapView: UIView {
    
    private let viewModel = NearViewModel.shared
    
    let locationInterface = LocationInterface.shared
    
    private let disposeBag = DisposeBag()
    
    var locatedNearSignal: Signal<Void> = Signal.just(())
    
    var locatedCurrentMyLocationSignal: Signal<Void> = Signal.just(())
    
    private let locateRecentExhibitionButton: UIButton = {
        let button = UIButton()
        button.setTitle("離我最近的展覽館", for: .normal)
        button.backgroundColor = .brownColor
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.roundCorners(cornerRadius: 12)
        return button
    }()
    
    let mapView: MKMapView = {
       let view = MKMapView()
        view.preferredConfiguration.elevationStyle = .flat
        view.showsUserLocation = true
        view.register(MapAnnocationView.self, forAnnotationViewWithReuseIdentifier: MapAnnocationView.reuseIdentifier)
        return view
    }()
    
    private let locationButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "locationButton"), for: .normal)
        return button
    }()
    
    //CollectionView
    let locationContentCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(LocationContentCollectionViewCell.self, forCellWithReuseIdentifier: LocationContentCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setMapView()
        setLocationContentCollectionView()
        autoLayout()
        setContentStackIsHidden()
        setButtonSubscribtion()
        setMapFeature()
        viewModel.output.outputExhibitionHall
            .asObservable()
            .subscribe(onNext: { info in
                self.locationContentCollectionView.reloadData()
                self.setContentStackIsHidden()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLocationContentCollectionView() {
        locationContentCollectionView.delegate = self
        locationContentCollectionView.dataSource = self
    }
    
    private func setMapView() {
        mapView.delegate = self
    }
    
    func showCurrentLocation(by latitudinalMeters: Double, by longitudinalMeters: Double) {
        locationInterface.checkLocationAuthorization()
        let locationCoordinate = locationInterface.getCurrentLocation().coordinate
        let region = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
        mapView.setRegion(region, animated: true)
    }
    
    private func autoLayout() {
        addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mapView.addSubview(locateRecentExhibitionButton)
        locateRecentExhibitionButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
        }
        
        mapView.addSubview(locationContentCollectionView)
        locationContentCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(150.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        mapView.addSubview(locationButton)
        locationButton.snp.makeConstraints { make in
            make.height.equalTo(36.0)
            make.width.equalTo(36.0)
        }
    }
    
    private func locationButtonAutoLayoutWithContent() {
        locationContentCollectionView.isHidden = false
        locationButton.snp.makeConstraints { make in
            make.bottom.equalTo(locationContentCollectionView.snp.top).offset(-24)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func locationButtonAutoLayoutWithoutContent() {
        locationContentCollectionView.isHidden = true
        locationButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func setContentStackIsHidden() {
        viewModel.output.outputExhibitionHall.value.isEmpty ? self.locationButtonAutoLayoutWithoutContent() : self.locationButtonAutoLayoutWithContent()
    }
    
    private func setButtonSubscribtion() {
        locatedNearSignal = locateRecentExhibitionButton.rx.tap
            .asSignal(onErrorJustReturn: ())
        
        locatedCurrentMyLocationSignal = locationButton.rx.tap
            .asSignal(onErrorJustReturn: ())
    }
    
    private func setMapFeature() {
        //顯示現在位置＋周邊展覽館
        locatedNearSignal.emit(onNext: {
            self.showCurrentLocation(by: 5000, by: 5000)
            //這邊還要另外顯示附近的展覽館
            self.locationInterface.searchTheLocations(searchKeyword: "博物館") { mapItems in
                for item in mapItems {
                    let mapAnnotation = MapLocationPinAnnotation(coordinate: item.placemark.coordinate)
                    self.mapView.addAnnotation(mapAnnotation)
                }
                self.viewModel.input.inputNearExhibitionHall.accept(mapItems)
            }
            
            self.locationInterface.searchTheLocations(searchKeyword: "展覽館") { mapItems in
                for item in mapItems {
                    let mapAnnotation = MapLocationPinAnnotation(coordinate: item.placemark.coordinate)
                    self.mapView.addAnnotation(mapAnnotation)
                }
                self.viewModel.input.inputNearExhibitionHall.accept(mapItems)
            }
            
            self.locationInterface.searchTheLocations(searchKeyword: "藝文中心") { mapItems in
                for item in mapItems {
                    let mapAnnotation = MapLocationPinAnnotation(coordinate: item.placemark.coordinate)
                    self.mapView.addAnnotation(mapAnnotation)
                }
                self.viewModel.input.inputNearExhibitionHall.accept(mapItems)
            }
            self.setContentStackIsHidden()
        })
        .disposed(by: disposeBag)
        
        //顯示現在位置
        locatedCurrentMyLocationSignal.emit(onNext: {
            self.showCurrentLocation(by: 1000, by: 1000)
            self.mapView.annotations.map { annotation in
                self.mapView.removeAnnotation(annotation)
            }
            self.setContentStackIsHidden()
        })
        .disposed(by: disposeBag)
        
        self.locationInterface.mapUpdateCenter = { centerRegion in
            print("centerRegion:\((centerRegion))")
            self.mapView.setRegion(centerRegion, animated: true)
        }
    }
}

//MARK: -NearViewCollectionViewDelegate
extension ExhibitionMapView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.outputExhibitionHall.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationContentCollectionViewCell.reuseIdentifier, for: indexPath) as! LocationContentCollectionViewCell
        cell.configure(hallInfo: viewModel.output.outputExhibitionHall.value[indexPath.row])
        cell.lookUpLocationSignal.emit(onNext: {
            //查看位置
            //HightLight定位
        })
        .disposed(by: disposeBag)
        cell.lookUpExhibitionHallSignal.emit(onNext: {
            //推到展覽館頁面
        })
        .disposed(by: disposeBag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //HighLight定位
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width * (2 / 3)
        let cellHeight = 93.0 - (30 * 2)
        return .init(width: cellWidth, height: cellHeight)
    }
}

//MARK: -MapViewCollectionViewDelegate

extension ExhibitionMapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let mapAnnotation = annotation as? MapLocationPinAnnotation else { return .none}
        let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: MapAnnocationView.reuseIdentifier, for: annotation) as! MapAnnocationView
        viewModel.output.outputSelectedAnnotation.subscribe(onNext: { selectedAnnotation in
            dequeuedView.configureMarkBackground(isSelected: selectedAnnotation.coordinate == annotation.coordinate)
        })
        .disposed(by: disposeBag)
        if let index = viewModel.output.outputMapItem.value.firstIndex(where: {$0.placemark.location?.coordinate == annotation.coordinate}) {
            dequeuedView.configure(number: index + 1)
            dequeuedView.configureMarkBackground(isSelected: false)
        }
        return dequeuedView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        viewModel.input.inputSelectedAnnotation.accept(view.annotation!)
        mapView.setCenter(view.annotation?.coordinate ?? mapView.userLocation.coordinate, animated: true)
        //點按之後show出
    }
}
