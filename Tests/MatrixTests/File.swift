// ArithmeticTests.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/MATH/blob/main/LICENSE for license information

import XCTest
@testable import Matrix

final class ArithmeticTests: XCTestCase {
    func testMatrixAddition(m1: [[Double]], m2: [[Double]], eq: [[Double]]) {
        XCTAssertEqual(Matrix(m1) + Matrix(m2), Matrix(eq))
    }
    
    func testMatrixSubtraction(m1: [[Double]], m2: [[Double]], eq: [[Double]]) {
        XCTAssertEqual(Matrix(m1) - Matrix(m2), Matrix(eq))
    }
    
    func testScalarMultiplication(m: [[Double]], s: Double, eq: [[Double]]) {
        XCTAssertEqual(Matrix(m) * s, Matrix(eq))
    }
    
    func testMatrixMultiplication(m1: [[Double]], m2: [[Double]], eq: [[Double]]) {
        XCTAssertEqual(Matrix(m1) * Matrix(m2), Matrix(eq))
    }
    
    func testMatrixAddition() {
        testMatrixAddition(m1: [[1, 2, 3], [4, 5, 6]],
                           m2: [[1, 2, 3], [4, 5, 6]],
                           eq: [[2, 4, 6], [8, 10, 12]])
    }
    
    func testMatrixSubtraction() {
        testMatrixSubtraction(m1: [[2, 2, 3], [4, 5, 6]],
                              m2: [[1, 2, 1], [5, 2, 6]],
                              eq: [[1, 0, 2], [-1, 3, 0]])
    }
    
    func testScalarMultiplication() {
        testScalarMultiplication(m: [[1, 2, 3], [4, 5, 6]],
                                 s: 5,
                                 eq: [[5, 10, 15], [20, 25, 30]])
    }
    
    func testMatrixMultiplication() {
        testMatrixMultiplication(m1: [[1, 2, 3], [4, 5, 6]],
                                 m2: [[1, 2], [4, 5], [3, 2]],
                                 eq: [[18, 18], [42, 45]])
    }
    
    
    
    
}
