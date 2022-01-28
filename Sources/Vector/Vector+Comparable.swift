// Vector+Comparable.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/LinearAlgebra/blob/main/LICENSE for license information

extension Vector: Equatable {
    public static func == (lhs: Vector, rhs: Vector) -> Bool {
        for dimension in 0..<max(lhs.dimensions, rhs.dimensions) {
            if(lhs[dimension] != rhs[dimension]) {
                return false
            }
        }
        
        return true
    }
}

//TODO: Should we do comparable, what whould that look like (magnitude vs. magnitude)?
