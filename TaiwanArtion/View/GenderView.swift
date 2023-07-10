//
//  GenderView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/10.
//

import UIKit

class GenderView: UIView {
    
    var selectedGender: ((String?) -> Void)?
    
    private var genders: [String] = ["男性", "女性"]
    
    private var currentSelectedGender: String = ""
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.allowsSelection = true
        tableView.backgroundColor = .white
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTable()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTable() {
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

extension GenderView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        genders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UITableViewCell
        let isSelected = genders[indexPath.row] == currentSelectedGender
        cell.textLabel?.text = genders[indexPath.row]
        cell.textLabel?.textColor = isSelected ? .brownColor : .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGender?(genders[indexPath.row])
        currentSelectedGender = genders[indexPath.row]
        tableView.reloadData()
    }
}
