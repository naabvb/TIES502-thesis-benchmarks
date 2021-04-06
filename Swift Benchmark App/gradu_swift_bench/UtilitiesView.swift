//
//  UtilitiesView.swift
//  gradu_swift_bench
//
//  Created by Lauri Pimiä
//

import SwiftUI
import CryptoKit

struct UtilitiesView: View {
    @State private var cryptoExecTime = ""
    @State private var jsonExecTime = ""
    @State private var gpsResults = ""
    @State private var gpsAccuracy = ""
    @State private var gpsExecTime = ""
    private var locationManager = LocationController()
    
    func getLocation() {
        let start = DispatchTime.now()
        locationManager.getLocation(handler: {location in
            let done = DispatchTime.now()
            let ms = getMS(start: start, done: done)
            
            self.gpsResults = String(location.coordinate.latitude) + ", " + String(location.coordinate.longitude)
            self.gpsExecTime = ms
            self.gpsAccuracy = "Accuracy: " + String(location.horizontalAccuracy)
        })
    }
    
    func cryptoMark() {
        let start = DispatchTime.now()
        for i in 0..<800000 {
            createHMAC(i: i)
        }
        let done = DispatchTime.now()
        let ms = getMS(start: start, done: done)
        self.cryptoExecTime = ms
    }
    
    func getMS(start: DispatchTime, done: DispatchTime) -> String {
        let ns = done.uptimeNanoseconds - start.uptimeNanoseconds
        let ms = round(Double(ns) / 1000000)
        return String(ms) + " ms"
    }
    
    func createHMAC(i: Int) {
        let secretString = "test-key"
        let key = SymmetricKey(data: secretString.data(using: .utf8)!)
        let string = "verysecretteststring" + String(i)
        _ = HMAC<SHA256>.authenticationCode(for: string.data(using: .utf8)!, using: key)
        return
    }
    
    func parseJSON() {
        if let url = URL(string: "https://raw.githubusercontent.com/naabvb/TIES502-thesis-benchmarks/master/Assets/10mb-sample.json") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let start = DispatchTime.now()
                        _ = try JSONSerialization.jsonObject(with: data)
                        let done = DispatchTime.now()
                        let ms = getMS(start: start, done: done)
                        self.jsonExecTime = ms
                    } catch let error {
                        self.jsonExecTime = error.localizedDescription
                        print(error)
                    }
                }
                
            }.resume()
        }
    }
    
    var body: some View {
        VStack {
            Button("Run GPS benchmark") {
                getLocation()
            }
            Text(gpsResults).padding(.trailing).padding(.leading).padding(.top)
            Text(gpsAccuracy).padding(.trailing).padding(.leading)
            Text(gpsExecTime).padding(.trailing).padding(.leading).padding(.bottom)
            
            Button("Run Crypto benchmark"){
                cryptoMark()
            }
            Text(cryptoExecTime)
                .padding()
            Button("Run JSON benchmark"){
                parseJSON()
            }
            Text(jsonExecTime)
                .padding()
        }
    }
}

struct UtilitiesView_Previews: PreviewProvider {
    static var previews: some View {
        UtilitiesView()
    }
}
