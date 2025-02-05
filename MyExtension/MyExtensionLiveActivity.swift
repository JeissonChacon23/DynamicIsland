//
//  MyExtensionLiveActivity.swift
//  MyExtension
//
//  Created by Jeisson Chacón on 17/09/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

@main
struct MyExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DeliveryAttributes.self) { context in
            // Lock screen/banner UI goes here
            HStack{
                Image(systemName: "box.truck.badge.clock.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.indigo)
                    .padding(.leading, 12)
                
                VStack(alignment: .leading){
                    Text(context.state.productName).bold()
                    Text(" esta ")
                    + Text(context.state.deliveryStatus.rawValue).bold()
                }
                Spacer()
                VStack(alignment: .center){
                    Text("Hora de entrega")
                    Text(context.state.estimatedArrivalData)
                }
                .padding(.trailing, 12)
            }
            
            
            /*
             VStack {
                 Text("Hello")
             }
             .activityBackgroundTint(Color.cyan)
             .activitySystemActionForegroundColor(Color.black)
             */

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "box.truck.badge.clock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.leading, 12)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.productName)
                        .bold()
                        .multilineTextAlignment(.center)
                }
                DynamicIslandExpandedRegion(.center){
                    Text("Paquete: \(context.state.deliveryStatus.rawValue)")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Button{
                        
                    }label: {
                        Label("Cancelar pedido", systemImage: "xmark.circle.fill")
                    }
                }
            } compactLeading: {
                HStack{
                    Image(systemName: "box.truck.badge.clock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text(context.state.productName)
                }
            } compactTrailing: {
                Text(context.state.deliveryStatus.rawValue)
            } minimal: {
                Image(systemName: "box.truck.badge.clock.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.green)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
            
            
            
            
            
            
            /*
             DynamicIsland{
                 DynamicIslandExpandedRegion(.leading){
                     Image(systemName: "box.truck.badge.clock.fill")
                         .resizable()
                         .scaledToFit()
                         .frame(width: 20, height: 20)
                         .padding(.leading, 12)
                 }
                 DynamicIslandExpandedRegion(.trailing){
                     Text(context.state.productName)
                         .bold()
                         .multilineTextAlignment(.center)
                 }
                 DynamicIslandExpandedRegion(.center){
                     Text("Paquete: \(context.state.deliveryStatus.rawValue)")
                 }
                 DynamicIslandExpandedRegion(.bottom){
                     Button{
                         
                     }label: {
                         Label("Cancelar pedido", systemImage: "xmark.circle.fill")
                     }
                 }
             } compactLeading: {
                 HStack{
                     Image(systemName: "box.truck.badge.clock.fill")
                         .resizable()
                         .scaledToFit()
                         .frame(width: 20, height: 20)
                     Text(context.state.productName)
                 }
             } compactTrailing: {
                 Text(context.state.deliveryStatus.rawValue)
             } minimal: {
                 Image(systemName: "box.truck.badge.clock.fill")
                     .resizable()
                     .scaledToFit()
                     .foregroundColor(.green)
             }
             
             */
        }
    }
}

struct MyExtensionLiveActivity_Previews: PreviewProvider{
    static let attributes = DeliveryAttributes()
    static let contentState = DeliveryAttributes.ContentState(deliveryStatus: .sent, productName: "T-Shirt", estimatedArrivalData: "21:00")
    
    static var previews: some View{
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Island Compact")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Island Expand")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal")
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
