//
//  PomodoroViewModelTests.swift
//  TomatoroTests
//
//  Created by Łukasz Stachnik on 14/03/2023.
//

import XCTest
import Combine

@testable import Tomatoro

final class PomodoroViewModelTests: XCTestCase {

    private var sut: PomodoroViewModelImpl!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        sut = PomodoroViewModelImpl()
    }

    override func tearDown() {
        sut = nil
    }

    func testStart_shouldStart_whenStatusNotStarted() {
        // Given
        sut.status = .notStarted

        // When
        sut.start()

        // Then
        XCTAssertEqual(sut.status, .inProgress)
    }

    func testStart_shouldNotStart_whenStatusOtherThenNotStarted() {
        // Given
        let initialStatus = PomodoroStatus.inProgress
        sut.status = initialStatus

        // When
        sut.start()

        // Then
        XCTAssertEqual(sut.status, initialStatus)
    }

    func testComplete_shouldComplete_whenStatusInProgress() {
        // Given
        sut.status = .inProgress

        // When
        sut.complete()

        // Then
        XCTAssertEqual(sut.status, .complete)
    }

    func testComplete_shouldNotComplete_whenStatusOtherThenInProgress() {
        // Given
        let initialStatus = PomodoroStatus.notStarted
        sut.status = initialStatus

        // When
        sut.complete()

        // Then
        XCTAssertEqual(sut.status, initialStatus)
    }

    func testRestart_shouldRestart_whenStatusComplete() {
        // Given
        sut.status = .complete

        // When
        sut.restart()

        // Then
        XCTAssertEqual(sut.status, .inProgress)
    }

    func testRestart_shouldNotRestart_whenStatusOtherThenComplete() {
        // Given
        let initialStatus = PomodoroStatus.inProgress
        sut.status = initialStatus

        // When
        sut.start()

        // Then
        XCTAssertEqual(sut.status, initialStatus)
    }

    func testRemainingSeconds_shouldStartCountingDown_whenTimerStarted() {
        // Given
        let expectation = expectation(description: "Started counting down the seconds")

        // When
        sut.start()

        sut.$remainingSeconds
            .sink { seconds in
                if seconds < Constants.timerLength {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(sut.remainingSeconds < Constants.timerLength)
    }

    func testRemainingSeconds_shouldComplete_whenRemainingSecondsIsZero() {
        // Given
        let expectation = expectation(description: "Seconds is 0, should complete")

        // When
        sut.start()

        sut.$remainingSeconds
            .sink { seconds in
                if seconds < Constants.timerLength {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(sut.remainingSeconds < Constants.timerLength)
    }
}

