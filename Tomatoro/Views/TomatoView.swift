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
                .accessibilityIdentifier("notStarted_image")
        case .inProgress:
            LottieView(lottieFile: "Pomodor-InProgress", loopMode: .autoReverse)
                .accessibilityIdentifier("inProgress_lottie_view")
        case .complete:
            LottieView(lottieFile: "Pomodor-Complete", loopMode: .playOnce)
                .accessibilityIdentifier("complete_lottie_view")
        }

    }
}

struct TomatoView_Previews: PreviewProvider {
    static var previews: some View {
        TomatoView(status: .constant(.complete))
    }
}
