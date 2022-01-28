// Vector+Arithmetic.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/LinearAlgebra/blob/main/LICENSE for license information

extension Vector {
    /// Replaces the values in the matrix with its additive inverse.
    public mutating func negate() {
        for i in 0..<dimensions {
            self[i].negate()
        }
    }
    
    /// Returns the additive inverse of the specified value.
    ///
    /// The negation operator (prefix `-`) returns the additive inverse of its
    /// argument.
    ///
    ///     let x = [1, -3, 2]
    ///     let y = -x
    ///     // y == -[1, -3, 2] == [-1, 3, -2]
    ///
    /// - Returns: The additive inverse of the argument.
    prefix public static func -(operand: Vector) -> Vector {
        var result = operand
        result.negate()
        return result
    }
    
    /// Returns the given number unchanged.
    ///
    /// - Returns: The given argument without any changes.
    prefix public static func +(operand: Vector) -> Vector {
        return operand
    }
}


extension Vector: AdditiveArithmetic {
    //MARK: - Addition
    /// Adds two vectors and produces their sum.
    ///
    /// The addition operator (`+`) calculates the sum of its two vectors by adding each aligning component . For example:
    ///
    ///     <1, 2> + <3, 5> = <1 + 3, 2 + 5> = <4, 7>
    ///
    /// - Parameters:
    ///   - lhs: The first vector to add.
    ///   - rhs: The second vector to add.
    /// - Returns: The sum of two vectors, `lhs` and `rhs`
    public static func +(lhs: Vector<Scalar>, rhs: Vector<Scalar>) -> Vector<Scalar> {
        var result: Vector = Vector<Scalar>()
        
        for i in 0..<max(lhs.dimensions, rhs.dimensions) {
            print(lhs[i], rhs[i])
            result[i] = lhs[i] + rhs[i]
        }
        
        return result
    }
    
    /// Adds two vectors and stores the result in the left-hand-side variable.
    ///
    /// The sum of the two arguments must be representable in the arguments' type.
    ///
    /// - Parameters:
    ///   - lhs: The first vector to add and store sum.
    ///   - rhs: The second vector to add.
    public static func +=(lhs: inout Vector<Scalar>, rhs: Vector<Scalar>) {
        lhs = lhs + rhs
    }
    
    //MARK: - Subtraction
    /// Subtracts one vector from another and produces their difference.
    ///
    /// The subtraction operator (`-`) calculates the difference of the aligning components. For example:
    ///
    ///     <1, 2> - <3, 5> = <1 - 3, 2 - 5> = <-2, -3>
    ///
    /// - Parameters:
    ///   - lhs: A vector.
    ///   - rhs: The vector to subtract from `lhs`.
    public static func -(lhs: Vector<Scalar>, rhs: Vector<Scalar>) -> Vector<Scalar> {
        var result: Vector = Vector<Scalar>()
        
        for i in 0..<max(lhs.dimensions, rhs.dimensions) {
            result[i] = lhs[i] - rhs[i]
        }
        
        return result
    }
    
    /// Subtracts the second vector from the first and stores the difference in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: A vector and store subtraction.
    ///   - rhs: The vector to subtract from `lhs`.
    public static func -=(lhs: inout Vector<Scalar>, rhs: Vector<Scalar>) {
        lhs = lhs - rhs
    }
}

extension Vector {
    //MARK: - Multiplication
    public func scale(by scalar: Scalar) -> Vector<Scalar> {
        return self * scalar
    }
    
    /// Multiplies a vector and a scalar (Numeric) and produces their product.
    ///
    /// The multiplication operator (`*`) calculates the product of each vector component by the scalar. For example:
    ///
    ///     <2, 5, 3> * 3 = <2*3, 5*3, 3*3> = <6, 15, 9>
    ///
    /// - Parameters:
    ///   - lhs: The vector to multiply.
    ///   - rhs: The scalar to multiply.
    public static func *(lhs: Vector<Scalar>, rhs: Scalar) -> Vector<Scalar> {
        var result: Vector = Vector<Scalar>()
        
        for i in 0..<lhs.dimensions {
            result[i] = lhs[i] * rhs
        }
        
        return result
    }
    
    /// Multiplies a vector and a scalar (Numeric) and produces their product.
    ///
    /// The multiplication operator (`*`) calculates the product of each vector component by the scalar. For example:
    ///
    ///     3 * <2, 5, 3> = <2*3, 5*3, 3*3> = <6, 15, 9>
    ///
    /// - Parameters:
    ///   - lhs: The scalar to multiply.
    ///   - rhs: The vector to multiply.
    public static func *(lhs: Scalar, rhs: Vector<Scalar>) -> Vector<Scalar> {
        var result: Vector = Vector<Scalar>()
        
        for i in 0..<rhs.dimensions {
            result[i] = lhs * rhs[i]
        }
        
        return result
    }
    
