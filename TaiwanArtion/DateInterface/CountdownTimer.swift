//
//  File.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/11.
//

import Foundation

class CountdownTimer {
    var timeRemaining: TimeInterval
    var timer: Timer?
    var onTick: ((TimeInterval) -> Void)?
    var onCompleted: (() -> Void)?

    init(timeInterval: TimeInterval) {
        self.timeRemaining = timeInterval
    }

    func start() {
        stop()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.timeRemaining -= 1
            self.onTick?(self.timeRemaining)
            if self.timeRemaining <= 0 {
                self.stop()
                self.onCompleted?()
            }
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}

