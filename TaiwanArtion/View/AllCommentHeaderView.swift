//
//  AllCommentHeaderView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/29.
//

import UIKit
import SnapKit

class AllCommentHeaderView: UIView {
    
    var scores: [Double] = []
    
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
    
    var averageScore: Int = 0

    private let containerBrownView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 10)
        view.backgroundColor = .brownColor
        return view
    }()
    
    private let backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .whiteGrayColor
        view.roundCorners(cornerRadius: 12.0)
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let commentCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .grayTextColor
        return label
    }()
    
    private let starCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(StarCollectionViewCell.self, forCellWithReuseIdentifier: StarCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var commentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [commentCountLabel, starCollectionView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [containerBrownView, commentStack])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        return stackView
    }()
    
    private let scoreTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: ScoreTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .whiteGrayColor
        return tableView
    }()
    
    private let exhibitionCardItemView = ExhibitionCardItemCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
        setTableView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionView() {
        starCollectionView.delegate = self
        starCollectionView.dataSource = self
    }
    
    private func setTableView() {
        scoreTableView.delegate = self
        scoreTableView.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(exhibitionCardItemView)
        exhibitionCardItemView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(34.0)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(exhibitionCardItemView.snp.top).offset(-16)
        }
        
        containerBrownView.snp.makeConstraints { make in
            make.width.equalTo(48.0)
            make.height.equalTo(48.0)
        }
        
        containerBrownView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        backgroundView.addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.leading.equalTo(backgroundView.snp.leading).offset(16)
            make.top.equalTo(backgroundView.snp.top).offset(16)
            make.height.equalTo(48.0)
        }
        
        addSubview(scoreTableView)
        scoreTableView.snp.makeConstraints { make in
            make.top.equalTo(infoStack.snp.bottom).offset(16)
            make.leading.equalTo(infoStack.snp.leading)
            make.trailing.equalTo(backgroundView.snp.trailing).offset(-16)
            make.height.equalTo(159.0)
        }
        
    }
    
    func configureAllComment(number: Int, commentCount: Int, starScore: Int) {
        numberLabel.text = "\(number)"
        commentCountLabel.text = "\(commentCount)則評論"
        self.averageScore = starScore
    }

}

//MARK: - StarCollectionView
extension AllCommentHeaderView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StarCollectionViewCell.reuseIdentifier, for: indexPath) as! StarCollectionViewCell
        cell.configure(isValueStar: averageScore == indexPath.row)
        cell.backgroundColor = .whiteGrayColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 10.0
        let cellHeight = 10.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
}

//MARK: - TableView
extension AllCommentHeaderView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.reuseIdentifier, for: indexPath) as! ScoreTableViewCell
        cell.configure(title: CommentType.allCases[indexPath.row].text, score: scores[indexPath.row])
        return cell
    }
}
