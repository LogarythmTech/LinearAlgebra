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
    prefix public static func -(operand: Matrix) -> Matrix {
        var result = operand
        result.negate()
        return result
    }
    
    /// Returns the given number unchanged.
    ///
    /// - Returns: The given argument without any changes.
    prefix public static func +(operand: Matrix) -> Matrix {
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
    public static func +(lhs: Matrix<Scalar>, rhs: Matrix<Scalar>) -> Matrix<Scalar> {
        var result: Matrix = Matrix<Scalar>()
        
        for row in 0..<max(lhs.rows, rhs.rows) {
            for col in 0..<max(lhs.columns, rhs.columns) {
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
        var result: Matrix = Matrix<Scalar>()
        
        for row in 0..<max(lhs.rows, rhs.rows) {
            for col in 0..<max(lhs.columns, rhs.columns) {
                result[row, col] = lhs[row, col] - rhs[row, col]
            }
        }
        
        return result
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
    //MARK: - Multiplication
    public func scale(by scalar: Scalar) -> Matrix<Scalar> {
        return self * scalar
    }
    
    /// Multiplies a matrix and a matrix (Numeric)
    ///
    /// - Parameters:
    ///   - lhs: The first matrix to multiply.
    ///   - rhs: The second matrix to multiply.
    public static func *(lhs: Matrix<Scalar>, rhs: Matrix<Scalar>) -> Matrix<Scalar> {
        var result: Matrix = Matrix<Scalar>()
        
        for row in 0..<lhs.rows {
            for col in 0..<rhs.columns {
                result[row, col] = 0
            }
        }
        
        return result
    }
    
    /// Multiplies a matrix and a scalar (Numeric) and produces their product.
    ///
    /// - Parameters:
    ///   - lhs: The matrix to multiply.
    ///   - rhs: The scalar to multiply.
    public static func *(lhs: Matrix<Scalar>, rhs: Scalar) -> Matrix<Scalar> {
        var result: Matrix = Matrix<Scalar>()
        
        for row in 0..<lhs.rows {
            for col in 0..<lhs.columns {
                result[row, col] = lhs[row, col] * rhs
            }
        }
        
        return result
    }
    
    /// Multiplies a matrix and a scalar (Numeric) and produces their product.
    ///
    /// - Parameters:
    ///   - lhs: The matrix to multiply.
    ///   - rhs: The scalar to multiply.
    public static func *(lhs: Scalar, rhs: Matrix<Scalar>) -> Matrix<Scalar> {
        var result: Matrix = Matrix<Scalar>()
        
        for row in 0..<rhs.rows {
            for col in 0..<rhs.columns {
                result[row, col] = lhs * rhs[row, col]
            }
        }
        
        return result
    }
}
