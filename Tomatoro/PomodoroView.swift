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
        VStack(spacing: 20) {
            TomatoView(status: $viewModel.status)
                .frame(width: 200, height: 200)

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
                .tint(.complete)

            case .complete:
                Button {
                    viewModel.restart()
                } label: {
                    Text("Restart")
                }
                .buttonStyle(.borderedProminent)
                .tint(.restart)
            }
        }
        .animation(.easeInOut, value: viewModel.status)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView()
    }
}
