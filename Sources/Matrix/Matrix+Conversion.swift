// Matrix+Conversion.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/LinearAlgebra/blob/main/LICENSE for license information

//MARK: - String
//MARK: To String
extension String {
    /// A String that equates to the ASCII representation of a Matrix values.
    ///
    ///     ⎡1, 2, 3⎤
    ///     ⎢4, 5, 6⎥
    ///     ⎣7, 8, 9⎦
    ///
    /// - Parameters:
    ///    - m: A Matrix.
    public init<S: FloatingPoint>(_ m: Matrix<S>) {
        self = ""
        
        if(m.rows == 0 || m.columns == 0) {
            self = "[]"
            return
        }
        
        for row in 0..<m.rows {
            if(m.rows == 1) {
                self += "["
            } else if(row == 0) {
                self += "⎡"
            } else if(row == m.rows - 1) {
                self += "⎣"
            } else {
                self += "⎢"
            }
            
            
            for column in 0..<m.columns {
                if(column != 0) {
                    self += ", "
                }
                
                self += String("\(m[row, column])")
            }
            
            if(m.rows == 1) {
                self += "]"
            } else if(row == 0) {
                self += "⎤\n"
            } else if(row == m.rows - 1) {
                self += "⎦"
            } else {
                self += "⎥\n"
            }
        }
    }
}

extension Matrix: CustomStringConvertible {
    public var description: String {
        return String(self)
    }
}

extension Matrix: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Rows: \(rows), Columns: \(columns), Matrix: \n" + String(self)
    }
}

extension Matrix: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        return String(self)
    }
}
