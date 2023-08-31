//
//  ViewController.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 28.08.2023.
//

import UIKit

class ViewControllerMain: UIViewController, ViewDelegate {
    
    private let myView = View()
    private var viewModel: ViewModelMainProtocol
    private let urlString =
    "https://www.avito.st/s/interns-ios/main-page.json"
    
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
//MARK: ->  loadView
    override func loadView() {
        super.loadView()
        view = myView
    }
        
//MARK: ->  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .loading
        viewModel.requestt(urlString: urlString)
        
        viewModel.result = {
            self.myView.sentData(data: self.viewModel.data?.advertisements  ?? [])
            self.state = .loaded
        }
        
        viewModel.error = {
            self.state = .failure
        }
        myView.delegate = self
    }
    
//MARK: ->  init
    init(viewModel: ViewModelMainProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: -> fileprivate func
    func transit(indexPath: IndexPath) {
        let vc2 = viewModel.didSelectedCell(indexPath)
        navigationController?.pushViewController(vc2, animated: true)
    }
}

