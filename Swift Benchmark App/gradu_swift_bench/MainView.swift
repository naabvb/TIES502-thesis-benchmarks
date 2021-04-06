//
//  MainView.swift
//  gradu_swift_bench
//
//  Created by Lauri Pimiä
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: AnimationsSelectionView()) {
                    Text("Animations benchmarks")
                        .padding()
                }
                NavigationLink(destination: UtilitiesView()) {
                    Text("Utilities benchmarks")
                        .padding()
                }
            }
            .navigationBarTitle("Swift bench")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
