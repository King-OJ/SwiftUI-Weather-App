//
//  WeatherView.swift
//  My Weather App
//
//  Created by Clem OJ on 28/09/2023.
//

import SwiftUI

struct WeatherView: View {
    
    @State var weather: WeatherResponse
    @State private var isAminating = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                
                VStack {
                    SearchBarView( weather: $weather)
                        .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(weather.name), \(weather.sys.country)")
                            .foregroundColor(.white)
                            .bold()
                            .font(.title)
                        
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                            .foregroundColor(.white)
                            .fontWeight(.light)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading )
                    .padding(10)
                    
                    
                    Spacer()
                    
                    VStack{
                        HStack {
                            VStack(spacing: 20) {
                                Image(systemName: weather.conditionName)
                                    .foregroundColor(.white)
                                    .font(.system(size: 40))
                                
                                Text(weather.weather[0].description.capitalized)
                            }.frame(width:150, alignment: .leading)
                            
                            Spacer()
                            
                            Text(weather.main.temp.roundDouble() + "°")
                                .font(.system(size: 90))
                                .bold()
                                .padding()
                                .foregroundColor(.white)
                        }
                        
                        Image("londonimage")
                            .resizable()
                            .cornerRadius(15)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .ignoresSafeArea()
                            .opacity(isAminating ? 1 : 0)
                            .offset(y: isAminating ? 0 : -40)
                            .animation(.easeOut, value: isAminating)
                        
                        Spacer()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading )
                
                VStack {
                    Spacer()
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Weather now")
                            .bold()
                            .padding(.bottom)
                            .foregroundColor(.white)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                WeatherRow(logo: "thermometer", name: "Min Temp", value: weather.main.tempMin.roundDouble() + "°")
                                WeatherRow(logo: "thermometer", name: "Max Temp", value: weather.main.tempMax.roundDouble() + "°")
                                WeatherRow(logo: "wind", name: "Wind Speed", value: weather.wind.speed.roundDouble() + "m/s")
                                WeatherRow(logo: "humidity", name: "Humidity", value: weather.main.humidity.roundDouble() + "%")
                            }
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 125, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                }
                
            }.onAppear {
                isAminating = true
            }
        }
    }
}

//struct WeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherView()
//    }
//}
