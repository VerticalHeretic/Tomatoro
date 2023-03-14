//
//  ContentView.swift
//  Tomatoro
//
//  Created by Łukasz Stachnik on 02/03/2023.
//

import SwiftUI
import Insomnia

struct ContentView: View {

    private let insomnia = Insomnia(mode: .whenCharging)
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Text("🍅")
                .font(.largeTitle)

            ClockView(remainingSeconds: $viewModel.remainingSeconds)

            switch viewModel.status {
            case .notStarted:
                Button {
                    viewModel.start()
                } label: {
                    Text("Start")
                }
            case .inProgress:
                Button {
                    viewModel.complete()
                } label: {
                    Text("Complete")
                }
            case .complete:
                Button {
                    viewModel.restart()
                } label: {
                    Text("Restart")
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
