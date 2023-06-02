//
//  HotHxhibitionTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/12.
//

import UIKit

class HotHxhibitionTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "HotHxhibitionTableViewCell"
    
    private let viewModel = HomeViewModel.shared
    
    var pushToViewController: ((ExhibitionModel) -> Void)?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(HotDetailTableViewCell.self, forCellReuseIdentifier: HotDetailTableViewCell.reuseIdentifier)
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setTableView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HotHxhibitionTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.hotExhibitionNumberOfRowInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HotDetailTableViewCell.reuseIdentifier, for: indexPath) as! HotDetailTableViewCell
        let exhibition = viewModel.hotExhibitionCellForRowAt(indexPath: indexPath)
        cell.configure(number: "0\(indexPath.row + 1)", title: exhibition.title, location: exhibition.location, date: exhibition.dateString, image: exhibition.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let seperatedHeight = 4 * CGFloat(8)
        let cellHeight = CGFloat(tableView.frame.height - seperatedHeight) / 5
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.hotExhibitionDidSelectedRowAt(indexPath: indexPath) { exhibition in
            self.pushToViewController?(exhibition)
        }
    }
}
