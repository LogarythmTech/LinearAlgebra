// ArithmeticTests.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/MATH/blob/main/LICENSE for license information

import XCTest
@testable import Vector

final class ArithmeticTests: XCTestCase {
    func testAddingTwoVectors(_ x: [Double], _ y: [Double], equal: [Double]) {
        let left = Vector(x)
        let right = Vector(y)
        let equal = Vector(equal)
        
        XCTAssertEqual(left + right, equal)
    }
    
    func testSubtractingTwoVectors(_ x: [Double], _ y: [Double], equal: [Double]) {
        let left = Vector(x)
        let right = Vector(y)
        let equal = Vector(equal)
        
        XCTAssertEqual(left - right, equal)
    }
    
    func testMultiplyingVectorAndScalar(_ x: [Double], _ y: Double, equal: [Double]) {
        let vector: Vector = Vector(x)
        let equal = Vector(equal)
        
        XCTAssertEqual(vector * y, equal)
        XCTAssertEqual(y * vector, equal)
    }
    
    func testDividingVectorAndScalar(_ x: [Double], _ y: Double, equal: [Double]) {
        let vector = Vector(x)
        let equal = Vector(equal)
        
        XCTAssertEqual(vector / y, equal)
    }
    
    func testAddingTwoVectors() {
        testAddingTwoVectors([1, 2, 3], [3, 2, 1], equal: [4, 4, 4])
    }
    
    func testSubtractingTwoVectors() {
        testSubtractingTwoVectors([1, 2, 3], [3, 2, 1], equal: [-2, 0, 2])
    }
    
    func testMultiplyingVectorAndScalar() {
        testMultiplyingVectorAndScalar([3, 2, 1], 3, equal: [9, 6, 3])
    }
    
    func testDividingVectorAndScalar() {
        testDividingVectorAndScalar([9, 6, 3], 3, equal: [3, 2, 1])
    }
    
    func testDotProduct() {
        let vector1: Vector = [3, 2, 1]
        let vector2: Vector = [8, 6, 3]
        let dotProduct = vector1 •* vector2
        XCTAssertEqual(dotProduct, 39)
    }
}
