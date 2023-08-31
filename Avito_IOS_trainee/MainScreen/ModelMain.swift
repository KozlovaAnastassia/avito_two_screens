//
//  Model.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 28.08.2023.
//

import Foundation
import UIKit


struct Advertisement: Codable {
    let advertisements: [ItemModel]
}

struct ItemModel: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let image_url: String
    let created_date: String
}

