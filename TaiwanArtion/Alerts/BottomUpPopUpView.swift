//
//  BottomUpPopUpView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/14.
//

import UIKit
import RxSwift
import RxCocoa

enum FilterItems: Int, CaseIterable {
    case open = 0, highEvaluate, recent
    var text: String {
        switch self {
        case .open: return "營業中"
        case .highEvaluate: return "最高評價"
        case .recent: return "距離最近"
        }
    }
}

enum SearchItems: Int, CaseIterable {
    case mostSurvey = 0, mostCollect, mostEvaluation, recent
    var text: String {
        switch self {
        case .mostSurvey: return "最多瀏覽"
        case .mostCollect: return "最多收藏"
        case .mostEvaluation: return "最高評價"
        case .recent: return "日期由近到遠"
        }
    }
}

enum PopUpType: Int {
    case filter = 0, search
}

class BottomUpPopUpView: UIView {
    
    private let disposeBag = DisposeBag()
    
    var filterSelectedItem: ((FilterItems) -> Void)?
    
    var searchSelectedItem: ((SearchItems) -> Void)?
    
    var dismissFromController: (() -> Void)?
    
    private var popUpType: PopUpType
    
    init(frame: CGRect ,type: PopUpType) {
        self.popUpType = type
        super.init(frame: frame)
        autoLayout()
        setTableView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPresentedViewController))
        backgroundView.addGestureRecognizer(tapGesture)
    }

    private let backgroundView: UIView = {
        let view = UIView()
        view.alpha = 0.3
        view.backgroundColor = .black
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.setSpecificRoundCorners(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 12)
        return tableView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dismissPresentedViewController() {
        dismissFromController?()
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(3.0)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

extension BottomUpPopUpView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        let label: UILabel = {
           let label = UILabel()
            label.text = "篩選"
            label.textColor = .black
            label.font = .systemFont(ofSize: 14, weight: .heavy)
            return label
        }()
        containerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        return containerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popUpType == .filter ? FilterItems.allCases.count : SearchItems.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.reuseIdentifier, for: indexPath) as! FilterTableViewCell
        cell.selectionStyle = .none
        cell.configure(text: popUpType == .filter ? FilterItems.allCases[indexPath.row].text : SearchItems.allCases[indexPath.row].text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if popUpType == .filter {
            filterSelectedItem?(FilterItems(rawValue: indexPath.row)!)
        } else {
            searchSelectedItem?(SearchItems(rawValue: indexPath.row)!)
        }
        dismissFromController?()
    }
}
