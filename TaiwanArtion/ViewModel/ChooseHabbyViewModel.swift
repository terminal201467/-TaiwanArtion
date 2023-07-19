//
//  ChooseHabbyViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/18.
//

import Foundation
import RxSwift
import RxRelay

protocol ChooseHabbyInput {
    var inputCellForRowAt: BehaviorRelay<IndexPath> { get }
    var didSelectedRowAt: BehaviorRelay<IndexPath> { get }
    var tapAction: PublishSubject<Void> { get }
}

protocol ChooseHabbyOutput {
    var outputCellForRowAt: BehaviorRelay<(HabbyItem?, Bool)> { get }
    var outputIsAllowToTap: BehaviorRelay<Bool> { get }
}

protocol ChooseHabbyViewModelType {
    var input: ChooseHabbyInput { get }
    var output: ChooseHabbyOutput { get }
}

class ChooseHabbyViewModel: ChooseHabbyInput, ChooseHabbyOutput, ChooseHabbyViewModelType {
    
    private let disposeBag = DisposeBag()
    
    //MARK: - input
    var inputCellForRowAt: RxRelay.BehaviorRelay<IndexPath> = BehaviorRelay(value: [0, 0])
    var didSelectedRowAt: RxRelay.BehaviorRelay<IndexPath> = BehaviorRelay(value: [0, 0])
    var tapAction: RxSwift.PublishSubject<Void> = PublishSubject()
    
    //MARK: - output
    var outputCellForRowAt: BehaviorRelay<(HabbyItem?, Bool)> = BehaviorRelay(value: (nil, false))
    var outputIsAllowToTap: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private var storeHabby: Set<HabbyItem> = []
    
    private var storeHabbyObservable: Observable<Set<HabbyItem>> {
        return Observable.just(storeHabby)
    }
    
    //MARK: -input/output
    var input: ChooseHabbyInput { self }
    var output: ChooseHabbyOutput { self }
    
    init() {
        inputCellForRowAt
            .subscribe(onNext: { indexPath in
                let habby = self.cellForRowAt(indexPath: indexPath).habby
                let isSelected = self.cellForRowAt(indexPath: indexPath).isSelected
                print("habby:\(habby)")
                print("isSelected:\(isSelected)")
                self.outputCellForRowAt.accept((habby, isSelected))
        })
        .disposed(by: disposeBag)
            
        didSelectedRowAt
            .subscribe(onNext: { indexPath in
                self.didSelectedRowAt(indexPath: indexPath)
        })
        .disposed(by: disposeBag)
        
        tapAction
            .subscribe(onNext: {
                self.uploadHabbyDataToFireBase()
        })
        .disposed(by: disposeBag)
        
    }

    private func didSelectedRowAt(indexPath: IndexPath) {
        if storeHabby.isEmpty {
            storeHabby.insert(HabbyItem(rawValue: indexPath.row)!)
        } else if storeHabby.contains(HabbyItem(rawValue: indexPath.row)!){
            storeHabby.remove(HabbyItem(rawValue: indexPath.row)!)
        } else if storeHabby.count > 1{
            outputIsAllowToTap.accept(true)
        }
    }
    
    private func cellForRowAt(indexPath: IndexPath) -> (habby: HabbyItem?, isSelected: Bool) {
        let selectedHabby = HabbyItem(rawValue: indexPath.row)
        let isSelected = storeHabby.contains(selectedHabby!)
        print("selectedHabby:\(selectedHabby)")
        return (selectedHabby, isSelected)
    }
    
    private func uploadHabbyDataToFireBase() {
        print("uploadHabby")
        
    }
    
    private func saveToLocal() {
        
    }
}
