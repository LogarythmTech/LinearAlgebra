// Matrix+Subscript.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/LinearAlgebra/blob/main/LICENSE for license information


//MARK: - Getters and Setters
extension Matrix {
    /// `{get set}` individual components of the matrix.
    /// - Note: If `row` or `column` are out of range of the matrix. Returns zero.
    public subscript(row: Int, column: Int) -> Scalar {
        get {
            if(row < rows && column < columns) {
                return components[row][column]
            }
            
            return 0
        } set(newValue) {
            while(row >= rows) {
                addRow()
            }
            
            while(column >= columns) {
                addCol()
            }
            
            components[row][column] = newValue
        }
    }
    
    //MARK: Components on single column
    /// `{get set}` a subset of components on a single column.
    public subscript(rows: [Int], column: Int) -> Matrix<Scalar> {
        get {
            var result: [Scalar] = [Scalar]()
            
            for row in rows {
                result.append(self[row, column])
            }
            
            return Matrix<Scalar>(columnVector: result)
        } set(newValue) {
            precondition(newValue.columns == 1, "The new value must only have one column.")
            precondition(newValue.rows == rows.count, "The new value must have the same number of rows as the given range.")
            
            for row in rows {
                self[row, column] = newValue[row - (rows.first ?? 0), 0]
            }
        }
    }
    
    /// `{get set}` a subset of components on a single column.
    public subscript(rows: Range<Int>, column: Int) -> Matrix<Scalar> {
        get { return self[Array(rows), column] } set(newValue) { self[Array(rows), column] = newValue}
    }
    
    /// `{get set}` a subset of components on a single column.
    public subscript(rows: ClosedRange<Int>, column: Int) -> Matrix<Scalar> {
        get { return self[Array(rows), column] } set(newValue) { self[Array(rows), column] = newValue}
    }
    
    /// `{get set}` a subset of components on a single column.
    public subscript(rows: PartialRangeThrough<Int>, column: Int) -> Matrix<Scalar> {
        get { return self[0...rows.upperBound, column] } set(newValue) { self[0...rows.upperBound, column] = newValue}
    }
    
    /// `{get set}` a subset of components on a single column.
    public subscript(rows: PartialRangeUpTo<Int>, column: Int) -> Matrix<Scalar> {
        get { return self[0..<rows.upperBound, column] } set(newValue) { self[0..<rows.upperBound, column] = newValue}
    }
    
    /// `{get set}` a subset of components on a single column.
    public subscript(rows: PartialRangeFrom<Int>, column: Int) -> Matrix<Scalar> {
        get { return self[rows.lowerBound..<self.rows, column] } set(newValue) { self[rows.lowerBound..<self.rows, column] = newValue}
    }
    
    /// `{get set}` a column in the matrix
    public subscript(col column: Int) -> Matrix<Scalar> {
        get { return self[0..., column] } set(newValue) { self[0..., column] = newValue}
    }
    
    //MARK: Components on single row
    /// `{get set}` a subset of components on a row.
    public subscript(row: Int, columns: [Int]) -> Matrix<Scalar> {
        get {
            var result: [Scalar] = [Scalar]()
            
            for column in columns {
                result.append(self[row, column])
            }
            
            return Matrix<Scalar>(rowVector: result)
        } set(newValue) {
            precondition(newValue.rows == 1, "The new value must only have one row.")
            precondition(newValue.columns == columns.count, "The new value must have the same number of columns as the given range.")
            
            for column in columns {
                self[row, column] = newValue[0, column - (columns.first ?? 0)]
            }
        }
    }
    
    /// `{get set}` a subset of components on a row.
    public subscript(row: Int, columns: Range<Int>) -> Matrix<Scalar> {
        get { return self[row, Array(columns)] } set(newValue) { self[row, Array(columns)] = newValue }
    }
    
    /// `{get set}` a subset of components (from start to given) on a single row.
    public subscript(row: Int, columns: ClosedRange<Int>) -> Matrix<Scalar> {
        get { return self[row, Array(columns)] } set(newValue) { self[row, Array(columns)] = newValue }
    }
 
