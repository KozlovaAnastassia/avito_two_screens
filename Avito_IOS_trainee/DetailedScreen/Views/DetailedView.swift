//
//  DetailedView.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 29.08.2023.
//

import Foundation
import UIKit

protocol DetailedViewDelegate: AnyObject {
    func getDataForCell() -> DetailedItemModel?
    func getviewForHeaderInSection() -> String
}

class DetailedView: UIView {
 
    private var state: State?
    private let cellId = "cellId2"
    private let headerId = "headerId"
    weak var delegate: DetailedViewDelegate?
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private lazy var errorLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.text = "Loading error, serverce problem"
       label.numberOfLines = 0
       label.textColor = .black
       label.isHidden = true
       return label
   }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = true
        return indicator
    }()
    
//MARK: -> init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        addSubviews()
        setTableView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(errorLabel)
        addSubview(activityIndicator)
        addSubview(tableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DetailedCustomCell.self, forCellReuseIdentifier: cellId)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }

    func failureScreeen() {
        tableView.isHidden = true
        errorLabel.isHidden = false
    }
    
    func loadingScreeen() {
        tableView.isHidden = true
        activityIndicator.isHidden = false
    }
    
    func loadedScreeen() {
        tableView.isHidden = false
        activityIndicator.isHidden = true
        errorLabel.isHidden = true
    }
}

extension DetailedView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? DetailedCustomCell
        else { return UITableViewCell() }
        
        if let viewModel  = delegate?.getDataForCell() {
            cell.configure(viewModel)
        }
        return cell
   }
   
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let header = DetailedCustomHeader()
       if let image  = delegate?.getviewForHeaderInSection() {
           header.config(image, id: delegate?.getDataForCell()?.id ?? String())
       }
       return header
   }
   
    func tableView(_ tableView: UITableView,
              heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 300
   }
   
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 430
   }
   
}

