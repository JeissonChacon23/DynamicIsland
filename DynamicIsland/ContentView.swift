//
//  ContentView.swift
//  DynamicIsland
//
//  Created by Jeisson Chacón on 17/09/24.
//

import SwiftUI

struct ContentView: View {
    @State var producName: String = "T-Shirt"
    @State var currentDeliverystate: DeliveryStatus = .pending
    @State var activityIdentifier: String = ""
    
    var body: some View {
        VStack {
            Image("miguel")
                .resizable()
                .frame(width: 20, height: 20)
            
            
            
            AsyncImage(url: .init(string: "https://ww2.ufps.edu.co/public/imagenes/template/header/pendon-emisora.png")){ image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }
            Text(producName)
                .font(.system(.largeTitle))
            Text(currentDeliverystate.rawValue)
                .font(.system(.body))
            Button{
                buyProduct()
            }label: {
                Label("Comprar", systemImage: "cart.fill")
            }
                .buttonStyle(.borderedProminent)
                .padding(.top, 32)
            
            Button{
                changeState()
            }label: {
                Label("cambiar estado del producto", systemImage: "arrow.clockwise")
            }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .padding(.top, 32)
            
            Button{
                removeState()
            }label: {
                Label("Eliminar Informacion Dynamic Island", systemImage: "trash.fill")
            }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .padding(.top, 32)
        }
        .padding()
    }
    
    func buyProduct(){
        currentDeliverystate = .sent
        do{
            activityIdentifier = try DeliveryActivityUseCase.startActivity(deliveryStatus: currentDeliverystate, productName: producName, estimatedArrivalData: "21:00")
        }catch{
            print(error.localizedDescription)
        }
    }
    func changeState(){
        Task{
            await DeliveryActivityUseCase.updateActivity(activityIdentifier: activityIdentifier, newDeliveryStatus: currentDeliverystate, productName: producName, estimatedArrivalDate: "21:00")
        }
    }
    func removeState(){
        currentDeliverystate = .inTransit
        Task{
            await DeliveryActivityUseCase.endActivity(withActivityIdentifier: activityIdentifier)
        }
    }
}

#Preview {
    ContentView()
}
