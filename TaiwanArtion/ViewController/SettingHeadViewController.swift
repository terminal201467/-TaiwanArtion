//
//  SettingHeadViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/6.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

enum PhotoKinds: Int, CaseIterable {
    case photos = 0, button
}

class SettingHeadViewController: UIViewController {
    
    private let settingHeadView = SettingHeadView()
    
    private let viewModel = SettingHeadViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        view = settingHeadView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setCollectionView()
    }
    
    private func setNavigationBar() {
        title = "設定大頭貼"
        let backButton = UIBarButtonItem(image: .init(named: "back"), style: .plain, target: self, action: #selector(back))
        navigationItem.backBarButtonItem = backButton
    }
    
    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setCollectionView() {
        settingHeadView.collectionView.delegate = self
        settingHeadView.collectionView.dataSource = self
    }
}

extension SettingHeadViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch PhotoKinds(rawValue: section) {
        case .photos: return viewModel.output.headImagesObservable.value.count
        case .button: return 1
        case .none: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadPhotoCollectionViewCell.reuseIdentifier, for: indexPath) as! HeadPhotoCollectionViewCell
//        cell.configure(imageString: <#T##String#>)
        return cell
    }
}
