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
    var selectedNewPhoto: PublishSubject<Data> { get }
    var savePhoto: PublishSubject<Void> { get }
    //輸入暫存的圖片檔案Data
}

protocol SettingHeadViewModelOutput {
    var headImagesObservable: BehaviorRelay<[Any]> { get }
    var isAllowSavePhoto: BehaviorRelay<Bool> { get }
    var storeHead: BehaviorRelay<Any?> { get }
    var isCurrentSelectedIndex: BehaviorRelay<Bool> { get }
}

protocol SettingHeadViewModelType {
    var input: SettingHeadViewModelInput { get }
    var output: SettingHeadViewModelOutput { get }
}

class SettingHeadViewModel: SettingHeadViewModelInput, SettingHeadViewModelOutput, SettingHeadViewModelType {
    
    private let disposeBag = DisposeBag()
    
    //Input
    var selectedHeadImageIndex: PublishSubject<IndexPath> = PublishSubject()
    var savePhoto: PublishSubject<Void> = PublishSubject()
    var selectedNewPhoto: PublishSubject<Data> = PublishSubject()
    
    //Output
    var storeHead: BehaviorRelay<Any?> = BehaviorRelay(value: nil)
    var isAllowSavePhoto: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var headImagesObservable: BehaviorRelay<[Any]> { BehaviorRelay(value: defaultPhotos) }
    var isCurrentSelectedIndex: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private var currentPhotoIndexPath: IndexPath? = nil
    
    private let defaultPhotos: [Any] = ["takePhoto", "bigHead01", "bigHead02", "bigHead03", "bigHead04", "bigHead05", "bigHead06", "bigHead07", "bigHead08", "bigHead09"]
    
    //MARK: - input、output
    var input: SettingHeadViewModelInput { self }
    var output: SettingHeadViewModelOutput { self }
    
    init() {
        //input
        selectedHeadImageIndex
            .subscribe(onNext: { indexPath in
                self.storeHead.accept(self.headImagesObservable.value[indexPath.row])
                self.isCurrentSelectedIndex.accept(self.currentPhotoIndexPath == indexPath)
            })
            .disposed(by: disposeBag)
        
        selectedNewPhoto
            .subscribe(onNext: { image in
                self.storeHead.accept(image)
            })
            .disposed(by: disposeBag)
        
        savePhoto.subscribe(onNext: {
            //這邊儲存進本地端的照片
            print("savePhoto")
            //存進去Firebase
        })
        .disposed(by: disposeBag)
        self.isAllowSelected()
    }
    
    private func isAllowSelected() {
        isAllowSavePhoto.accept(headImagesObservable.value.isEmpty ? true : false)
    }
}
