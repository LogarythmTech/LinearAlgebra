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
    
    public init(singleRow row: [Scalar]) {
        let matrix: [[Scalar]] = [row]
        self.init(matrix)
    }
    
    public init(singleCol col: [Scalar]) {
        var matrix: [[Scalar]] = [[Scalar]]()
        
        for col in col {
            matrix.append([col])
        }
        
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
    
    //MARK: Static
    public static var zero: Matrix<Scalar> {
        return Matrix<Scalar>()
    }
}

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
            while(row < rows) {
                addRow()
            }
            
            while(column < columns) {
                addCol()
            }
            
            components[row][column] = newValue
        }
    }
    
    //MARK: Components on single column
    /// `{get set}` a subset of components on a single column.
    private subscript(rows: [Int], column: Int) -> Matrix<Scalar> {
        get {
            var result: [Scalar] = [Scalar]()
            
            for row in rows {
                result.append(self[row, column])
            }
            
            return Matrix<Scalar>(singleCol: result)
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
    private subscript(row: Int, columns: [Int]) -> Matrix<Scalar> {
        get {
            var result: [Scalar] = [Scalar]()
            
            for column in columns {
                result.append(self[row, column])
            }
            
            return Matrix<Scalar>(singleRow: result)
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
    private subscript(rows: [Int], columns: [Int]) -> Matrix<Scalar> {
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
