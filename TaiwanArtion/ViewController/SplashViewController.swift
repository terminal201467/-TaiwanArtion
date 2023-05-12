//
//  SplashViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/11.
//

import UIKit
import RxSwift
import RxCocoa

enum HabbyItem: Int, CaseIterable {
    case painting = 0, sculpture, calligraphy, design, camara, literature, media, installationArt, compositeMedia, history
    var imageText: String {
        switch self {
        case .painting: return "painting"
        case .sculpture: return "sculpture"
        case .calligraphy: return "calligraphy"
        case .design: return "design"
        case .camara: return "camara"
        case .literature: return "literature"
        case .media: return "media"
        case .installationArt: return "installationArt"
        case .compositeMedia: return "compositeMedia"
        case .history: return "history"
        }
    }
    var titleText: String {
        switch self {
        case .painting: return "繪畫"
        case .sculpture: return "雕塑"
        case .calligraphy: return "書法"
        case .design: return "設計"
        case .camara: return "攝影"
        case .literature: return "文學"
        case .media: return "影音"
        case .installationArt: return "裝置藝術"
        case .compositeMedia: return "複合媒材"
        case .history: return "歷史文物"
        }
    }
}
class SplashViewController: UIViewController {
    
    private let splashView = SplashView()
    
    private let viewModel = SplashViewModel()
    
    private let disposeBag = DisposeBag()
    
    private var select: Bool = false
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = splashView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setHabbyCollectionView()
        setNextButtonAllowTap()
    }
    
    private func setHabbyCollectionView() {
        splashView.habbyCollectionView.delegate = self
        splashView.habbyCollectionView.dataSource = self
    }
    
    private func setNextButtonAllowTap() {
        viewModel.allowTap = { allow in
            self.splashView.setNextButtonTappedOrNot(by: allow)
        }
    }
}

extension SplashViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HabbyItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabbyCollectionViewCell.reuseIdentifier, for: indexPath) as! HabbyCollectionViewCell
        cell.configureImageAndLabel(by: HabbyItem.allCases[indexPath.row])
//        cell.handleSelectedItemView(by: <#T##Bool#>)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHabbyText = HabbyItem(rawValue: indexPath.item)?.titleText ?? ""
        viewModel.handleSelectedItem.accept(selectedHabbyText)
        viewModel.handleSelectedIndex.accept(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width
        let availableHeight = collectionView.bounds.height
        let itemWidth = availableWidth / CGFloat(5)
        let itemHeight = availableHeight / CGFloat(4)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
