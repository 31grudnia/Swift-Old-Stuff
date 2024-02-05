//
//  ShowPlace.swift
//  Projekt1
//
//  Created by user on 19/06/2022.
//

import SwiftUI
import MapKit

struct MapPlace : Identifiable {
    let id = UUID()
    let name: String
    var coordinate: CLLocationCoordinate2D
}

struct ShowPlace: View {
    @StateObject var place : Place
    let places:[MapPlace]
    @State private var region: MKCoordinateRegion

    init(place:Place)
    {
        _place = StateObject(wrappedValue: place)
        places = [MapPlace(name: place.title! , coordinate: CLLocationCoordinate2D(latitude: place.pin!.latitude, longitude: place.pin!.longitude))]
        region = MKCoordinateRegion(center:
                                                        CLLocationCoordinate2D(latitude: places[0].coordinate.latitude, longitude: places[0].coordinate.longitude),
             latitudinalMeters: 3000, longitudinalMeters: 3000)
        
        print(places[0].coordinate)
        print("-------------------------------------------------------")
    }
    
    
    var body: some View {
        
        Map(coordinateRegion: $region, annotationItems: places)
        {place in
            MapPin(coordinate: place.coordinate, tint: .red)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ShowPlace_Previews: PreviewProvider {
    static var previews: some View {
        let place = Place()
        ShowPlace(place: place)
    }
}
