// Matrix.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/LinearAlgebra/blob/main/LICENSE for license information

public struct Matrix<Scalar: FloatingPoint> {
    
    internal var components: [[Scalar]]
    
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
    
    /// A Zero Matrix of size `m` x `n`.
    /// - Parameters:
    ///    - m: The number of rows
    ///    - n: The number of columns
    ///    - value: The value at each entry in the matrix.
    public init(m: Int, n: Int, with value: Scalar) {
        let matrix: [[Scalar]] = Array(repeating: Array(repeating: value, count: n), count: m)
        self.init(matrix)
    }
    
    /// A Zero Matrix of size `m` x `n`.
    /// - Parameters:
    ///    - m: The number of rows
    ///    - n: The number of columns
    public init(m: Int, n: Int) {
        self.init(m: m, n: n, with: 0)
    }
    
    /// A Zero Square Matrix of size `n`.
    /// - Parameters:
    ///    - n: The number of rows and columns
    public init(n: Int) {
        self.init(m: n, n: n)
    }
    
    /// An Indentity Matrix of size `n`.
    /// - Parameters:
    ///    - n: The number of rows and columns
    public init(identity n: Int) {
        self.init(m: n, n: n)
        
        for row in 0..<rows {
            for col in 0..<columns {
                if(row == col) {
                    self[row, col] = 1
                } else {
                    self[row, col] = 0
                }
            }
        }
    }
    
    /// A row vector. (There is only one row in the matrix)
    public init(rowVector row: [Scalar]) {
        self.init(m: 1, n: row.count)
        
        for i in 0..<row.count {
            self[0, i] = row[i]
        }
    }
    
    /// A column vector. (There is only one column in the matrix)
    public init(columnVector col: [Scalar]) {
        self.init(m: col.count, n: 1)
        
        for i in 0..<col.count {
            self[i, 0] = col[i]
        }
    }
    
    /// A diagonal vector all values not on the diagonal where `row == col` are equal to zero.
    public init(diagonal values: [Scalar]) {
        self.init(m: values.count, n: values.count)
        
        for i in 0..<values.count {
            self[i, i] = values[i]
        }
    }
    
    /// A diagonal vector going from the top left corner to the bottom right corner of the matrix.
    public init(leftToRightDiogonal values: [Scalar]) {
        self.init(m: values.count, n: values.count)
        
        for i in 0..<values.count {
            self[i, values.count - i - 1] = values[i]
        }
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
    
    /// Returns `true` if the matrix is a Square matrix. The number of rows equal the number of columns.
    public var isSquare: Bool {
        return rows == columns
    }
    
    /// Returns `true` if the matrix is a column vector. The number of columns is one.
    public var isColumnVector: Bool {
        return columns == 1
    }
    
    /// Returns `true` if the matrix is a row vector. The number of rows is one.
    public var isRowVector: Bool {
        return rows == 1
    }
    
    /// Returns `true` if all entries in the matrix equal 0.
    public var isZero: Bool {
        for row in 0..<rows {
            for col in 0..<columns {
                if(self[row, col] != 0) {
                    return false
                }
            }
        }
        
        return true
    }
    
    /// Returns `true` if matrix is a diagonal matrix. All values such that `row != col` are zero.
    public var isDiagonal: Bool {
        if(!isSquare) {
            return false
        }
        
        for row in 0..<rows {
            for col in 0..<columns {
                if(row != col && self[row, col] != 0) {
                    return false
                }
            }
        }
        
        return true
    }
    
    /// Returns `true` if matrix is a identity matrix. All values on the diagonal (`row == col`) are equal to  `1` and the rest of the values are equal to zero.
    public var isIdentity: Bool {
        if(!isSquare) {
            return false
        }
        
        for row in 0..<rows {
            for col in 0..<columns {
                if(row == col && self[row, col] != 1) {
                    return false
                } else if(row != col && self[row, col] != 0) {
                    return false
                }
            }
        }
        
        return true
    }
    
    //MARK: Static
    public static var zero: Matrix<Scalar> {
        return Matrix<Scalar>()
    }
}
