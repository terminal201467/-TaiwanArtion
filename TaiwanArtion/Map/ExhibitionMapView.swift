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
    
    //右下角定位鈕
    private let headerContainerView: UIView = {
        let view = UIView()
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
        return collectionView
    }()
    
    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerContainerView, locationContentCollectionView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 24
        return stackView
    }()
    
    private let contentContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setMapView()
        setLocationContentCollectionView()
        autoLayout()
        autoLayoutContainerContent()
        setContentStackIsHidden()
        setButtonSubscribtion()
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
    
    func AnnotationLocationWith(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        let annotation = MapLocationPinAnnotation(coordinate: location.coordinate)
        mapView.addAnnotation(annotation)
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
        
        mapView.addSubview(contentContainerView)
        contentContainerView.snp.makeConstraints { make in
            make.height.equalTo(150.0)
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-16.0)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
    
    private func autoLayoutContainerContent() {
        contentContainerView.addSubview(contentStack)
        contentStack.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        headerContainerView.snp.makeConstraints { make in
            make.height.equalTo(40.0)
        }
        
        headerContainerView.addSubview(locationButton)
        locationButton.snp.makeConstraints { make in
            make.height.equalTo(36.0)
            make.width.equalTo(36.0)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func setContentStackIsHidden() {
        locationContentCollectionView.isHidden = viewModel.output.outputExhibitionHall.value.isEmpty ? true : false
    }
    
    private func setButtonSubscribtion() {
        locatedNearSignal = locateRecentExhibitionButton.rx.tap
            .asSignal(onErrorJustReturn: ())
        
        locatedCurrentMyLocationSignal = locationButton.rx.tap
            .asSignal(onErrorJustReturn: ())
    }
}

//MARK: -NearViewCollectionViewDelegate
extension ExhibitionMapView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.output.outputExhibitionHall.value.count
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
        return .init(top: 30, left: 24, bottom: 30, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width * (257.0 / mapView.frame.width)
        let cellHeight = collectionView.frame.height * (93.0 / mapView.frame.height)
        return .init(width: cellWidth, height: cellHeight)
    }
}

//MARK: -MapViewCollectionViewDelegate

extension ExhibitionMapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MapLocationPinAnnotation else { return nil }
        let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: MapAnnocationView.reuseIdentifier, for: annotation) as! MapAnnocationView
        dequeuedView.image = UIImage(named: "locationPin")
        if let index = viewModel.output.outputMapItem.value.firstIndex(where: {$0.placemark.location?.coordinate == annotation.coordinate}) {
            dequeuedView.configure(number: index + 1)
        }
        return dequeuedView

    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("selected:\(mapView.selectedAnnotations)")
        if let annotation = view.annotation as? MapLocationPinAnnotation {
            let identifier = MapLocationPinAnnotation.reuseIdentifier
            var annotationView: MKAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                annotationView = dequeuedView
            } else {
                let mapAnnotationView = MapAnnocationView(annotation: annotation, reuseIdentifier: identifier)
                mapAnnotationView.image = UIImage(named: "locationSelectedPin")
                mapAnnotationView.configure(number: 1)
                annotationView = mapAnnotationView
            }
        }
    }

}
