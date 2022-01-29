// BasicTests.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/MATH/blob/main/LICENSE for license information

import XCTest
@testable import Vector

final class BasicTests: XCTestCase {
    
    func testCartesian() {
        let x: Vector = Vector(x: 1, y: 2, z: 3, w: 4)
        XCTAssertEqual(x[cartesian: 0], 1)
        XCTAssertEqual(x[cartesian: 1], 2)
        XCTAssertEqual(x[cartesian: 2], 3)
        XCTAssertEqual(x[cartesian: 3], 4)
        
        let s: Vector = Vector(radius: 5, θ: 1.57, 𝛗: 0.78)
        XCTAssertEqual(s[cartesian: 0], 0.002800200933)
        XCTAssertEqual(s[cartesian: 1], 3.516395981)
        XCTAssertEqual(s[cartesian: 2], 3.55456769)
        
        let c: Vector = Vector(radius: 5, θ: 1.57, z: 7)
        XCTAssertTrue(c[cartesian: 0].isApproximatelyEqual(to: 0.003981633554))
        XCTAssertTrue(c[cartesian: 1].isApproximatelyEqual(to: 4.999998415))
        XCTAssertTrue(c[cartesian: 2].isApproximatelyEqual(to: 7))
    }
    
}
