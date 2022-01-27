// Matrix.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/MATH/blob/main/LICENSE for license information

public struct Matrix<Scalar: FloatingPoint> {
    
    public var components: [[Scalar]]
    
    public init(_ matrix: [[Scalar]]) {
        self.components = matrix
    }
}

//MARK: - Additional Initializers
extension Matrix {
    /// A default initialzer that equates to a 4x4 matrix with each component of 0
    public init() {
        let matrix: [[Scalar]] = [[0, 0], [0, 0]]
        self.init(matrix)
    }
    
    /// A Matrix of size `m` x `n` with each component equating 0
    /// - Parameters:
    ///    - m: The number of rows
    ///    - n: The number of columns
    public init(m: Int, n: Int) {
        let matrix: [[Scalar]] = Array(repeating: Array(repeating: 0, count: n), count: m)
        self.init(matrix)
    }
}

//MARK: - Basic Properties
extension Matrix {
    /// The number of rows in the  `Matrix`
    public var rows: Int {
        return components.count
    }
    
    /// The number of columns in the `Matrix`
    public var columns: Int {
        return components.first?.count ?? 0
    }
}

//MARK: - Getters and Setters
extension Matrix {
    public subscript(row: Int, column: Int) -> Scalar {
        get {
            if(row < rows || column < columns) {
                return 0
            }
            
            return components[row][column]
        } set(newValue) {
            while(row < rows) {
                addRow()
            }
            
            while(column < columns) {
                addCol()
            }
            
            components[row][column] = newValue
        }
    }
    
    internal mutating func addRow() {
        let newRow: [Scalar] = Array(repeating: 0, count: columns)
        components.append(newRow)
    }
    
    internal mutating func addCol() {
        for i in 0..<rows {
            components[i].append(0)
        }
    }
}
