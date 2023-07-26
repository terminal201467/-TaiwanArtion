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
    
    private var year: String? = nil
    
    private var month: String? = nil
    
    private var date: String? = nil
    
    private let disposeBag = DisposeBag()
    
    private let calendarPopUpView = CalendarPopUpView()
    
    private let timer = CountdownTimer(timeInterval: 2)
    
    private var littleTopPopUpView: LittleTopPopUpView = {
        let view = LittleTopPopUpView()
        view.configure(title: "編輯個人檔案成功", image: "brownCheck")
        return view
    }()
    
    private let settingHeadViewController = SettingHeadViewController()
    
    private lazy var popUpViewController: PopUpViewController = {
        let popUpViewController = PopUpViewController(popUpView: calendarPopUpView)
        popUpViewController.modalPresentationStyle = .overFullScreen
        popUpViewController.modalTransitionStyle = .coverVertical
        calendarPopUpView.dismissFromController = {
            popUpViewController.dismiss(animated: true)
        }
        return popUpViewController
    }()
    
    private lazy var saveSucceedPopUpViewController: PopUpViewController = {
        let popUpViewController = PopUpViewController(popUpView: littleTopPopUpView)
        popUpViewController.modalPresentationStyle = .overFullScreen
        popUpViewController.modalTransitionStyle = .coverVertical
        littleTopPopUpView.dismissFromController = {
            popUpViewController.dismiss(animated: true)
        }
        return popUpViewController
    }()

    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = personFileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTable()
        setHeadButton()
        setPopUpViewDismiss()
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
    
    private func setHeadButton() {
        settingHeadViewController.selectedHeadPhoto = { photo in
            self.personFileView.configurePersonImageButton(image: photo)
            //popUp
        }
        personFileView.changePhoto = {
            self.navigationController?.pushViewController(self.settingHeadViewController, animated: true)
        }
    }
    
    private func setTable() {
        personFileView.tableContainerView.addSubview(personInfoView)
        personInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        personInfoView.tableView.delegate = self
        personInfoView.tableView.dataSource = self
    }
    
    private func setPopUpViewDismiss() {
        timer.onCompleted = {
            self.dismiss(animated: true)
        }
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
            personInfoView.genderView.selectedGender = {
                cell.configure(gender: $0)
                self.personInfoView.genderView.isHidden.toggle()
            }
            return cell
        case .birth:
            let cell = tableView.dequeueReusableCell(withIdentifier: BirthTableViewCell.reuseIdentifier) as! BirthTableViewCell
            personInfoView.yearView.selectedYear = {
                cell.configureYearLabel(year: $0)
                self.personInfoView.yearView.isHidden.toggle()
            }
            
            calendarPopUpView.receiveMonthAndDate = { month, date in
                cell.configureDateLabel(month: month, date: date)
            }
            cell.configureYearLabel(year: nil)
            cell.configureDateLabel(month: nil, date: nil)
            cell.chooseDateAction = {
                self.present(self.popUpViewController, animated: true)
            }
            return cell
        case .email:
            let cell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier) as! InputTextFieldTableViewCell
            cell.generalConfigure(placeholdText: PersonInfo.email.placeHolder)
            cell.inputAction = { self.viewModel.input.emailInput.accept($0) }
            return cell
        case .phone:
            let cell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier) as! InputTextFieldTableViewCell
            cell.generalConfigure(placeholdText: PersonInfo.phone.placeHolder)
            cell.inputAction = { self.viewModel.input.phoneInput.accept($0) }
            return cell
        case .save:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier) as! ButtonTableViewCell
            self.viewModel.saveCheck.subscribe { isAllowSaved in
                cell.button.isEnabled = isAllowSaved ? true : false
                cell.button.backgroundColor = isAllowSaved ? .brownColor : .whiteGrayColor
                cell.button.setTitleColor(isAllowSaved ? .white : .grayTextColor, for: .normal)
                cell.configure(buttonName: PersonInfo.save.placeHolder)
            }
            cell.action = {
                self.viewModel.input.saveAction.onNext(())
                self.present(self.saveSucceedPopUpViewController, animated: true)
                self.timer.start()
            }
            return cell
        case .none: return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if PersonInfo(rawValue: indexPath.section) == .gender {
            guard let genderCell = cell as? GenderTableViewCell else { return }
            personInfoView.genderView.snp.makeConstraints { make in
                make.top.equalTo(genderCell.containerView.snp.bottom)
                make.leading.equalTo(genderCell.containerView.snp.leading)
                make.trailing.equalTo(genderCell.containerView.snp.trailing)
                make.height.equalTo(genderCell.containerView.snp.height).multipliedBy(2.0)
            }
            genderCell.action = {
                self.personInfoView.genderView.isHidden.toggle()
            }
        }
        
        if PersonInfo(rawValue: indexPath.section) == .birth {
            guard let birthCell = cell as? BirthTableViewCell else { return }
            personInfoView.yearView.snp.makeConstraints { make in
                make.top.equalTo(birthCell.yearContainerView.snp.bottom)
                make.leading.equalTo(birthCell.yearContainerView.snp.leading)
                make.trailing.equalTo(birthCell.yearContainerView.snp.trailing)
                make.height.equalTo(birthCell.yearContainerView.snp.height).multipliedBy(5.0)
            }
            birthCell.chooseYearAction = {
                self.personInfoView.yearView.isHidden.toggle()
            }
        }
    }
}




