//
//  WelcomeView.swift
//  My Weather App
//
//  Created by Clem OJ on 22/09/2023.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    @ObservedObject var locationManager: LocationManager
    
    var body: some View {
        VStack{
            
            VStack(spacing: 20) {
                Text("Welcome to Clem Weather App")
                    .bold()
                    .font(.title)
                
                Text("Please share your current location to get the weather in your area")
                    .padding()
                
                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
                
            }.multilineTextAlignment(.center)
            .padding()
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(locationManager: LocationManager())
    }
}
