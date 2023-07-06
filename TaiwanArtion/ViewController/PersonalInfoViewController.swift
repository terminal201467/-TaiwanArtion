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
        setTable()
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
    
//    private func setTableView() {
//        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel> { dataSource, tableView, indexPath, item in
//            switch item.infoType {
//            case .name:
//                let cell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier) as! InputTextFieldTableViewCell
//                cell.generalConfigure(placeholdText: item.infoType.placeHolder)
//                cell.inputAction = { self.viewModel.nameInput.accept($0) }
//                return cell
//            case .gender:
//                let cell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.reuseIdentifier) as! GenderTableViewCell
//                cell.configure(gender: nil)
//                return cell
//            case .birth:
//                let cell = tableView.dequeueReusableCell(withIdentifier: BirthTableViewCell.reuseIdentifier) as! BirthTableViewCell
//                cell.configure(year: nil, date: nil)
//                return cell
//            case .email:
//                let cell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier) as! InputTextFieldTableViewCell
//                cell.generalConfigure(placeholdText: item.infoType.placeHolder)
//                cell.inputAction = { self.viewModel.emailInput.accept($0) }
//                return cell
//            case .phone:
//                let cell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier) as! InputTextFieldTableViewCell
//                cell.generalConfigure(placeholdText: item.infoType.placeHolder)
//                cell.inputAction = { self.viewModel.phoneInput.accept($0) }
//                return cell
//            case .save:
//                let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier) as! ButtonTableViewCell
//                self.viewModel.saveCheck.subscribe { isAllowSaved in
//                    cell.button.isEnabled = isAllowSaved ? true : false
//                    cell.button.backgroundColor = isAllowSaved ? .brownColor : .whiteGrayColor
//                }
//                cell.action = { self.viewModel.saveAction.onNext(()) }
//                return cell
//            }
//        }
//
//        dataSource.titleForHeaderInSection = { ds, index in
//            return ds.sectionModels[index].sectionName
//         }
//
//        viewModel.output.tableItemInfo
//            .bind(to: personInfoView.tableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
//    }
    
    private func setTable() {
        personFileView.tableContainerView.addSubview(personInfoView)
        personInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        personInfoView.tableView.delegate = self
        personInfoView.tableView.dataSource = self
    }
}

extension PersonalInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch PersonInfo(rawValue: section) {
        case .name: return 1
        case .gender: return 1
        case .birth: return 1
        case .email: return 1
        case .phone: return 1
        case .save: return 1
        case .none: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return PersonInfo(rawValue: section) == .save ? 0 : 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return PersonInfo.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        let titleHeader = TitleHeaderView()
        containerView.addSubview(titleHeader)
        titleHeader.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        switch PersonInfo(rawValue: section) {
        case .name: titleHeader.configureTitle(with: PersonInfo.name.section)
        case .gender: titleHeader.configureTitle(with: PersonInfo.gender.section)
        case .birth: titleHeader.configureTitle(with: PersonInfo.birth.section)
        case .email: titleHeader.configureTitle(with: PersonInfo.email.section)
        case .phone: titleHeader.configureTitle(with: PersonInfo.phone.section)
        case .save: return nil
        case .none: return nil
        }
        return containerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch PersonInfo(rawValue: indexPath.section) {
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier) as! InputTextFieldTableViewCell
            cell.generalConfigure(placeholdText: PersonInfo.name.placeHolder)
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
            cell.generalConfigure(placeholdText: PersonInfo.email.placeHolder)
            cell.inputAction = { self.viewModel.emailInput.accept($0) }
            return cell
        case .phone:
            let cell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier) as! InputTextFieldTableViewCell
            cell.generalConfigure(placeholdText: PersonInfo.phone.placeHolder)
            cell.inputAction = { self.viewModel.phoneInput.accept($0) }
            return cell
        case .save:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier) as! ButtonTableViewCell
            self.viewModel.saveCheck.subscribe { isAllowSaved in
                cell.button.isEnabled = isAllowSaved ? true : false
                cell.button.backgroundColor = isAllowSaved ? .brownColor : .whiteGrayColor
                cell.button.setTitleColor(isAllowSaved ? .white : .grayTextColor, for: .normal)
                cell.configure(buttonName: PersonInfo.save.placeHolder)
            }
            cell.action = { self.viewModel.saveAction.onNext(()) }
            return cell
        case .none: return UITableViewCell()
        }
    }
}




