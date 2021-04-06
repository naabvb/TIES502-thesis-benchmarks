//
//  AnimationsSelectionView.swift
//  gradu_swift_bench
//
//  Created by Lauri Pimiä
//

import SwiftUI

struct AnimationsSelectionView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: AnimationsView(columns: 4, amount: 53)) {
                Text("Low intensity")
                    .padding()
            }
            NavigationLink(destination: AnimationsView(columns: 8, amount: 105)) {
                Text("Medium intensity")
                    .padding()
            }
            NavigationLink(destination: AnimationsView(columns: 16, amount: 209)) {
                Text("High intensity")
                    .padding()
            }
        }
    }
}

struct AnimationsSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsSelectionView()
    }
}
