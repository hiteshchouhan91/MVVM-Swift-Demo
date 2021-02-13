//
//  Bindable.swift
//  MVVMExercise
//
//  Created by Hitesh Chouhan on 04/02/21.
//  Copyright © 2021 Hitesh Chouhan. All rights reserved.
//

import Foundation

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
