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
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        return collectionView
    }()
    
//MARK: ->  init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addViews()
        setConstraints()
        setcollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
//MARK: ->  private func
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10)
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

    private func setcollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCellMain.self, forCellWithReuseIdentifier: cellId)
    }
    private func addViews() {
        addSubview(errorLabel)
        addSubview(activityIndicator)
        addSubview(collectionView)
    }
//MARK: -> fileprivate func
    
    func failureScreeen() {
        collectionView.isHidden = true
        errorLabel.isHidden = false
    }
    
    func loadingScreeen() {
        collectionView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func loadedScreeen() {
        collectionView.isHidden = false
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? CustomCellMain
        else { return UICollectionViewCell() }
        
        cell.itemImageView.image = nil
        let viewModel  = itemModel[indexPath.row]
        cell.configure(viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width - 30) / 2
            return CGSize(width: width, height: width + 120)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.transit(indexPath: indexPath)
    }
}
