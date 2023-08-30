//
//  CustomCell.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 28.08.2023.
//

import Foundation
import UIKit

final class CustomCell: UICollectionViewCell {
    
    private lazy var itemImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var itemPrice: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
         label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var itemLocation: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
  
    
    private lazy var itemCreatedDate: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(itemImageView)
        stack.addArrangedSubview(itemTitle)
        stack.addArrangedSubview(itemPrice)
        stack.addArrangedSubview(itemLocation)
        stack.addArrangedSubview(itemCreatedDate)
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraints() {
        addSubview(verticalStack)
        verticalStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func configure(_ viewModel: ItemModel) {
        itemImageView.image = nil
        itemImageView.imageFromServerURL(viewModel.image_url)
        itemTitle.text = viewModel.title
        itemPrice.text = viewModel.price
        itemLocation.text = viewModel.location
        itemCreatedDate.text = viewModel.created_date
    }

}
