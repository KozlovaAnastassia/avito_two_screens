//
//  CustomCell.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 28.08.2023.
//

import Foundation
import UIKit

final class MainCustomCell: UICollectionViewCell {
    
    private lazy var itemImageView: UIImageView = {
        let image = UIImageView()
         image.translatesAutoresizingMaskIntoConstraints = false
         image.widthAnchor.constraint(equalToConstant: 180).isActive = true
         image.heightAnchor.constraint(equalToConstant: 200).isActive = true
         image.layer.cornerRadius = 7
         image.clipsToBounds = true
        return image
    }()
    
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var itemPrice: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var itemLocation: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
  
    
    private lazy var itemCreatedDate: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(itemImageView)
        stack.addArrangedSubview(itemTitle)
        stack.addArrangedSubview(itemPrice)
        stack.addArrangedSubview(itemLocation)
        stack.addArrangedSubview(itemCreatedDate)
        return stack
    }()
    
//MARK: -> init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
        verticalStack.topAnchor.constraint(equalTo: topAnchor),
        verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
        verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    private func addViews() {
        addSubview(verticalStack)
    }

    
    func configure(_ viewModel: ItemModel) {
        itemImageView.image = nil
        itemImageView.loadImage(withURL: viewModel.image_url, placeholder: UIImage(named: "placeholder"), id: viewModel.id)
        itemTitle.text = viewModel.title
        itemPrice.text = viewModel.price
        itemLocation.text = viewModel.location
        itemCreatedDate.text = viewModel.created_date
    }
    
}
