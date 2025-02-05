//
//  DeliveryActivityUseCase.swift
//  DynamicIsland
//
//  Created by Jeisson Chacón on 17/09/24.
//

import Foundation
import ActivityKit

final class DeliveryActivityUseCase{
    static func startActivity(deliveryStatus: DeliveryStatus, productName: String, estimatedArrivalData: String) throws -> String{
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            return ""
        }
        let initialState = DeliveryAttributes.ContentState(deliveryStatus: deliveryStatus,
                                                           productName: productName,
                                                           estimatedArrivalData: estimatedArrivalData)
        let futureData: Date = .now + 3600
        let activityContent = ActivityContent(state: initialState, staleDate: futureData)
        let attributes = DeliveryAttributes()
        do{
            let activity = try Activity.request(attributes: attributes, content: activityContent)
            return activity.id
        }catch{
            throw error
        }
    }
    
    static func updateActivity(activityIdentifier: String,
                               newDeliveryStatus: DeliveryStatus,
                               productName: String,
                               estimatedArrivalDate: String) async{
        let updateContentState = DeliveryAttributes.ContentState(deliveryStatus: newDeliveryStatus, productName: productName, estimatedArrivalData: estimatedArrivalDate)
        let activity = Activity<DeliveryAttributes>.activities.first(where: { $0.id == activityIdentifier})
        let activityContent = ActivityContent(state: updateContentState, staleDate: .now + 3600)
        await activity?.update(activityContent)
    }
    
    static func endActivity(withActivityIdentifier activityIdentifier: String) async {
        let value = Activity<DeliveryAttributes>.activities.first(where: {$0.id == activityIdentifier})
        await value?.end(nil)
    }
}
