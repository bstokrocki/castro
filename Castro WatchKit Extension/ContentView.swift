//
//  ContentView.swift
//  Castro WatchKit Extension
//
//  Created by Bartosz Stokrocki on 26/03/2021.
//

import SwiftUI

struct ContentView: View {
    let vm: PlayerViewModel
    
    init(viewModel: PlayerViewModel) {
        self.vm = viewModel
    }
    
    var body: some View {
        Button(action: {
            vm.onClick()
        }, label: {
            Image("Play")
                .renderingMode(.original)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PlayerViewModel())
    }
}
