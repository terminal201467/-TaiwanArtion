//
//  NearViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/16.
//

import Foundation

protocol NearViewModelInput {
    //篩選Action：營業中、最高評價、距離最近
    
    //input附近展覽館
    
    //input附近展覽
    
    //input搜尋關鍵字（展覽館、展覽）
    
    //確認搜尋ActionSubject
    
    //清除搜尋紀錄ActionSubject
    
    //清除單一搜尋紀錄ActionSubject
    
    //紀錄搜尋紀錄ActionSubject
    
    //取得現在位置ActionSubject
    
    //查看位置ActionSubject
    
    //查看展覽館展覽ActionSubject
    
    //向右滑動展覽館ActionSubject
    
    //向左滑動展覽館ActionSubject
}

protocol NearViewModelOutput {
    
    //篩選後的（展覽館、展覽）資料
    
    
}

protocol NearInputOutputType {
    
    var input: NearViewModelInput { get }
    var output: NearViewModelOutput { get }
    
}


class NearViewModel {
    
    init() {
        
    }
    
    
}
