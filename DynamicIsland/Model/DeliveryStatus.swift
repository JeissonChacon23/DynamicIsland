//
//  DeliveryStatus.swift
//  DynamicIsland
//
//  Created by Jeisson Chacón on 17/09/24.
//

import Foundation

enum DeliveryStatus: String, Codable{
    case pending = ""
    case sent = "Enviado"
    case inTransit = "En Reparto"
    case delivered = "Entregado"
}
