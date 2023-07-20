//
//  ChooseHabbyViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/18.
//

import UIKit
import RxSwift

enum ChooseHabbySections: Int, CaseIterable {
    case hint = 0, habbys, button
}

class ChooseHabbyViewController: UIViewController {
    
    private let chooseHabbyView = ChooseHabbyView()
    
    private let viewModel = ChooseHabbyViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        view = chooseHabbyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setCollectionView()
    }
    
    private func setNavigationBar() {
        title = "設定大頭貼"
        let leftButton = UIBarButtonItem(image: .init(named: "back")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }

    private func setCollectionView() {
        chooseHabbyView.collectionView.delegate = self
        chooseHabbyView.collectionView.dataSource = self
    }
}

extension ChooseHabbyViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ChooseHabbySections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch ChooseHabbySections(rawValue: section) {
        case .hint: return 1
        case .habbys: return HabbyItem.allCases.count
        case .button: return 1
        case .none: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch ChooseHabbySections(rawValue: indexPath.section) {
        case .hint:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HintCollectionViewCell.reuseIdentifier, for: indexPath) as! HintCollectionViewCell
            cell.configure(hint: "請選擇1~3項你喜歡得展覽類別")
            return cell
        case .habbys:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabbyCollectionViewCell.reuseIdentifier, for: indexPath) as! HabbyCollectionViewCell
            let cellInfo = viewModel.cellForRowAt(indexPath: indexPath)
            cell.configureHabby(by: cellInfo.habby, isSelected: cellInfo.isSelected)
            return cell
        case .button:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.reuseIdentifier, for: indexPath) as! ButtonCollectionViewCell
            cell.configureRoundButton(isAllowToTap: viewModel.setIsAllowToTap(), buttonTitle: "儲存")
            cell.action = {
                
            }
            return cell
        case .none: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectedRowAt(indexPath: indexPath)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch ChooseHabbySections(rawValue: indexPath.section) {
        case .hint:
            let cellWidth = collectionView.frame.width
            let cellHeight = 50.0
            return .init(width: cellWidth, height: cellHeight)
        case .habbys:
            let cellWidth = (collectionView.frame.width - 16 * 5) / 4
            let cellHeight = 65.0
            return .init(width: cellWidth, height: cellWidth)
        case .button:
            let cellWidth = collectionView.frame.width - 16 * 2
            let cellHeight = 50.0
            return .init(width: cellWidth, height: cellHeight)
        case .none: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch ChooseHabbySections(rawValue: section) {
        case .hint: return .init(top: 16, left: 16, bottom: 16, right: 16)
        case .habbys: return .init(top: 16, left: 16, bottom: 16, right: 16)
        case .button: return .init(top: 16, left: 16, bottom: 16, right: 16)
        case .none: return .init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
