//
//  WeatherRow.swift
//  My Weather App
//
//  Created by Clem OJ on 28/09/2023.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title)
                .frame(width: 30, height: 30)
                .padding()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.title2)
                
                Text(value)
                    .font(.title2)
                    .bold()
            }
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "feels like", value: "8°")
    }
}
