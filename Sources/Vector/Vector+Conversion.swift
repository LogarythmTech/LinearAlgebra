// Vector+Conversion.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/LinearAlgebra/blob/main/LICENSE for license information

//MARK: - String
//MARK: To String

extension String {
    /// A String that equates to the ASCII representation of a Vector values.
    ///
    ///     ⟨1, 2, 3⟩
    ///
    /// - Parameters:
    ///    - m: A Matrix.
    public init<S: FloatingPoint>(_ v: Vector<S>) {
        self = ""
        
        if(v.dimensions == 0) {
            self = "⟨⟩"
            return
        }
        
        for d in 0..<v.dimensions {
            if(d == 0) {
                self += "⟨"
            } else {
                self += ", "
            }
            
            self += String("\(v[d])")
            
            if(d == v.dimensions - 1) {
                self += "⟩"
            }
        }
    }
}

extension Vector: CustomStringConvertible {
    public var description: String {
        return String(self)
    }
}

extension Vector: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Dimensions: \(dimensions), Vector: " + String(self)
    }
}

extension Vector: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        return String(self)
    }
}
