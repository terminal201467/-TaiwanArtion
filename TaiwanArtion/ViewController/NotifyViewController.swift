//
//  NotifyViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import UIKit

class NotifyViewController: UIViewController {
    
    private let viewModel = NotifyViewModel()

    private let notifyView = NotifyView()
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = notifyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setCollectionView()
        setNavigationBar()
        setSwitchButton()
    }
    
    private func setSwitchButton() {
        notifyView.notifyIsOn = { isOn in
            print("isOn:\(isOn)")
            self.viewModel.toggleNotification(isOn: isOn)
        }
    }
    
    private func setNavigationBar() {
        navigationItem.hidesBackButton = true
    }
    
    private func setTableView() {
        notifyView.tableView.delegate = self
        notifyView.tableView.dataSource = self
    }
    
    private func setCollectionView() {
        notifyView.collectionView.dataSource = self
        notifyView.collectionView.delegate = self
    }

}

extension NotifyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifyView.setTableHasDataBy(count: viewModel.numberOfRowInSection(section: section))
//        notifyView.setConfigureUnRead(isRead: viewModel.,
//                                      unReadCount: viewModel.numberOfRowInSection(section: section))
        return viewModel.numberOfRowInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotifyTableViewCell.reuseIdentifier, for: indexPath) as! NotifyTableViewCell
//        if let cellInfo = viewModel.cellForRowAt(indexPath: indexPath) {
//            cell.configure(title: cellInfo.title,
//                           date: cellInfo.date,
//                           location: cellInfo.location,
//                           dayBefore: "\(9)",
//                           tag: "雕塑")
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectedRowAt(indexPath: indexPath)
    }
}

extension NotifyViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NotifyType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExhibitionCardItemCell.reuseIdentifier, for: indexPath) as! ExhibitionCardItemCell
        cell.configure(title: viewModel.notifyTypeCellForRowAt(indexPath: indexPath).type.title, selected: viewModel.notifyTypeCellForRowAt(indexPath: indexPath).isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.notifyTypeDidItemSelectedRowAt(indexPath: indexPath)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width / 2
        let cellHeight = collectionView.frame.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 5, bottom: 5, right: 5)
    }
}
