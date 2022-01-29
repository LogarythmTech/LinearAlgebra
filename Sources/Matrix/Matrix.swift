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
            self[1, i] = row[i]
        }
    }
    
    /// A column vector. (There is only one column in the matrix)
    public init(columnVector col: [Scalar]) {
        self.init(m: col.count, n: 1)
        
        for i in 0..<col.count {
            self[i, 1] = col[i]
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
