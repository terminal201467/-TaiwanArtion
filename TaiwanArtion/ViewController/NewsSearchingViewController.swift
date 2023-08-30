//
//  NewsSearchingViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/28.
//

import UIKit

enum NewsPageSections: Int, CaseIterable {
    case timeContent = 0, habbyContent, newsFilterMenu, newsContent
}

class NewsSearchingViewController: UIViewController {

    private let newsSearchingView = NewsSearchingView()
    
    private let viewModel = NewsSearchingViewModel()
    
    //MARK: -LifeCycle
    override func loadView() {
        super.loadView()
        view = newsSearchingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavagationBar()
        setDelegates()
        setSearchBar()
    }
    
    //MARK: -NavigationBar
    private func setNavagationBar() {
        let backButton = UIBarButtonItem(image: .init(named: "leftArrow")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = newsSearchingView.searchBar
    }
    
    private func setSearchBar() {
        newsSearchingView.searchBar.searchTextField.delegate = self
    }
    
    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setDelegates() {
        newsSearchingView.collectionView.delegate = self
        newsSearchingView.collectionView.dataSource = self
        newsSearchingView.tableView.delegate = self
        newsSearchingView.tableView.dataSource = self
    }
}

extension NewsSearchingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch NewsPageSections(rawValue: section) {
        case .timeContent: return .init(width: collectionView.frame.width, height: 40)
        case .habbyContent: return .zero
        case .newsFilterMenu: return .init(width: collectionView.frame.width, height: 40)
        case .newsContent: return .zero
        case .none: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let titleHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionReusableHeaderView.reuseIdentifier, for: indexPath) as! TitleCollectionReusableHeaderView
        switch NewsPageSections(rawValue: indexPath.section) {
        case .timeContent:
            let currentDate = Date() // 取得當前日期和時間
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: currentDate)
            titleHeaderView.configure(text: "\(currentYear)", textSize: 18)
        case .habbyContent: print("habbyContent")
        case .newsFilterMenu: print("newsFilterMenu")
            titleHeaderView.configure(text: "藝文新聞", textSize: 22)
        case .newsContent: print("newsContent")
        case .none: print("none")
        }
        return titleHeaderView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return NewsPageSections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch NewsPageSections(rawValue: section) {
        case .timeContent: return 1
        case .habbyContent: return HabbyItem.allCases.count
        case .newsFilterMenu: return 1
        case .newsContent: return viewModel.outputFilterNews.value.count
        case .none: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch NewsPageSections(rawValue: indexPath.section) {
        case .timeContent:
            let monthContentCell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthsHorizontalCollectionViewCell.reuseIdentifier, for: indexPath) as! MonthsHorizontalCollectionViewCell
            monthContentCell.selectedMonth = { month in
                self.viewModel.input.inputMonth.accept(month)
            }
            return monthContentCell
        case .habbyContent:
            let habbyContentCell = collectionView.dequeueReusableCell(withReuseIdentifier: HabbyCollectionViewCell.reuseIdentifier, for: indexPath) as! HabbyCollectionViewCell
            var isSelected = viewModel.output.outputHabby.value == HabbyItem.allCases[indexPath.row]
            habbyContentCell.configureHabbyWithoutBorder(by: HabbyItem.allCases[indexPath.row], isSelected: isSelected)
            return habbyContentCell
        case .newsFilterMenu:
            let newsMenuCell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterNewsHorizontalCollectionViewCell.reuseIdentifier, for: indexPath) as! FilterNewsHorizontalCollectionViewCell
            newsMenuCell.backgroundColor = .whiteGrayColor
            newsMenuCell.filterItem = { item in
                self.viewModel.input.inputNewsFilter.accept(item)
            }
            return newsMenuCell
        case .newsContent:
            if viewModel.output.outputFilterNews.value.isEmpty {
                //如果沒有新聞資料的話，就顯示沒有資料的View
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UICollectionViewCell
                cell.backgroundColor = .whiteGrayColor
                return cell
            } else {
                let newsContentCell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.reuseIdentifier, for: indexPath) as! NewsCollectionViewCell
                let newsInfo = viewModel.output.outputFilterNews.value[indexPath.row]
                newsContentCell.configure(image: newsInfo.image, title: newsInfo.title, date: newsInfo.date, author: newsInfo.author)
                newsContentCell.backgroundColor = .whiteGrayColor
                return newsContentCell
            }
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch NewsPageSections(rawValue: section) {
        case .timeContent: return .init(top: 8, left: 16, bottom: 8, right: 16)
        case .habbyContent: return .init(top: 8, left: 16, bottom: 8, right: 16)
        case .newsFilterMenu: return .init(top: 8, left: 16, bottom: 8, right: 16)
        case .newsContent: return .init(top: 0, left: 0, bottom: 0, right: 0)
        case .none: return .init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch NewsPageSections(rawValue: indexPath.section) {
        case .timeContent:
            let cellWidth = collectionView.frame.width
            let cellHeight = 49.0
            return .init(width: cellWidth, height: cellHeight)
        case .habbyContent:
            let cellWidth = (collectionView.frame.width - (30 * 4)) / 5
            let cellHeight = 62.0
            return .init(width: cellWidth, height: cellHeight)
        case .newsFilterMenu:
            let cellWidth = collectionView.frame.width
            let cellHeight = 34.0
            return .init(width: cellWidth, height: cellHeight)
        case .newsContent:
            let cellWidth = collectionView.frame.width / 4
            let cellHeight = collectionView.frame.height / 4
            return .init(width: cellWidth, height: cellHeight)
        case .none: return .init(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch NewsPageSections(rawValue: indexPath.section) {
        case .timeContent: viewModel.input.inputMonth.accept(Month.allCases[indexPath.row])
        case .habbyContent: viewModel.input.inputSelectHabby.accept(HabbyItem.allCases[indexPath.row])
        case .newsFilterMenu: viewModel.input.inputNewsFilter.accept(NewsFilterItem.allCases[indexPath.row])
        case .newsContent:
            print("push到新聞頁面")
            //push到新聞的頁面
        case .none: print("none")
        }
        collectionView.reloadData()
    }
}

extension NewsSearchingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = TitleHeaderView()
        titleView.configureTitle(with: "搜尋紀錄")
        titleView.configureButton(with: "清除紀錄")
        let containerView = UIView()
        containerView.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return containerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.outputFilterNews.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.reuseIdentifier, for: indexPath) as! SearchHistoryTableViewCell
        cell.configure(history: viewModel.output.outputNewsSearchingHistory.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newsSearchingView.searchBar.searchTextField.text = viewModel.output.outputNewsSearchingHistory.value[indexPath.row]
    }
}

extension NewsSearchingViewController: UISearchTextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        newsSearchingView.isSearchingMode = false
        viewModel.input.inputFinishEditing.onNext(())
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        newsSearchingView.isSearchingMode = true
        viewModel.input.inputSearchingText.accept(textField.text ?? "")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.input.inputSearchingText.accept(textField.text ?? "")
    }
}


