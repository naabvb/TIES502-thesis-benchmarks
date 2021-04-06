//
//  AnimationsView.swift
//  gradu_swift_bench
//
//  Created by Lauri Pimiä on 28.1.2021.
//

import SwiftUI

struct AnimationsView: View {
    var columns: Int
    var amount: Int
    @State private var isActive = false
    var animation: Animation {
        Animation.linear(duration: 0.5).repeatForever(autoreverses: false)
    }
    
    
    func getAngle(index: Int) -> Double {
        if (index % 2 == 0) {
            return isActive ? 0 : 360
        }
        else {
            return isActive ? 360 : 0
        }
    }
    
    
    
    var body: some View {
        let flexibleColumn = Array(repeating: GridItem(.flexible(), spacing: 2), count: columns)
        VStack{
            LazyVGrid(columns: flexibleColumn, content: {
                ForEach((1..<amount)) { i in
                    Image("testikuva")
                        .resizable()
                        .frame(width: 20, height: 10)
                        .rotationEffect(Angle.degrees(getAngle(index: i))).animation(isActive ? animation : .default)
                    
                    
                }
                
            })
            Button(isActive ? "Stop" : "Start") {
                self.isActive = !isActive
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsView(columns: 8, amount: 105)
    }
}
