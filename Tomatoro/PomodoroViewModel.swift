//
//  ContentViewModel.swift
//  Tomatoro
//
//  Created by Łukasz Stachnik on 02/03/2023.
//

import Foundation
import Combine

enum PomodoroStatus {
    case notStarted
    case inProgress
    case complete
}

protocol PomodoroViewModel: AnyObject {
    var status: PomodoroStatus { get set }
    var remainingSeconds: Int { get set }

    func start()
    func complete()
    func restart()
}

final class PomodoroViewModelImpl: PomodoroViewModel, ObservableObject {

    private var timerCancellable: AnyCancellable?
    private var startDate: Date?

    @Published var status: PomodoroStatus = .notStarted
    @Published var remainingSeconds = Constants.timerLength

    func start() {
        guard status == .notStarted else { return }

        status = .inProgress
        startDate = Date()

        startTimer()
    }

    func complete() {
        guard status == .inProgress else { return }

        status = .complete
        timerCancellable?.cancel()
    }

    func restart() {
        guard status == .complete else { return }

        status = .inProgress
        startDate = Calendar.current.date(byAdding: .second, value: 1, to: Date())
        startTimer()
    }

    private func startTimer() {
        timerCancellable = Timer
            .publish(every: 1,
                     on: .main,
                     in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                if self?.status == .inProgress {
                    self?.elapseTime()
                }
            })
    }

    private func elapseTime() {
        if let startDate = self.startDate {
            let elapsedTime = Date().timeIntervalSince(startDate)
            let remainingTime = max(0, Constants.timerLength - Int(elapsedTime))
            self.remainingSeconds = remainingTime
            if remainingTime == 0 {
                self.status = .complete
                self.timerCancellable?.cancel()
            }
        }
    }
}
