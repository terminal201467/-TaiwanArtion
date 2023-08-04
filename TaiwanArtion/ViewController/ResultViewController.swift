//
//  ResultViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/31.
//

import UIKit
import RxSwift

enum Mode: Int {
    case searchingMode = 0, nothingMode, filterMode
}

class ResultViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    weak var delegate: ResultControllerDelegate?
    
    private let resultView = ResultView()
    
    private let viewModel = ResultViewModel()
    
    private var searchHistoryView: SearchingHistoryView?

    override func loadView() {
        super.loadView()
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMenu()
        viewModel.output.currentExhibitionMenu
            .subscribe(onNext: { menu in
                self.setViewInContainer(by: menu.rawValue)
            })
            .disposed(by: disposeBag)
    }
    
    private func setMenu() {
        resultView.menu.selectedMenuItem = { selectItem in
            self.viewModel.input.currentMenuRelay.accept(CollectMenu(rawValue: selectItem)!)
//            self.setViewInContainer(by: selectItem)
        }
    }
    
    private func setViewInContainer(by menuOrder: Int) {
        resultView.removeAllSubviews(from: resultView.containerView)
        switch CollectMenu(rawValue: menuOrder) {
        case .collectExhibition:
            viewModel.output.storeHistoryObservable.subscribe(onNext: { historys in
                print("history:\(historys)")
                self.searchHistoryView = SearchingHistoryView(frame: .zero, historys: historys.map{$0.title}, type: .exhibitionNothingSearch)
            })
            .disposed(by: disposeBag)
            if let view = searchHistoryView {
                resultView.containerView.addSubview(view)
                view.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
        case .collectExhibitionHall:
            viewModel.output.storeExhibitionHallObservable.subscribe(onNext: { hallInfos in
                print("hallInfo:\(hallInfos)")
                self.searchHistoryView = SearchingHistoryView(frame: .zero, historys: hallInfos.map{$0.title}, type: .exhibitionHallNothingSearch)
            })
            .disposed(by: disposeBag)
            if let view = searchHistoryView {
                resultView.containerView.addSubview(view)
                view.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
        case .collectNews:
            viewModel.output.storeNewsObservable.subscribe(onNext: { news in
                print("news:\(news)")
                self.searchHistoryView = SearchingHistoryView(frame: .zero, historys: news.map{$0.title}, type: .newsNothingSearch)
            })
            .disposed(by: disposeBag)
            if let view = searchHistoryView {
                resultView.containerView.addSubview(view)
                view.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
        case .none: print("none")
        }
    }
    
    
    @objc func backButtonTapped() {
        // 在這裡執行返回操作，例如返回上一個畫面
        // 或者退出搜索模式（如果你想保留搜索結果，可以不退出搜索模式）
        delegate?.resultControllerDidCancelSearch()
    }

}
