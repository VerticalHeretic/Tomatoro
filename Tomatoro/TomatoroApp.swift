//
//  TomatoroApp.swift
//  Tomatoro
//
//  Created by Łukasz Stachnik on 02/03/2023.
//

import SwiftUI
import Inject

@main
struct TomatoroApp: App {
    @ObserveInjection var inject

    var body: some Scene {
        WindowGroup {
            PomodoroView()
                .eraseToAnyView()
                .enableInjection()
        }
    }
}
