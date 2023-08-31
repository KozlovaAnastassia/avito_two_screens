//
//  ViewModelDetailed.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 30.08.2023.
//

import Foundation
import UIKit

protocol ViewModelDetailedProtocol {
    var data: ModelItemDetailed? {get}
    var result: ((ModelItemDetailed) -> Void)? {get set}
    var error: (() -> Void)? {get set}
    var networkService: NetworkServiceProtocol {get set}
    func request(urlString: String)
}

final class ViewModelDetailed: ViewModelDetailedProtocol  {

    var networkService: NetworkServiceProtocol
    var data: ModelItemDetailed?
    var result: ((ModelItemDetailed) -> Void)?
    var error: (() -> Void)?
    
    init ( networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func request(urlString: String){
        networkService.getDataItemDetailed(urlString: urlString) {  result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.data = response
                    self.result?(response)
                case .failure(_):
                    self.error?()
                }
            }
        }
    }
}
