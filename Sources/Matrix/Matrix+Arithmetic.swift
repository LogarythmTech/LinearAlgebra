// Matrix+Arithmetic.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/LinearAlgebra/blob/main/LICENSE for license information

//MARK: - Negatives
extension Matrix {
    /// Replaces the values in the matrix with its additive inverse.
    public mutating func negate() {
        for row in 0..<rows {
            for col in 0..<columns {
                self[row, col].negate()
            }
        }
    }
    
    /// Returns the additive inverse of the specified value.
    ///
    /// - Returns: The additive inverse of the argument.
    public prefix static func -(operand: Matrix) -> Matrix {
        var result = operand
        result.negate()
        return result
    }
    
    /// Returns the given number unchanged.
    ///
    /// - Returns: The given argument without any changes.
    public prefix static func +(operand: Matrix) -> Matrix {
        return operand
    }
}

extension Matrix: AdditiveArithmetic {
    //MARK: - Addition
    /// Adds two matrix and produces their sum.
    ///
    /// - Parameters:
    ///   - lhs: The first matrix to add.
    ///   - rhs: The second matrix to add.
    /// - Returns: The sum of two matrix, `lhs` and `rhs`
    /// - Precondition: `lhs.rows == rhs.rows && lhs.columns == rhs.clolumns`
    public static func +(lhs: Matrix<Scalar>, rhs: Matrix<Scalar>) -> Matrix<Scalar> {
        precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "The left and right matrices must be the same size.")
        var result: Matrix = Matrix<Scalar>(m: lhs.rows, n: lhs.columns)
        
        for row in 0..<lhs.rows {
            for col in 0..<lhs.columns {
                result[row, col] = lhs[row, col] + rhs[row, col]
            }
        }
        
        return result
    }
    
    /// Adds two matrixs and stores the result in the left-hand-side variable.
    ///
    /// The sum of the two arguments must be representable in the arguments' type.
    ///
    /// - Parameters:
    ///   - lhs: The first matrix to add and store sum.
    ///   - rhs: The second matrix to add.
    public static func +=(lhs: inout Matrix<Scalar>, rhs: Matrix<Scalar>) {
        lhs = lhs + rhs
    }
    
    /// Subtracts one vector from another and produces their difference.
    ///
    ///
    /// - Parameters:
    ///   - lhs: A vector.
    ///   - rhs: The vector to subtract from `lhs`.
    public static func -(lhs: Matrix<Scalar>, rhs: Matrix<Scalar>) -> Matrix<Scalar> {
        return lhs + (-rhs)
    }
    
    /// Subtracts the second vector from the first and stores the difference in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: A vector and store subtraction.
    ///   - rhs: The vector to subtract from `lhs`.
    public static func -=(lhs: inout Matrix<Scalar>, rhs: Matrix<Scalar>) {
        lhs = lhs - rhs
    }
}

extension Matrix {
    //MARK: - Scalar Multiplication
        
    /// Multiplies a matrix and a scalar (Numeric) and produces their product.
    ///
    /// - Parameters:
    ///   - lhs: The matrix to multiply.
    ///   - rhs: The scalar to multiply.
    public static func *(lhs: Matrix<Scalar>, rhs: Scalar) -> Matrix<Scalar> {
        return lhs.scale(by: rhs)
    }
    
    /// Multiplies a matrix and a scalar (Numeric) and produces their product.
    ///
    /// - Parameters:
    ///   - lhs: The matrix to multiply.
    ///   - rhs: The scalar to multiply.
    public static func *(lhs: Scalar, rhs: Matrix<Scalar>) -> Matrix<Scalar> {
        return rhs.scale(by: lhs)
    }
    
    /// Scales a matrix by the multiiplictive inverse of a scalar.
    ///
    /// - Parameters:
    ///   - lhs: The matrix to multiply.
    ///   - rhs: The scalar to divide by.
    public static func /(lhs: Matrix<Scalar>, rhs: Scalar) -> Matrix<Scalar> {
        return lhs.scale(by: 1/rhs)
    }
    
    //MARK: Matrix Multiplication
    /// Multiplies a matrix and a matrix (Numeric)
    ///
    /// - Parameters:
    ///   - lhs: The first matrix to multiply.
    ///   - rhs: The second matrix to multiply.
    public static func *(lhs: Matrix<Scalar>, rhs: Matrix<Scalar>) -> Matrix<Scalar> {
        precondition(lhs.columns == rhs.rows, "lhs must have the same number of columns as rhs has rows.")
        
        var result: Matrix = Matrix<Scalar>(m: lhs.rows, n: rhs.columns)
        
        for row in 0..<lhs.rows {
            for col in 0..<rhs.columns {
                var sum: Scalar = 0
                
                for i in 0..<lhs.columns {
                    sum += lhs[row, i] * rhs[i, col]
                }
                
                result[row, col] = sum
            }
        }
        
        return result
    }
}

