//
//  AllCommentTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/29.
//

import UIKit

class AllCommentTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "AllCommentTableViewCell"
    
    //MARK: - Intialization Consequense
    
    enum CellType {
        case allcomment, personComment
    }
    
    enum CommentType: Int, CaseIterable {
        case contentRichness = 0, equipment, geoLocation, price, serice
        var text: String {
            switch self {
            case .contentRichness: return "內容豐富度"
            case .equipment: return "設備"
            case .geoLocation: return "地理設備"
            case .price: return "價格"
            case .serice: return "服務"
            }
        }
    }
    
    var commentTypeScores: [Double] = []
    
    var averageScore: Int = 4
    
    //MARK: - UI settings
    
    private let personImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.roundCorners(cornerRadius: imageView.frame.size.width / 2)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .grayTextColor
        return label
    }()
    
    private let commentTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: ScoreTableViewCell.reuseIdentifier)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .whiteGrayColor
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
        commentTableView.delegate = self
        commentTableView.dataSource = self
    }
    
    private func autoLayout() {

    }
    
    func configurePersonComment(name: String, personImageText: String, starScore: Int, date: String) {

    }
    
}

extension AllCommentTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.reuseIdentifier, for: indexPath) as! ScoreTableViewCell
        cell.configure(title: CommentType.allCases[indexPath.row].text,
                       score: commentTypeScores[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = ExhibitionCardItemCollectionView()
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        return view
    }
}
