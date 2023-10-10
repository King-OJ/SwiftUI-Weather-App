//
//  LoadingView.swift
//  My Weather App
//
//  Created by Clem OJ on 28/09/2023.
//

import SwiftUI

struct LoadingView: View {
    var loadingText: String
    var body: some View {
        VStack {
            Text(loadingText)
                .padding(5)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(loadingText: "Please wait a moment 😄")
    }
}
