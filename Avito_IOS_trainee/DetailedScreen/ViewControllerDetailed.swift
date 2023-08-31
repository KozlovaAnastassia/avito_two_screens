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
    
//MARK: -> loadView
    override func loadView() {
        super.loadView()
        view = myView
    }
    
//MARK: -> viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        state = .loading
        let urlString =
        "https://www.avito.st/s/interns-ios/details/\(itemID).json"
        
        viewModel.request(urlString: urlString)
        
        viewModel.result = { data in
            self.state = .loaded
            self.myView.sentData(data: data)
            
        }
        viewModel.error = {
            self.state = .failure
        }
    }
 
//MARK: -> init
    init?(viewModel: ViewModelDetailedProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: -> fileprivate func
    func getID(id: String) {
        self.itemID = id 
    }
}
