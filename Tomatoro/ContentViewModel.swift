//
//  ContentViewModel.swift
//  Tomatoro
//
//  Created by Łukasz Stachnik on 02/03/2023.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {

    enum Status {
        case notStarted
        case inProgress
        case complete
    }

    private var timerCancellable: AnyCancellable?
    private var startDate: Date?

    @Published var status: Status = .notStarted
    @Published var remainingSeconds = Constants.timerLength

    func start() {
        status = .inProgress
        startDate = Date()

        startTimer()
    }

    func complete() {
        status = .complete
        timerCancellable?.cancel()
    }

    func restart() {
        status = .inProgress
        startDate = Calendar.current.date(byAdding: .second, value: 1, to: Date())
        startTimer()
    }

    private func startTimer() {
        timerCancellable = Timer
            .publish(every: 1,
                     on: .current,
                     in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }

                if self.status == .inProgress {
                    self.elapseTime()
                } else if self.status == .notStarted {
                    self.start()
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
