//
//  ContentView.swift
//  My Weather App
//
//  Created by Clem OJ on 22/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    private var weatherManager = WeatherManager()
    @State private var weather: WeatherResponse?
    
    var body: some View {
   
            VStack {
                
                if let location = locationManager.location {
                    if let weather = weather {
                        WeatherView(weather: weather)
                    }
                    else {
                        LoadingView(loadingText: "Oboy cool down, I'm fetching your weather!😄")
                            .task {
                                weatherManager.getWeatherData(for: location) { result in
                                    switch result{
                                        
                                    case .success(let weather):
                                        self.weather = weather
                                        
                                    case .failure(let error):
                                        print("Error while getting data, \(error)")
                                        
                                    }
                                }
                            }
                    }
                    
                }
                
                else {
                    if locationManager.isLoading {
                        LoadingView(loadingText: "Please wait while we get your location 😄")
                    }
                    else {
                        WelcomeView(locationManager: locationManager)
                    }
                }
                
                
            }
            .preferredColorScheme(.dark)
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