//MARK: - Row/Col Operations
extension Matrix {
    //MARK: Swap
    public func swap(row: Int, with other: Int) -> Matrix<Scalar> {
        var result: Matrix = self
        result[row: row] = self[row: other]
        result[row: other] = self[row: row]
        return result
    }
    
    public func swap(col: Int, with other: Int) -> Matrix<Scalar> {
        var result: Matrix = self
        result[col: col] = self[col: other]
        result[col: other] = self[col: col]
        return result
    }
    
    //MARK: Add
    public func add(row: Int, with other: Int) -> Matrix<Scalar> {
        var result: Matrix = self
        result[row: row] = self[row: row] + self[row: other]
        return result
    }
    
    public func add(col: Int, with other: Int) -> Matrix<Scalar> {
        var result: Matrix = self
        result[col: col] = self[col: col] + self[col: other]
        return result
    }
    
    //MARK: Subtraction
    public func subtract(row: Int, with other: Int) -> Matrix<Scalar> {
        var result: Matrix = self
        result[row: row] = self[row: row] - self[row: other]
        return result
    }
    
    public func subtract(col: Int, with other: Int) -> Matrix<Scalar> {
        var result: Matrix = self
        result[col: col] = self[col: col] - self[col: other]
        return result
    }
    
    //MARK: Multiplication
    public func multiply(row: Int, by scalar: Scalar) -> Matrix<Scalar> {
        var result: Matrix = self
        
        for col in 0..<columns {
            result[row, col] = self[row, col] * scalar
        }
        
        return result
    }
    
    public func multiply(col: Int, by scalar: Scalar) -> Matrix<Scalar> {
        var result: Matrix = self
        
        for row in 0..<rows {
            result[row, col] = self[row, col] * scalar
        }
        
        return result
    }
    
    public func multiply(row: Int, with other: Int) -> Matrix<Scalar> {
        var result: Matrix = self
        
        for col in 0..<columns {
            result[row, col] = self[row, col] * self[other, col]
        }
        
        return result
    }
    
    public func multiply(col: Int, with other: Int) -> Matrix<Scalar> {
        var result: Matrix = self
        
        for row in 0..<rows {
            result[row, col] = self[row, col] * self[row, other]
        }
        
        return result
    }
}

//MARK: - Gaussian Elimination
extension Matrix {
    //TODO:
    /// Gaussian Elimination
    ///
    ///     ⎡1, 2, 1⎤   ⎡2⎤
    ///     ⎢2, 6, 1⎥ = ⎢7⎥
    ///     ⎣1, 1, 4⎦   ⎣3⎦
    ///
    ///     ⎡1, 2,  1⎤   ⎡2⎤
    ///     ⎢0, 2, -1⎥ = ⎢3⎥
    ///     ⎣1, 1,  4⎦   ⎣3⎦
    ///
    ///     ⎡1,  2,  1⎤   ⎡2⎤
    ///     ⎢0,  2, -1⎥ = ⎢3⎥
    ///     ⎣0, -1,  3⎦   ⎣3⎦
    ///
    ///     ⎡1, 2,  1 ⎤   ⎡ 2 ⎤
    ///     ⎢0, 2, -1 ⎥ = ⎢ 3 ⎥
    ///     ⎣0, 0, 5/2⎦   ⎣5/2⎦
    ///
    public func gaussianElimination(for matrix: Matrix<Scalar>) -> (upperTriangle: Matrix<Scalar>, equals: Matrix<Scalar>) {
        precondition(rows >= columns, "The number of rows (equations) must equal the number of columns (unknown variables)")
        
        var triangle: Matrix = self
        var equals: Matrix = matrix
        
        for column in 0..<(columns - 1) {
            //Tri = (column, coulumn)
            for row in (column + 1)..<rows {
                let mult = triangle[row, column] / triangle[column, column]
                triangle = triangle.multiply(row: column, by: mult)
                equals = equals.multiply(row: column, by: mult)
                
                triangle = triangle.subtract(row: row, with: column)
                equals = equals.subtract(row: row, with: column)
                
                triangle = triangle.multiply(row: column, by: 1/mult)
                equals = equals.multiply(row: column, by: 1/mult)
            }
        }
        
        return (upperTriangle: triangle, equals: equals)
    }
}
