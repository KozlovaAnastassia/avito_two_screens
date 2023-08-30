//
//  DetailedView.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 29.08.2023.
//

import Foundation
import UIKit

class ViewDetailed: UIView {
    
    private var itemDetailedModel =  [ItemDetailedModel]()
    
    private lazy var itemImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
       
       return imageView
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
    
    private lazy var itemDescription: UILabel = {
       let label = UILabel()
       label.textAlignment = .center
       label.numberOfLines = 0
       label.textColor = .black
       return label
   }()
    
    private lazy var personEmail: UILabel = {
       let label = UILabel()
       label.textAlignment = .center
       label.numberOfLines = 0
       label.textColor = .black
       return label
   }()
    
    private lazy var personPhoneNumber: UILabel = {
       let label = UILabel()
       label.textAlignment = .center
       label.numberOfLines = 0
       label.textColor = .black
       return label
   }()
    
    private lazy var personAddress: UILabel = {
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
       stack.addArrangedSubview(personEmail)
       stack.addArrangedSubview(personPhoneNumber)
       stack.addArrangedSubview(personAddress)
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
    
    func failureScreeen() {
        verticalStack.isHidden = true
        errorLabel.isHidden = false
    }
    
    func loadingScreeen() {
        verticalStack.isHidden = true
        activityIndicator.isHidden = false
    }
    
    func loadedScreeen() {
        verticalStack.isHidden = false
        activityIndicator.isHidden = true
        errorLabel.isHidden = true
    }
   
    func sentData(image: String, title: String, price: String, location: String, createdDate: String, description: String, email: String, address: String, phoneNumber: String ) {
        self.itemImageView.imageFromServerURL(image)
        self.itemTitle.text = title
        self.itemPrice.text = price
        self.itemLocation.text = location
        self.itemCreatedDate.text = createdDate
        self.itemDescription.text = description
        self.personEmail.text = email
        self.personAddress.text = address
        self.personPhoneNumber.text = phoneNumber
    }

}


