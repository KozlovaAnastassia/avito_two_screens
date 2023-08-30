//
//  DetailedModel.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 29.08.2023.
//

import Foundation
import UIKit


struct ItemDetailedModel: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let image_url: String
    let created_date: String
    let description: String
    let email: String
    let phone_number: String
    let address: String
}
