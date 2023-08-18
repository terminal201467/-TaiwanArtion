//
//  NearViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/12.
//

import UIKit
import RxSwift

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
        setLocationContentCollectionView()
    }
    
    private func setNavigationBar() {
        navigationItem.titleView = searchViewController.searchBar
    }
    
    private func setLocationContentCollectionView() {
        nearView.locationContentCollectionView.delegate = self
        nearView.locationContentCollectionView.dataSource = self
    }
    
    private func setNearView() {
        nearView.filterSubject.subscribe(onNext: {
            self.present(self.popUpViewController, animated: true)
        })
        .disposed(by: disposeBag)
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

//MARK: -NearView
extension NearViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
        let cellWidth = collectionView.frame.width * (257.0 / nearView.mapView.frame.width)
        let cellHeight = collectionView.frame.height * (93.0 / nearView.mapView.frame.height)
        return .init(width: cellWidth, height: cellHeight)
    }
}
