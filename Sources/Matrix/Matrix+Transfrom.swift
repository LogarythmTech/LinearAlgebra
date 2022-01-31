// Matrix+Transform.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/MATH/blob/main/LICENSE for license information

//MARK: - Trasposition
extension Matrix {
    /// Turns the rows into columns and columns into rows.
    public func transpose() -> Matrix<Scalar> {
        var result: Matrix = Matrix<Scalar>(m: self.columns, n: self.rows)
        
        for row in 0..<rows {
            for col in 0..<columns {
                result[col, row] = self[row, col]
            }
        }
        
        return result
    }
}

//MARK: - Linear
extension Matrix {
    //TODO: Horizontal Shear
    //TODO: Reflection
    //TODO: Squeeze Mapping
    //MARK: Scaling
    /// Scales a matrix  by scalar (Numeric) and produces their product.
    ///
    /// - Parameters:
    ///   - scalar: The scalar to scale by.
    public func scale(by factor: Scalar) -> Matrix<Scalar> {
        var result: Matrix = self
        
        for row in 0..<rows {
            for col in 0..<columns {
                result[row, col] *= factor
            }
        }
        
        return result
    }
    
    //TODO: Rotation
}
