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
            Text("Tomatoro 🍅")
                .font(.largeTitle)
                .fontWeight(.black)

            TomatoView(status: $viewModel.status)
                .frame(width: 200, height: 200)

            ClockView(remainingSeconds: $viewModel.remainingSeconds)

            switch viewModel.status {
            case .notStarted:
                Button {
                    viewModel.start()
                } label: {
                    Text("Starting the Pomodoro")
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .accessibilityLabel("Pomodoro starting")
                .accessibilityIdentifier("start_button")
                .accessibilityHint("When pressed starts pomodoro timer")

            case .inProgress:
                Button {
                    viewModel.complete()
                } label: {
                    Text("Complete")
                }
                .buttonStyle(.borderedProminent)
                .tint(.complete)
                .accessibilityLabel("Pomodoro complete")
                .accessibilityIdentifier("complete_button")
                .accessibilityHint("When pressed completes pomodoro timer")

            case .complete:
                Button {
                    viewModel.restart()
                } label: {
                    Text("Restart")
                }
                .buttonStyle(.borderedProminent)
                .tint(.restart)
                .accessibilityLabel("Pomodoro restart")
                .accessibilityIdentifier("restart_button")
                .accessibilityHint("When pressed restarts pomodoro timer")
            }
        }
        .eraseToAnyView()
        .animation(.easeInOut, value: viewModel.status)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView()
    }
}
