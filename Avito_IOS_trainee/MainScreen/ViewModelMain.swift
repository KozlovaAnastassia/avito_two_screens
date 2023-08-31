//
//  ViewModel.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 29.08.2023.
//

import Foundation
import UIKit

protocol ViewModelMainProtocol {
    var data: Advertisement? {get}
    var result: (() -> Void)? {get set}
    var error: (() -> Void)? {get set}
    var numberOfRowsInSection: Int {get}
    var networkService: NetworkServiceProtocol {get set}
    
    func didSelectedCell(_ indexPath: IndexPath) -> ViewControllerDetailed
    func requestt(urlString: String)
}

final class ViewModelMain: ViewModelMainProtocol  {

    var networkService: NetworkServiceProtocol
    var data: Advertisement?
    var numberOfRowsInSection: Int {return self.data?.advertisements.count   ?? 0 }
    var result: (() -> Void)?
    var error: (() -> Void)?
    
    init ( networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func didSelectedCell(_ indexPath: IndexPath) -> ViewControllerDetailed {
        let vc2 = ViewControllerDetailed(viewModel: ViewModelDetailed(networkService: networkService))
        let id = data?.advertisements[indexPath.row].id ?? String()
        vc2?.getID(id: id)
        return vc2 as! ViewControllerDetailed
    }
    
    func requestt(urlString: String){
        networkService.getDataAdvertisement(urlString: urlString) {  result in
            switch result {
            case .success(let response):
                self.data = response
                self.result?()
            case .failure(_):
                self.error?()
            }
        }
    }
}
