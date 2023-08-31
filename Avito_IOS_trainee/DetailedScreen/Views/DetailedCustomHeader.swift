//
//  CustomHeaderDetailed.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 31.08.2023.
//

import Foundation
import UIKit

class DetailedCustomHeader: UITableViewHeaderFooterView {
    
    private lazy var itemImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.contentMode = .scaleAspectFill
       return imageView
   }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews() {
        addSubview(itemImageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemImageView.topAnchor.constraint(equalTo: topAnchor),
            itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func config(_ image: String, id: String) {
        itemImageView.loadImage(withURL: image, placeholder: UIImage(named: "placeholder"), id: id)
     }
}
