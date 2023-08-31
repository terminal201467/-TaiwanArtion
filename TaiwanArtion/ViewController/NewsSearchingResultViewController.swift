//
//  NewsSearchingResultViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/28.
//

import UIKit

class NewsSearchingResultViewController: UIViewController {
    
    private let viewModel = NewsSearchingViewModel.shared
    
    private let newsSearchingResultView = NewsSearchingResultView()
    
    override func loadView() {
        super.loadView()
        view = newsSearchingResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
    
    private func setNavigationBar() {
        let leftButton = UIBarButtonItem(image: .init(named: "back")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.titleView = newsSearchingResultView.searchBar
    }
    
    @objc private func back() {
        dismiss(animated: true)
    }
    
    private func setTableView() {
        newsSearchingResultView.tableView.delegate = self
        newsSearchingResultView.tableView.dataSource = self
    }
    
    private func setSearching() {
        
    }
}

extension NewsSearchingResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = TitleHeaderView()
        titleView.configureTitle(with: "搜尋紀錄")
        titleView.configureTextButton(with: "清除紀錄")
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
        newsSearchingResultView.searchBar.searchTextField.text = viewModel.output.outputNewsSearchingHistory.value[indexPath.row]
    }
}

extension NewsSearchingResultViewController: UISearchTextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        newsSearchingResultView.isSearchingMode = false
        viewModel.input.inputFinishEditing.onNext(())
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        newsSearchingResultView.isSearchingMode = true
        viewModel.input.inputSearchingText.accept(textField.text ?? "")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.input.inputSearchingText.accept(textField.text ?? "")
    }
}
