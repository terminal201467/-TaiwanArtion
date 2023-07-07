//
//  SettingHeadViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/7.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

protocol SettingHeadViewModelInput {
    var selectedHeadImageIndex: PublishSubject<IndexPath> { get }
    var selectedNewPhoto: PublishSubject<String> { get }
    var savePhoto: PublishSubject<Void> { get }
    //輸入暫存的圖片檔案Data
    var storeHead: BehaviorRelay<String> { get }
}

protocol SettingHeadViewModelOutput {
    var headImagesObservable: BehaviorRelay<[String]> { get }
    var choosePhotoByLocalImage: PublishSubject<Void> { get }
    var isAllowSavePhoto: BehaviorRelay<Bool> { get }
    
    //輸出選擇的圖片檔
    var selectedToBeHead: BehaviorRelay<String> { get }
    var selectedIndexPath: PublishSubject<IndexPath> { get }
}

protocol SettingHeadViewModelType {
    var input: SettingHeadViewModelInput { get }
    var output: SettingHeadViewModelOutput { get }
}

class SettingHeadViewModel: SettingHeadViewModelInput, SettingHeadViewModelOutput, SettingHeadViewModelType {

    var selectedNewPhoto: PublishSubject<String>
    var storeHead: BehaviorRelay<String>
    var selectedToBeHead: BehaviorRelay<String>
    var selectedIndexPath: PublishSubject<IndexPath>
    
    private let disposeBag = DisposeBag()
    
    //Input
    var selectedHeadImageIndex: PublishSubject<IndexPath> = PublishSubject()
    var savePhoto: PublishSubject<Void> = PublishSubject()
    
    //Output
    var isAllowSavePhoto: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var headImagesObservable: BehaviorRelay<[String]> { BehaviorRelay(value: defaultPhotos) }
    var choosePhotoByLocalImage: PublishSubject<Void> = PublishSubject()
    
    private let defaultPhotos: [String] = ["bigHead01", "bigHead02", "bigHead03", "bigHead04", "bigHead05", "bigHead06", "bigHead07", "bigHead08", "bigHead09"]
    
    //MARK: - input、output
    var input: SettingHeadViewModelInput { self }
    var output: SettingHeadViewModelOutput { self }
    
    init() {
        //input
        selectedHeadImageIndex
            .subscribe(onNext: { indexPath in
                
            })
            .disposed(by: disposeBag)
        
        selectedNewPhoto
            .subscribe(onNext: { imageString in
                self.headImagesObservable.accept([imageString])
                self.isAllowSelected()
            })
            .disposed(by: disposeBag)
        
        savePhoto.subscribe(onNext: {
            
        })
        .disposed(by: disposeBag)
        //output
        
    }
    
    func isAllowSelected() {
        isAllowSavePhoto.accept(headImagesObservable.value.isEmpty ? true : false)
    }
}
