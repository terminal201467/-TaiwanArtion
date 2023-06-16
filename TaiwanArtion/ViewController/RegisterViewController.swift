//
//  RegisterViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/14.
//

import UIKit

class RegisterViewController: UIViewController {

    private let registerView = RegisterView()
    
    private let viewModel = RegisterViewModel()
    
    //MARK: -LifeCycle
    override func loadView() {
        super.loadView()
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setCollectionView()
        setTableView()
    }
    
    //MARK: - Methods
    private func setNavigationBar() {
        navigationController?.navigationItem.title = "會員註冊"
        let backButton = UIBarButtonItem(image: .init(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setCollectionView() {
        registerView.stepCollectionView.dataSource = self
        registerView.stepCollectionView.delegate = self
    }
    
    private func setTableView() {
        switch viewModel.getCurrentStep() {
        case .phoneVerify:
        case .acountPassword:
        case .emailVerify:
        case .complete:
        }
    }

}
extension RegisterViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.stepsNumberOfRowInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellnfo = viewModel.stepsCellForRowAt(indexPath: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegisterStepCollectionViewCell.reuseIdentifier, for: indexPath) as! RegisterStepCollectionViewCell
        cell.configure(isCurrentStep: cellnfo.isSelected, step: indexPath.row + 1, stepTitle: cellnfo.stepString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width / 4
        let cellHeight = 60.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 12, bottom: 12, right: 12)
    }
}
