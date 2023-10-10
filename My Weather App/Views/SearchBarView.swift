//
//  SearchBarView.swift
//  My Weather App
//
//  Created by Clem OJ on 10/10/2023.
//

import SwiftUI

struct SearchBarView: View {
    
    var weatherManager = WeatherManager()
    @Binding var weather: WeatherResponse
    @State private var searchText = ""
    @State private var isEditing = false
    @State private var invalidCityName = false
    
    var body: some View {
        HStack {
            TextField("Search a city", text: $searchText) {
                weatherManager.getWeatherData(for: searchText) { result in
                    switch result{
                    case .success(let weather):
                        self.weather = weather
                        
                    case .failure(let error):
                        print("Error while getting data, \(error)")
                        invalidCityName = true
                    }
                }
            }
            .padding(10)
            .padding(.horizontal, 25)
            .background(Color(.systemGray4))
            .cornerRadius(8)
            .overlay {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    
                    Spacer()
                    
                    if isEditing {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }

                    }
                    
                }
            }
            .onTapGesture {
                isEditing = true
            }
            
            if isEditing {
                Button {
                    isEditing = false;
                    searchText = "";
                } label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }
                .padding(.trailing, 10)

            }
            
            
        }.alert("Please enter a valid city name", isPresented: $invalidCityName) {
            Button {
                invalidCityName = false
            } label: {
                Text("OK")
            }

        }
    }
}

//struct SearchBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarView()
//    }
//}