    /// `{get set}` a subset of components (from start to given) on a single row.
    public subscript(row: Int, columns: PartialRangeThrough<Int>) -> Matrix<Scalar> {
        get { return self[row, 0...columns.upperBound] } set(newValue) { self[row, 0...columns.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of components (from start to given) on a single row.
    public subscript(row: Int, columns: PartialRangeUpTo<Int>) -> Matrix<Scalar> {
        get { return self[row, 0..<columns.upperBound] } set(newValue) { self[row, 0..<columns.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of components (from given to end) on a single row.
    public subscript(row: Int, columns: PartialRangeFrom<Int>) -> Matrix<Scalar> {
        get { return self[row, columns.lowerBound..<self.columns] } set(newValue) { self[row, columns.lowerBound..<self.columns] = newValue }
    }
    
    /// `{get set}` a row in the matrix
    public subscript(row row: Int) -> Matrix<Scalar> {
        get { return self[row, 0...] } set(newValue) { self[row, 0...] = newValue }
    }
    
    //MARK: Components for smaller matrix
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: [Int], columns: [Int]) -> Matrix<Scalar> {
        get {
            var result: [[Scalar]] = [[Scalar]]()
            
            for row in rows {
                var resultRow: [Scalar] = [Scalar]()
                for column in columns {
                    resultRow.append(self[row, column])
                }
                result.append(resultRow)
            }
            
            return Matrix<Scalar>(result)
        } set(newValue) {
            precondition(newValue.rows == rows.count && newValue.columns == columns.count, "The newValue must be same size as the given ranges.")
            for row in rows {
                for column in columns {
                    self[row, column] = newValue[row - (rows.first ?? 0), column - (columns.first ?? 0)]
                }
            }
        }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: Range<Int>, columns: Range<Int>) -> Matrix<Scalar> {
        get { return self[Array(rows), Array(columns)] } set(newValue) { self[Array(rows), Array(columns)] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: Range<Int>, columns: ClosedRange<Int>) -> Matrix<Scalar> {
        get { return self[Array(rows), Array(columns)] } set(newValue) { self[Array(rows), Array(columns)] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: Range<Int>, columns: PartialRangeThrough<Int>) -> Matrix<Scalar> {
        get { return self[rows, 0...columns.upperBound] } set(newValue) { self[rows, 0...columns.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: Range<Int>, columns: PartialRangeUpTo<Int>) -> Matrix<Scalar> {
        get { return self[rows, 0..<columns.upperBound] } set(newValue) { self[rows, 0..<columns.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: Range<Int>, columns: PartialRangeFrom<Int>) -> Matrix<Scalar> {
        get { return self[rows, columns.lowerBound..<self.columns] } set(newValue) { self[rows, columns.lowerBound..<self.columns] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: ClosedRange<Int>, columns: Range<Int>) -> Matrix<Scalar> {
        get { return self[Array(rows), Array(columns)] } set(newValue) { self[Array(rows), Array(columns)] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: ClosedRange<Int>, columns: ClosedRange<Int>) -> Matrix<Scalar> {
        get { return self[Array(rows), Array(columns)] } set(newValue) { self[Array(rows), Array(columns)] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: ClosedRange<Int>, columns: PartialRangeThrough<Int>) -> Matrix<Scalar> {
        get { return self[rows, 0...columns.upperBound] } set(newValue) { self[rows, 0...columns.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: ClosedRange<Int>, columns: PartialRangeUpTo<Int>) -> Matrix<Scalar> {
        get { return self[rows, 0..<columns.upperBound] } set(newValue) { self[rows, 0..<columns.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: ClosedRange<Int>, columns: PartialRangeFrom<Int>) -> Matrix<Scalar> {
        get { return self[rows, columns.lowerBound..<self.columns] } set(newValue) { self[rows, columns.lowerBound..<self.columns] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeThrough<Int>, columns: Range<Int>) -> Matrix<Scalar> {
        get { return self[0...rows.upperBound, columns] } set(newValue) { self[0...rows.upperBound, columns] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeThrough<Int>, columns: ClosedRange<Int>) -> Matrix<Scalar> {
        get { return self[0...rows.upperBound, columns] } set(newValue) { self[0...rows.upperBound, columns] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeThrough<Int>, columns: PartialRangeThrough<Int>) -> Matrix<Scalar> {
        get { return self[rows, 0...columns.upperBound] } set(newValue) { self[rows, 0...columns.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeThrough<Int>, columns: PartialRangeUpTo<Int>) -> Matrix<Scalar> {
        get { return self[rows, 0..<columns.upperBound] } set(newValue) { self[rows, 0..<columns.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeThrough<Int>, columns: PartialRangeFrom<Int>) -> Matrix<Scalar> {
        get { return self[rows, columns.lowerBound..<self.columns] } set(newValue) { self[rows, columns.lowerBound..<self.columns] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeUpTo<Int>, columns: Range<Int>) -> Matrix<Scalar> {
        get { return self[0..<rows.upperBound, columns] } set(newValue) { self[0..<rows.upperBound, columns] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeUpTo<Int>, columns: ClosedRange<Int>) -> Matrix<Scalar> {
        get { return self[0..<rows.upperBound, columns] } set(newValue) { self[0..<rows.upperBound, columns] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeUpTo<Int>, columns: PartialRangeThrough<Int>) -> Matrix<Scalar> {
        get { return self[rows, 0...columns.upperBound] } set(newValue) { self[rows, 0...columns.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeUpTo<Int>, columns: PartialRangeUpTo<Int>) -> Matrix<Scalar> {
        get { return self[rows, 0..<columns.upperBound] } set(newValue) { self[rows, 0..<columns.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeUpTo<Int>, columns: PartialRangeFrom<Int>) -> Matrix<Scalar> {
        get { return self[rows, columns.lowerBound..<self.columns] } set(newValue) { self[rows, columns.lowerBound..<self.columns] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeFrom<Int>, columns: Range<Int>) -> Matrix<Scalar> {
        get { return self[rows.lowerBound..<self.rows, columns] } set(newValue) { self[rows.lowerBound..<self.rows, columns] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeFrom<Int>, columns: ClosedRange<Int>) -> Matrix<Scalar> {
        get { return self[rows.lowerBound..<self.rows, columns] } set(newValue) { self[rows.lowerBound..<self.rows, columns] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeFrom<Int>, columns: PartialRangeThrough<Int>) -> Matrix<Scalar> {
        get { return self[rows, 0...columns.upperBound] } set(newValue) { self[rows, 0...columns.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeFrom<Int>, columns: PartialRangeUpTo<Int>) -> Matrix<Scalar> {
        get { return self[rows, 0..<columns.upperBound] } set(newValue) { self[rows, 0..<columns.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of rows and a subset of colmns in the matrix.
    public subscript(rows: PartialRangeFrom<Int>, columns: PartialRangeFrom<Int>) -> Matrix<Scalar> {
        get { return self[rows, columns.lowerBound..<self.columns] } set(newValue) { self[rows, columns.lowerBound..<self.columns] = newValue }
    }
    
    /// `{get set}` a subset of diagonal (left to right) entrices in the matrix.
    public subscript(diag diag: [Int]) -> [Scalar] {
        get {
            var diagonal: [Scalar] = [Scalar]()
            
            for i in diag {
                diagonal.append(self[i, i])
            }
            
            return diagonal
        } set {
            precondition(diag.count == newValue.count, "newValue should be the same size as range.")
            
            var index: Int = 0
            for i in diag {
                self[i, i] = newValue[index]
                index += 1
            }
        }
    }
    
    /// `{get set}` a subset of diagonal (left to right) entrices in the matrix.
    public subscript(diag diag: Range<Int>) -> [Scalar] {
        get { return self[diag: Array(diag)] } set { self[diag: Array(diag)] = newValue }
    }
    
    /// `{get set}` a subset of diagonal (left to right) entrices in the matrix.
    public subscript(diag diag: ClosedRange<Int>) -> [Scalar] {
        get { return self[diag: Array(diag)] } set { self[diag: Array(diag)] = newValue }
    }
    
    /// `{get set}` a subset of diagonal (left to right) entrices in the matrix.
    public subscript(diag diag: PartialRangeThrough<Int>) -> [Scalar] {
        get { return self[diag: 0...diag.upperBound] } set { self[diag: 0...diag.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of diagonal (left to right) entrices in the matrix.
    public subscript(diag diag: PartialRangeUpTo<Int>) -> [Scalar] {
        get { return self[diag: 0..<diag.upperBound] } set { self[diag: 0..<diag.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of diagonal (left to right) entrices in the matrix.
    public subscript(diag diag: PartialRangeFrom<Int>) -> [Scalar] {
        get { return self[diag: diag.lowerBound..<max(rows, columns)] } set { self[diag: diag.lowerBound..<max(rows, columns)] = newValue }
    }
    
    public var diagnal: [Scalar] {
        get { return self[diag: 0...] } set { self[diag: 0...] = newValue }
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
