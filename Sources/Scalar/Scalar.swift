// Scalar.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/LinearAlgebra/blob/main/LICENSE for license information

public protocol Scalar: FloatingPoint {}


extension Scalar {
    //TODO: Allow exp to be a float
    public func power(of exp: Int) -> Self {
        var sum: Self = 1
        
        if(exp == 0) {
            return 1
        } else if(exp == 1) {
            return self
        }
        
        for _ in 0..<exp.magnitude {
            sum *= self
        }
        
        if(exp < 0) {
            sum = 1/sum
        }
        
        return sum
    }
}


extension BinaryInteger {
    public func factorial() -> Self {
        var sum: Self = 1
        
        if(self == 0 || self == 1) {
            return 1
        }
        
        var i: Self = 2
        while(i <= self) {
            sum *= i
            i += 1
        }

        return sum
    }
}


extension Float: Scalar {}
extension Double: Scalar {}
