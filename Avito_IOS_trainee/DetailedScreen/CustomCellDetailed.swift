//
//  CustomCellDetailed.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 31.08.2023.
//

import Foundation
import UIKit

class CustomCellDetailed: UITableViewCell {
    
    private var itemDetailedModel =  [ModelItemDetailed]()
   
    private lazy var itemTitle: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
       label.numberOfLines = 0
       label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
       label.textColor = .black
       return label
   }()
   
    private lazy var itemPrice: UILabel = {
       let label = UILabel()
       label.textAlignment = .left
       label.numberOfLines = 0
       label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
       label.textColor = .black
       return label
   }()
   
    private lazy var itemLocation: UILabel = {
       let label = UILabel()
       label.textAlignment = .left
       label.numberOfLines = 0
       label.textColor = .black
       return label
   }()
 
    private lazy var itemCreatedDate: UILabel = {
       let label = UILabel()
       label.textAlignment = .left
       label.numberOfLines = 0
       label.textColor = .black
       return label
   }()
    
    private lazy var itemDescription: UILabel = {
       let label = UILabel()
       label.textAlignment = .left
       label.numberOfLines = 0
       label.textColor = .black
       return label
   }()
    
    private lazy var personEmail: UILabel = {
       let label = UILabel()
       label.textAlignment = .left
       label.numberOfLines = 0
       label.textColor = .black
       return label
   }()
    
    private lazy var personPhoneNumber: UILabel = {
       let label = UILabel()
       label.textAlignment = .left
       label.numberOfLines = 0
       label.textColor = .black
       return label
   }()
    
    private lazy var personAddress: UILabel = {
       let label = UILabel()
       label.textAlignment = .left
       label.numberOfLines = 0
       label.textColor = .black
       return label
   }()
   
   private lazy var verticalStack: UIStackView = {
       let stack = UIStackView()
       stack.alignment = .leading
       stack.axis = .vertical
       stack.translatesAutoresizingMaskIntoConstraints = false
       stack.spacing = 5
       stack.addArrangedSubview(itemTitle)
       stack.addArrangedSubview(itemPrice)
       stack.addArrangedSubview(itemLocation)
       stack.addArrangedSubview(itemCreatedDate)
       stack.addArrangedSubview(personEmail)
       stack.addArrangedSubview(personPhoneNumber)
       stack.addArrangedSubview(personAddress)
       return stack
   }()
   
//MARK: ->  init
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       addViews()
       setConstraints()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
//MARK: ->  private func
   private func addViews() {
       addSubview(verticalStack)
   }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
         verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
         verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
         verticalStack.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
//MARK: -> fileprivate func
     func configure(_ viewModel: ModelItemDetailed) {
         itemTitle.text = viewModel.title
         itemPrice.text = viewModel.price
         itemLocation.text = viewModel.location
         itemCreatedDate.text = viewModel.created_date
         itemDescription.text = viewModel.description
         personEmail.text = viewModel.email
         personAddress.text = viewModel.address
         personPhoneNumber.text = viewModel.phone_number
    }
}

