//
//  ContentView.swift
//  Tomatoro
//
//  Created by Łukasz Stachnik on 02/03/2023.
//

import SwiftUI
import Combine

struct Constants {
    static let timerLength = 1 * 60
}

struct ContentView: View {

    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Text("🍅")
                .font(.largeTitle)

            switch viewModel.status {
            case .notStarted:
                Button {
                    viewModel.start()
                } label: {
                    Text("Start")
                }
            case .inProgress:
                HStack {
                    Text("\(viewModel.remainingSeconds / 60):\(String(format: "%02d", viewModel.remainingSeconds % 60))")
                        .font(.largeTitle)
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
        startDate = Date()
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
                    if let startDate = self.startDate {
                        let elapsedTime = Date().timeIntervalSince(startDate)
                        let remainingTime = max(0, Constants.timerLength - Int(elapsedTime))
                        self.remainingSeconds = remainingTime
                        if remainingTime == 0 {
                            self.status = .complete
                            self.timerCancellable?.cancel()
                        }
                    }
                } else if self.status == .notStarted {
                    self.start()
                }
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
