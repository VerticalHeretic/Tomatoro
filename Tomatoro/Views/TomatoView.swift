//
//  TomatoView.swift
//  Tomatoro
//
//  Created by Łukasz Stachnik on 15/03/2023.
//

import SwiftUI
import Lottie

struct TomatoView: View {
    @Binding var status: PomodoroStatus

    var body: some View {
        switch status {
        case .notStarted:
            Image("Tomato")
        case .inProgress:
            LottieView(lottieFile: "Pomodor-InProgress",
                       loopMode: .autoReverse)
        case .complete:
            LottieView(lottieFile: "Pomodor-Complete",
                       loopMode: .playOnce)
        }

    }
}

struct TomatoView_Previews: PreviewProvider {
    static var previews: some View {
        TomatoView(status: .constant(.complete))
    }
}
