//
//  ViewControllerDetailed.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 30.08.2023.
//

import Foundation
import UIKit

class DetailedViewController: UIViewController, DetailedViewDelegate {
    
    private let detailedView = DetailedView()
    private var viewModel: DetailedViewModelProtocol
    private var itemID = String()
    
    private var state: State = .plain {
        didSet {
            switch state  {
            case .failure: detailedView.failureScreeen()
            case .loading: detailedView.loadingScreeen()
            case .loaded:  detailedView.loadedScreeen()
            default:  detailedView.loadingScreeen()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        view = detailedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        state = .loading
        detailedView.delegate = self
        let urlString =
        "https://www.avito.st/s/interns-ios/details/\(itemID).json"
        
        viewModel.request(urlString: urlString)
        
        viewModel.result = { [weak self] in
            self?.state = .loaded
            self?.detailedView.reloadTableView()
        }
        viewModel.error = {
            self.state = .failure
        }
    }
 
    init?(viewModel: DetailedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getID(id: String) {
        self.itemID = id 
    }
    
    func getDataForCell() -> DetailedItemModel? {
        viewModel.getDataForCell()
    }
    
    func getviewForHeaderInSection() -> String {
        viewModel.getviewForHeaderInSection()
    }
}
