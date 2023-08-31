//
//  ViewModelDetailed.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 30.08.2023.
//

import UIKit

protocol DetailedViewModelProtocol {
    var result: (() -> Void)? {get set}
    var error: (() -> Void)? {get set}
    
    func request(urlString: String)
    func getDataForCell() -> DetailedItemModel?
    func getviewForHeaderInSection() -> String
}

final class DetailedViewModel: DetailedViewModelProtocol  {
    
    private var data: DetailedItemModel?
    private var networkService: NetworkServiceProtocol
    var result: (() -> Void)?
    var error: (() -> Void)?
    
    init (networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func request(urlString: String){
        networkService.getDataItemDetailed(urlString: urlString) {  result in
            DispatchQueue.main.async {
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
    
    func getDataForCell() -> DetailedItemModel? {
        data
    }
    
    func getviewForHeaderInSection() -> String {
        data?.image_url ?? String()
    }
}

