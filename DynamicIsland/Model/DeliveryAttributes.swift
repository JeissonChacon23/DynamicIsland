//
//  DeliveryAttributes.swift
//  DynamicIsland
//
//  Created by Jeisson Chacón on 17/09/24.
//

import Foundation
import ActivityKit

struct DeliveryAttributes: ActivityAttributes{
    public struct ContentState: Codable, Hashable{
        var deliveryStatus: DeliveryStatus
        var productName: String
        var estimatedArrivalData: String
    }
}
