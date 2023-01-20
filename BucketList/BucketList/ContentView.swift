//
//  ContentView.swift
//  BucketList
//
//  Created by Arthur Liu on 1/19/23.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
    )
    
    @State private var locations = Array<Location>()
    @State private var showingSheet = false
    @State private var selectedLocation: Location?

    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion,
                showsUserLocation: true,
                annotationItems: locations) { location in
                MapAnnotation(coordinate: CLLocationCoordinate2DMake(location.latitude, location.longitude)) {
                    VStack(spacing: 4.0) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(Circle())
                            .onTapGesture {
                                selectedLocation = location
                            }
                        Text(location.name)
                    }
                    .fixedSize()
                }
            }
                .ignoresSafeArea()
            Circle()
                .fill(.red)
                .opacity(0.3)
                .frame(width: 20, height: 20)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        addNewLocation(at: mapRegion.center)
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                    }
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding()
                }
            }
        }
        .sheet(item: $selectedLocation) { location in
            EditView(location: location) { newLocation in
                if let index = locations.firstIndex(of: location) {
                    locations[index] = newLocation
                }
            }
        }
    }
    
    func addNewLocation(at point: CLLocationCoordinate2D) {
        locations.append(
            Location(name: "(New Place)", description: "", latitude: point.latitude, longitude: point.longitude)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
