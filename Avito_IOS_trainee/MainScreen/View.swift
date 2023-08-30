//
//  View.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 28.08.2023.
//

import Foundation
import UIKit

protocol ViewDelegate: AnyObject {
    func transit(indexPath: IndexPath)
}

class View: UIView,  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: ViewDelegate?
    private var state: State?
    private var itemModel =  [ItemModel]()
    private let cellId = "cellId"
    
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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(errorLabel)
        addSubview(activityIndicator)
        addSubview(collectionView)
        setConstraints()
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 700),
            collectionView.widthAnchor.constraint(equalToConstant: 350)
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func failureScreeen() {
        collectionView.isHidden = true
        errorLabel.isHidden = false
    }
    
    func loadingScreeen() {
        collectionView.isHidden = true
        activityIndicator.isHidden = false
    }
    
    func loadedScreeen() {
        collectionView.isHidden = false
        activityIndicator.isHidden = true
        errorLabel.isHidden = true
    }
    
    func sentData(data: [ItemModel]) {
        self.itemModel = data
        collectionView.reloadData()
    }
    
//MARK: -> collectionView func
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? CustomCell
        else { return UICollectionViewCell() }
    
        let viewModel  = itemModel[indexPath.row]
        cell.configure(viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: frame.width/2.5, height: 200)
   }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.transit(indexPath: indexPath)
    }
}
