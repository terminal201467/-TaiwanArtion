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
    
    private let littleTopPopUpView: LittleTopPopUpView = {
        let view = LittleTopPopUpView()
        view.configure(title: "已開啟推播通知", image: "brownCheck")
        return view
    }()
    
    private lazy var popUpViewController: PopUpViewController = {
        let popUpViewController = PopUpViewController(popUpView: littleTopPopUpView)
        popUpViewController.modalPresentationStyle = .overFullScreen
        popUpViewController.modalTransitionStyle = .coverVertical
        littleTopPopUpView.dismissFromController = {
            popUpViewController.dismiss(animated: false)
        }
        return popUpViewController
    }()
    
    private let timer = CountdownTimer(timeInterval: 2)
    
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
        setButton()
    }
    
    private func setButton() {
        notifyView.notifyIsOn = { isOn in
            self.viewModel.toggleNotification(isOn: isOn)
            if isOn == true {
                self.present(self.popUpViewController, animated: false)
                self.timer.start()
            }
            self.timer.onCompleted = {
                self.dismiss(animated: false)
            }
        }
        
        notifyView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
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
        return viewModel.numberOfRowInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        notifyView.setConfigureUnRead(isRead: viewModel.isReadCellAt(indexPath: indexPath), unReadCount: viewModel.setUnReadCount())
        switch viewModel.currentNotifyPage {
        case .exhibitionNotify:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotifyTableViewCell.reuseIdentifier, for: indexPath) as! NotifyTableViewCell
            guard let exhibitionNotifyModel = viewModel.exhibitionsCellForRowAt(indexPath: indexPath) else { return UITableViewCell() }
            notifyView.setTableHasDataBy(count: viewModel.numberOfRowInSection(section: indexPath.section))
            cell.configure(image: exhibitionNotifyModel.image,
                               title: exhibitionNotifyModel.title,
                               date: exhibitionNotifyModel.dateString,
                               location: exhibitionNotifyModel.location,
                               dayBefore: exhibitionNotifyModel.dateBefore,
                               tag: "雕塑")
            cell.selectionStyle = .none
            return cell
        case .systemNotify:
            let cell = tableView.dequeueReusableCell(withIdentifier: SystemTableViewCell.reuseIdentifier, for: indexPath) as! SystemTableViewCell
            guard let systemModel = viewModel.systemNotificationsCellForRowAt(indexPath: indexPath) else { return UITableViewCell() }
                cell.configure(title: systemModel.title,
                               description: systemModel.description,
                               dayBefore: systemModel.dateBefore)
            notifyView.setTableHasDataBy(count: viewModel.numberOfRowInSection(section: indexPath.section))
            cell.selectionStyle = .none
            return cell
        }
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
        self.notifyView.tableView.reloadData()
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
