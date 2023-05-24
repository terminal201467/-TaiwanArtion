//
//  HomeViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/12.
//

import UIKit

enum YearCell: Int, CaseIterable {
    case monthCell = 0, habbyCell, mainPhotoCell
}

enum HotCell: Int, CaseIterable {
    case hotExhibition = 0
    var title: String {
        switch self {
        case .hotExhibition: return "熱門展覽"
        }
    }
}

enum NewsCell: Int, CaseIterable {
    case newsExhibition = 0
    var title: String {
        switch self {
        case .newsExhibition: return "藝文新聞"
        }
    }
}

enum AllCell: Int, CaseIterable {
    case allExhibition = 0
    var title: String {
        switch self {
        case .allExhibition: return "所有展覽"
        }
    }
}

class HomeViewController: UIViewController {

    private let homeView = HomeView()
    
    private let viewModel = HomeViewModel.shared
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
    }
    
    private func setNavigationBar() {
        navigationItem.hidesBackButton = true
    }
    
    private func setTableView() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch HomeSections(rawValue: section) {
        case .year: return 3
        case .hot: return 1
        case .news: return 1
        case .all: return 1
        case .none: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch HomeSections(rawValue: indexPath.section) {
        case .year:
            switch YearCell(rawValue: indexPath.row) {
            case .monthCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: MonthTableViewCell.reuseIdentifier, for: indexPath) as! MonthTableViewCell
                cell.selectionStyle = .none
                return cell
            case .habbyCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: HabbyTableViewCell.reuseIdentifier, for: indexPath) as! HabbyTableViewCell
                return cell
            case .mainPhotoCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: MainPhotosTableViewCell.reuseIdentifier, for: indexPath) as! MainPhotosTableViewCell
                cell.selectionStyle = .none
                cell.mainPhotos = self.viewModel.mainPhoto
                return cell
            case .none: return UITableViewCell()
            }
        case .hot:
            switch HotCell(rawValue: indexPath.row) {
            case .hotExhibition:
                let cell = tableView.dequeueReusableCell(withIdentifier: HotHxhibitionTableViewCell.reuseIdentifier, for: indexPath) as! HotHxhibitionTableViewCell
                return cell
            case .none: return UITableViewCell()
            }
        case .news: return UITableViewCell()
        case .all: return UITableViewCell()
        case .none: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch HomeSections(rawValue: section) {
        case .year:
            let yearView = TitleHeaderView()
            yearView.configureYear(with: "2023")
            return yearView
        case .news:
            let newsView = TitleHeaderView()
            newsView.configureTitle(with: HomeSections.news.title)
            return newsView
        case .hot:
            let hotView = TitleHeaderView()
            hotView.configureTitle(with: HomeSections.hot.title)
            return hotView
        case .all:
            let allView = TitleHeaderView()
            allView.configureTitle(with: HomeSections.all.title)
            return allView
        case .none: return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch HomeSections(rawValue: indexPath.section) {
        case .year:
            switch YearCell(rawValue: indexPath.row) {
            case .monthCell: return 50.0
            case .habbyCell: return 140.0
            case .mainPhotoCell: return 280.0
            case .none: return 0
            }
        case .hot:
            switch HotCell(rawValue: indexPath.row) {
            case .hotExhibition: return 566.0
            case .none: return 0
            }
        case .news:
            switch NewsCell(rawValue: indexPath.row) {
            case .newsExhibition: return 268.0
            case .none: return 0
            }
        case .all:
            switch AllCell(rawValue: indexPath.row) {
            case .allExhibition: return 844.0
            case .none: return 0
            }
        case .none: return 0
        }
    }
}
