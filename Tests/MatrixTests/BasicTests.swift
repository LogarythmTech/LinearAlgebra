// BasicTests.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/MATH/blob/main/LICENSE for license information

import XCTest
@testable import Matrix

final class BasicTests: XCTestCase {
    func testExpressibleBy() {
        let matrix: Matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        XCTAssertEqual(matrix.rows, 3)
    }
    
    func testToString() {
        let matrix: Matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [0, 1, 2]]
        print(matrix)
    }
    
    func testGetMatrix() {
        let matrix: Matrix<Double> = Matrix<Double>([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
        XCTAssertEqual(matrix[0, 0], 1.0)
        
        //Single Column
        XCTAssertEqual(matrix[1...2, 1], Matrix<Double>([[5], [8]]))
        XCTAssertEqual(matrix[1..<2, 1], Matrix<Double>([[5]]))
        XCTAssertEqual(matrix[...2, 1], Matrix<Double>([[2], [5], [8]]))
        XCTAssertEqual(matrix[..<2, 1], Matrix<Double>([[2], [5]]))
        XCTAssertEqual(matrix[1..., 1], Matrix<Double>([[5], [8]]))
        XCTAssertEqual(matrix[col: 1], Matrix<Double>([[2], [5], [8]]))
        
        //Single Row
        XCTAssertEqual(matrix[0, 1...2], Matrix<Double>([[2, 3]]))
        XCTAssertEqual(matrix[0, 1..<2], Matrix<Double>([[2]]))
        XCTAssertEqual(matrix[0, ...2], Matrix<Double>([[1, 2, 3]]))
        XCTAssertEqual(matrix[0, ..<2], Matrix<Double>([[1, 2]]))
        XCTAssertEqual(matrix[0, 1...], Matrix<Double>([[2, 3]]))
        XCTAssertEqual(matrix[row: 0], Matrix<Double>([[1, 2, 3]]))
        
        //Subset of rows and columns
        XCTAssertEqual(matrix[0..<3, 0..<3], Matrix<Double>([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[0..<3, 0...2], Matrix<Double>([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[0..<3, ...2], Matrix<Double>([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[0..<3, ..<2], Matrix<Double>([[1, 2], [4, 5], [7, 8]]))
        XCTAssertEqual(matrix[0..<3, 1...], Matrix<Double>([[2, 3], [5, 6], [8, 9]]))
        
        XCTAssertEqual(matrix[0...2, 0..<3], Matrix<Double>([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[0...2, 0...2], Matrix<Double>([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[0...2, ...2], Matrix<Double>([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[0...2, ..<2], Matrix<Double>([[1, 2], [4, 5], [7, 8]]))
        XCTAssertEqual(matrix[0...2, 1...], Matrix<Double>([[2, 3], [5, 6], [8, 9]]))
        
        XCTAssertEqual(matrix[...2, 0..<3], Matrix<Double>([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[...2, 0...2], Matrix<Double>([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[...2, ...2], Matrix<Double>([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[...2, ..<2], Matrix<Double>([[1, 2], [4, 5], [7, 8]]))
        XCTAssertEqual(matrix[...2, 1...], Matrix<Double>([[2, 3], [5, 6], [8, 9]]))
        
        XCTAssertEqual(matrix[..<3, 0..<3], Matrix<Double>([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[..<3, 0...2], Matrix<Double>([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[..<3, ...2], Matrix<Double>([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[..<3, ..<2], Matrix<Double>([[1, 2], [4, 5], [7, 8]]))
        XCTAssertEqual(matrix[..<3, 1...], Matrix<Double>([[2, 3], [5, 6], [8, 9]]))
        
        XCTAssertEqual(matrix[1..., 0..<3], Matrix<Double>([[4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[1..., 0...2], Matrix<Double>([[4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[1..., ...2], Matrix<Double>([[4, 5, 6], [7, 8, 9]]))
        XCTAssertEqual(matrix[1..., ..<2], Matrix<Double>([[4, 5], [7, 8]]))
        XCTAssertEqual(matrix[1..., 1...], Matrix<Double>([[5, 6], [8, 9]]))
    }
}
