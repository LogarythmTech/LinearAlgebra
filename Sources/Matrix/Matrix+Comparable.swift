// Matrix+Comparable.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/MATH/blob/main/LICENSE for license information

extension Matrix: Equatable {
    public static func ==(lhs: Matrix, rhs: Matrix) -> Bool {
        for row in 0..<max(lhs.rows, rhs.rows) {
            for col in 0..<max(lhs.columns, rhs.columns) {
                if(lhs[row, col] != rhs[row, col]) {
                    return false
                }
            }
        }
        
        return true
    }
}
