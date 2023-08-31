//
//  DetailedView.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 29.08.2023.
//

import Foundation
import UIKit

class ViewDetailed: UIView, UITableViewDelegate, UITableViewDataSource {
    
 
    private var state: State?
    private var itemModel: ModelItemDetailed?
    private let cellId = "cellId2"
    private let headerId = "headerId"
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedSectionHeaderHeight = 200
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
        
        addSubview(errorLabel)
        addSubview(activityIndicator)
        addSubview(tableView)
        setConstraints()
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: -> private func
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
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

    func setView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCellDetailed.self, forCellReuseIdentifier: cellId)
       
    }
    
    func sentData(data: ModelItemDetailed) {
        self.itemModel = data
        tableView.reloadData()
    }
   
//MARK: ->  tableView func
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId2", for: indexPath) as? CustomCellDetailed
         else { return UITableViewCell() }
         
         if let viewModel  = itemModel {
             cell.configure(viewModel)
         }
         return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CustomHeaderDetailed()
        
        if let image  = itemModel?.image_url {
            header.config(image)
        }
        return header
    }
    
     func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }
    
//MARK: -> fileprivate func
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


