//
//  HotHxhibitionTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/12.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class HotHxhibitionTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "HotHxhibitionTableViewCell"
    
    private let viewModel = HomeViewModel.shared
    
    var pushToViewController: ((ExhibitionInfo) -> Void)?
    
    private let disposeBag = DisposeBag()
    
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
        setTableViewBinding()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTableViewBinding() {
        viewModel.hotExhibitionObservable
            .bind(to: tableView.rx.items(cellIdentifier: HotDetailTableViewCell.reuseIdentifier, cellType: HotDetailTableViewCell.self)) { (row, item, cell) in
                cell.configure(number: "\(row + 1)", title: item.title, location: item.city, date: item.dateString, image: item.image)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.viewModel.inputs.hotExhibitionSelected.onNext(indexPath)
            })
            .disposed(by: disposeBag)
        
//        viewModel.outputs.didSelectedHotExhibitionRow
//            .subscribe(onNext: { info in
//                self.pushToViewController?(info)
//            })
//            .disposed(by: disposeBag)
    }
    
    private func autoLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HotHxhibitionTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let seperatedHeight = 4 * CGFloat(8)
        let cellHeight = CGFloat(tableView.frame.height - seperatedHeight) / 5
        return cellHeight
    }
}
