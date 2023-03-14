//
//  ContentView.swift
//  Tomatoro
//
//  Created by Łukasz Stachnik on 02/03/2023.
//

import SwiftUI
import Insomnia

struct PomodoroView: View {

    private let insomnia = Insomnia(mode: .whenCharging)
    @StateObject var viewModel = PomodoroViewModelImpl()

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
                .buttonStyle(.borderedProminent)
                .tint(.blue)

            case .inProgress:
                Button {
                    viewModel.complete()
                } label: {
                    Text("Complete")
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)

            case .complete:
                Button {
                    viewModel.restart()
                } label: {
                    Text("Restart")
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView()
    }
}
