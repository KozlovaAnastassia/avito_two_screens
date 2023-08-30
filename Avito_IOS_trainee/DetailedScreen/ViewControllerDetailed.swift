//
//  ViewControllerDetailed.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 30.08.2023.
//

import Foundation
import UIKit

class ViewControllerDetailed: UIViewController {
    
    private let myView = ViewDetailed()
    private var viewModel: ViewModelDetailedProtocol
    private var itemID = String()
    
    private var state: State = .plain {
        didSet {
            switch state  {
            case .failure: myView.failureScreeen()
            case .loading: myView.loadingScreeen()
            case .loaded:  myView.loadedScreeen()
            default:  myView.loadingScreeen()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        state = .loading
        let urlString =
        "https://www.avito.st/s/interns-ios/details/\(itemID).json"
        
        viewModel.request(urlString: urlString)
        
        viewModel.result = {
            self.myView.sentData(
            image: self.viewModel.data?.image_url ?? String(),
            title: self.viewModel.data?.title ?? String(),
            price: self.viewModel.data?.price ?? String(),
            location: self.viewModel.data?.location ?? String(),
            createdDate: self.viewModel.data?.created_date ?? String(),
            description: self.viewModel.data?.description ?? String(),
            email: self.viewModel.data?.email ?? String(),
            address: self.viewModel.data?.address ?? String(),
            phoneNumber: self.viewModel.data?.phone_number ?? String()
        )
            self.state = .loaded
        }
        
        viewModel.error = {
            self.state = .failure
        }
    }

    override func loadView() {
        super.loadView()
        view = myView
    }
    
    init?(viewModel: ViewModelDetailedProtocol) {
        self.viewModel = viewModel
        self.viewModel.result = {}
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getID(id: String) {
        self.itemID = id 
    }
    
}