    /// Multiplies a vector by a scalar and stores the result in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: The vector multiply.
    ///   - rhs: The scalar to multiply.
    public static func *=(lhs: inout Vector<Scalar>, rhs: Scalar) {
        lhs = lhs * rhs
    }
    
    //MARK: - Divison
    /// Divides a vector by a scalar (Numeric) and produces their product.
    ///
    ///     <2, 5, 3> / 3 = <2/3, 5/3, 3/3> = <0.66, 1.66, 1>
    ///
    /// - Parameters:
    ///   - lhs: The vector to multiply.
    ///   - rhs: The scalar to multiply.
    public static func /(lhs: Vector<Scalar>, rhs: Scalar) -> Vector<Scalar> {
        var result: Vector = Vector<Scalar>()
        
        for i in 0..<lhs.dimensions {
            result[i] = lhs[i] / rhs
        }
        
        return result
    }
    
    /// Divides a vector and a scalar (Numeric).
    ///
    ///     3 / <2, 5, 3> = <3/2, 3/5, 3/3> = <1.5, 0.6, 1>
    ///
    /// - Parameters:
    ///   - lhs: The scalar to be divided.
    ///   - rhs: The vector to of which componets are to divide `lhs`.
    public static func /(lhs: Scalar, rhs: Vector<Scalar>) -> Vector<Scalar> {
        var result: Vector = Vector<Scalar>()
        
        for i in 0..<rhs.dimensions {
            result[i] = lhs / rhs[i]
        }
        
        return result
    }
    
    /// Divides a vector by a scalar and stores the result in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: The vector to be divided.
    ///   - rhs: The scalar to divide `lhs`.
    public static func /=(lhs: inout Vector<Scalar>, rhs: Scalar) {
        lhs = lhs / rhs
    }
    
    //TODO: - Modulus
}

infix operator •* : MultiplicationPrecedence
extension Vector {
    //MARK: - Dot Product
    /// Does the vector operation `Dot Product` on two vectors.
    ///
    /// A dot product is bilinear and commutaive (order does not matter).
    /// Returns a  `Zero` if other vector == 0. Orthogonal.
    ///
    /// - Parameters:
    ///   - lhs: The first vector.
    ///   - rhs: The second vector.
    /// - Returns a Scalar.
    /// - Note: The Parameters are bilinear and commutaive (order does not matter).
    /// - Note: If returns `zero` then `lhs` and `rhs` are orthogonal.
    public static func •*(lhs: Vector<Scalar>, rhs: Vector<Scalar>) -> Scalar {
        var sum: Scalar = 0
        
        //We can just look at the minimum of dimensions since any dimensions greater than the minimun whould be zero.
        //<1, 2> •* <3, 4, 5> = (1 * 3) + (2 * 4) + (0 * 5) = 3 + 8 + 0 = 11
        //<1, 2> •* <3, 4>    = (1 * 3) + (2 * 4)           = 3 + 8     = 11
        for i in 0..<min(lhs.dimensions, rhs.dimensions) {
            sum += lhs[i] * rhs[i]
        }
        
        return sum
    }
}

infix operator +* : MultiplicationPrecedence
extension Vector {
    //MARK: - Cross Product
    /// Returns the Cross Product of two vectors which is the orthogonal (perpendicular) vector of the two vectors.
    ///
    /// **Cordinate Definition:**
    ///
    ///                ⎡ î,  ĵ,  k⎤
    ///     a ⨯ b = det⎜a₁, a₂, a₃⎟ = (a₂b₃ - a₃b₂)î - (a₁b - a₃b₁)ĵ + (a₁b₂ - a₂b₁)k
    ///                ⎣b₁, b₂, b₃⎦
    ///
    /// **Geometric Definition:**
    ///
    ///     a ⨯ b = [|a||b|sin(θ)]n \\where `n` is length and direction given by the righ hand rule
    ///
    /// - Parameters:
    ///   - lhs: The first vector.
    ///   - rhs: The second vector.
    /// - Returns: A vector that is orthogonal to both`lhs` and `rhs`. With the magnitude being the Area of the parallelogram created by the vectors `lhs` and `rhs`.
    /// - Note: The parameters are bilinear and anit-communative (order matters) `a +* b = -(b +* a)`
    /// - Note: If returns `zero` then `lhs` and `rhs` are parallel.
    public static func +*(lhs: Vector<Scalar>, rhs: Vector<Scalar>) -> Vector<Scalar> {
        //TODO: Vecotr Cross Pruduct in different dimensions
        assert(lhs.compactDimensions <= 3 && rhs.compactDimensions <= 3, "To do a cross product, both vectors must be 3D or 2D")
        
        var result: Vector = Vector<Scalar>()
        
        result.x = (lhs.y * rhs.z) - (lhs.z * rhs.y)
        result.y = (lhs.z * rhs.x) - (lhs.x * rhs.z)
        result.z = (lhs.x * rhs.y) - (lhs.y * rhs.x)
        
        return result
    }
}
