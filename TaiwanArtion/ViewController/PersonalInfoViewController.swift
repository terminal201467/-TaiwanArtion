//
//  PersonalInfoViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/21.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class PersonalInfoViewController: UIViewController, UIScrollViewDelegate {
    
    private let personInfoView = PersonalInfoView()
    
    private let personFileView = PersonalFileView()
    
    private let viewModel = PersonInfoViewModel()
    
    private let disposeBag = DisposeBag()

    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = personFileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setPersonInfoView()
        setTableView()
    }
    
    private func setNavigationBar() {
        navigationItem.hidesBackButton = true
        title = "編輯個人檔案"
        let closeButton = UIBarButtonItem(image: .init(named: "close")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc private func close() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setPersonInfoView() {
        personFileView.tableContainerView.addSubview(personInfoView)
        personInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setTableView() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel> { dataSource, tableView, indexPath, item in
            switch item.infoType {
            case .name:
                let cell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier) as! InputTextFieldTableViewCell
                cell.generalConfigure(placeholdText: item.infoType.placeHolder)
                cell.inputAction = { self.viewModel.nameInput.accept($0) }
                return cell
            case .gender:
                let cell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.reuseIdentifier) as! GenderTableViewCell
                cell.configure(gender: nil)
                return cell
            case .birth:
                let cell = tableView.dequeueReusableCell(withIdentifier: BirthTableViewCell.reuseIdentifier) as! BirthTableViewCell
                cell.configure(year: nil, date: nil)
                return cell
            case .email:
                let cell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier) as! InputTextFieldTableViewCell
                cell.generalConfigure(placeholdText: item.infoType.placeHolder)
                cell.inputAction = { self.viewModel.emailInput.accept($0) }
                return cell
            case .phone:
                let cell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier) as! InputTextFieldTableViewCell
                cell.generalConfigure(placeholdText: item.infoType.placeHolder)
                cell.inputAction = { self.viewModel.phoneInput.accept($0) }
                return cell
            case .save:
                let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier) as! ButtonTableViewCell
                self.viewModel.saveCheck.subscribe { isAllowSaved in
                    cell.button.isEnabled = isAllowSaved ? true : false
                    cell.button.backgroundColor = isAllowSaved ? .brownColor : .whiteGrayColor
                }
                cell.action = { self.viewModel.saveAction.onNext(()) }
                return cell
            }
        }
        
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].sectionName
         }
        
        viewModel.output.tableItemInfo
            .bind(to: personInfoView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
