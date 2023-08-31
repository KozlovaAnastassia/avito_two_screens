//
//  ViewModel.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 29.08.2023.
//

import Foundation
import UIKit

protocol MainViewModelProtocol {
    var result: (() -> Void)? {get set}
    var error: (() -> Void)? {get set}
    var numberOfRowsInSection: Int {get}
    
    func didSelectedCell(_ indexPath: IndexPath) -> DetailedViewController
    func requestt(urlString: String)
    func getIncomeForCell(indexPath: IndexPath) -> ItemModel
}

final class MainViewModel: MainViewModelProtocol  {

    private var networkService: NetworkServiceProtocol
    private var data: AdvertisementModel?
    var numberOfRowsInSection: Int {return self.data?.advertisements.count ?? Int()}
    var result: (() -> Void)?
    var error: (() -> Void)?
    
    init ( networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func didSelectedCell(_ indexPath: IndexPath) -> DetailedViewController {
        let vc2 = DetailedViewController(viewModel: DetailedViewModel(networkService: networkService))
        let id = data?.advertisements[indexPath.row].id ?? String()
        vc2?.getID(id: id)
        return vc2!
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
    
    func getIncomeForCell(indexPath: IndexPath) -> ItemModel {
        (data?.advertisements[indexPath.row])!
    }
}
