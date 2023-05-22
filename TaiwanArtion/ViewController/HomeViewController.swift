//
//  HomeViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/12.
//

import UIKit

enum TableCell : Int, CaseIterable {
    case month = 0, habby, mainExhibitioin, hotExhibition, newsExhibition, allExhibition
    var title: String {
        switch self {
        case .month: return ""
        case .habby: return ""
        case .mainExhibitioin: return ""
        case .hotExhibition: return "熱門展覽"
        case .newsExhibition: return "藝文新聞"
        case .allExhibition: return "所有展覽"
        }
    }
}

class HomeViewController: UIViewController {

    private let homeView = HomeView()
    
    private let viewModel = HomeViewModel()
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
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
        return TableCell.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TableCell(rawValue: indexPath.row) {
        case .month:
            let cell = tableView.dequeueReusableCell(withIdentifier: MonthTableViewCell.reuseIdentifier, for: indexPath) as! MonthTableViewCell
            return cell
        case .habby:
            let cell = tableView.dequeueReusableCell(withIdentifier: HabbyTableViewCell.reuseIdentifier, for: indexPath) as! HabbyTableViewCell
            return cell
        case .mainExhibitioin:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainPhotosTableViewCell.reuseIdentifier, for: indexPath) as! MainPhotosTableViewCell
            cell.mainPhotos = viewModel.mainPhoto
            return cell
        case .hotExhibition:
            let cell = tableView.dequeueReusableCell(withIdentifier: HotDetailTableViewCell.reuseIdentifier, for: indexPath) as! HotDetailTableViewCell
            cell.configure(title: viewModel.hotExhibition[indexPath.row].title,
                           location: viewModel.hotExhibition[indexPath.row].location,
                           date: viewModel.hotExhibition[indexPath.row].date,
                           image: viewModel.hotExhibition[indexPath.row].image)
            return cell
        case .newsExhibition:
            print("")
        case .allExhibition:
            print("")
        case .none:
            print("default")
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let frameHeight = view.frame.height
        switch TableCell(rawValue: indexPath.row) {
        case .month: return 43.0 * (43.0 / frameHeight)
        case .habby: return 140.0 * (140.0 / frameHeight)
        case .mainExhibitioin: return 230.0 * (230.0 / frameHeight)
        case .hotExhibition: return 566.0 * (566.0 / frameHeight)
        case .newsExhibition:return 268.0 * (268.0 / frameHeight)
        case .allExhibition:return 844.0 * (844.0 / frameHeight)
        case .none: return 0
        }
    }
}
