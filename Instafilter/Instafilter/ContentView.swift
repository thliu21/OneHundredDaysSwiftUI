//
//  ContentView.swift
//  Instafilter
//
//  Created by Tianhao Liu on 12/11/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var filterModel = FilterModel()
    @State private var showingSheet: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(filterModel.processedImage != nil ? .clear : .gray)

                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)

                    if let image = filterModel.processedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .onTapGesture {
                    showingSheet = true
                }

                HStack {
                    Text("Intensity")
                    Slider(value: $filterModel.intensity)
                }
                .padding(.vertical)

                HStack {
                    Picker("Please choose a filter", selection: $filterModel.filterType) {
                        ForEach(FilterModel.FilterType.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)

                    Spacer()

                    Button("Save") {
                        // save the picture
                    }
                }
                .sheet(isPresented: $showingSheet) {
                    ImagePicker(image: $filterModel.inputImage)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
