//
//  ViewController.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 28.08.2023.
//

import UIKit

class MainViewController: UIViewController, ViewDelegate {
    
    private let mainView = MainView()
    private var viewModel: MainViewModelProtocol
    private let urlString =
    "https://www.avito.st/s/interns-ios/main-page.json"
    
    private var state: State = .plain {
        didSet {
            switch state  {
            case .failure: mainView.failureScreeen()
            case .loading: mainView.loadingScreeen()
            case .loaded:  mainView.loadedScreeen()
            default:  mainView.loadingScreeen()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .loading
        viewModel.requestt(urlString: urlString)
        
        viewModel.result = {  [weak self] in
            self?.state = .loaded
            self?.mainView.reloadCollectionView()
        }
        
        viewModel.error = {
            self.state = .failure
        }
        mainView.delegate = self
    }
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getIncomeForCell(indexPath: IndexPath) -> ItemModel {
        viewModel.getIncomeForCell(indexPath: indexPath)
    }
    
    func getNumbersOfSection() -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func pushToDetailController(indexPath: IndexPath) {
        let vc2 = viewModel.didSelectedCell(indexPath)
        navigationController?.pushViewController(vc2, animated: true)
    }
    
  
}

