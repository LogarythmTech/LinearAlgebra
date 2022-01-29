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
    /// - Note: If `lhs` has different coordinate system then `rhs`, matches `rhs` coordinate sytems with `lhs`
    public static func +(lhs: Vector<S>, rhs: Vector<S>) -> Vector<S> {
        let coordSystem: CoordinateSystem = lhs.coordinateSystem
        let left: Vector = lhs.toCoordinateSystem(coordSystem)
        let right: Vector = rhs.toCoordinateSystem(coordSystem)
        var result: Vector = Vector<S>(coordinateSystem: coordSystem)
        
        for i in 0..<max(left.dimensions, right.dimensions) {
            result[i] = left[i] + right[i]
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
    /// - Note: If `lhs` has different coordinate system then `rhs`, matches `rhs` coordinate sytems with `lhs`
    public static func +=(lhs: inout Vector<S>, rhs: Vector<S>) {
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
    /// - Note: If `lhs` has different coordinate system then `rhs`, matches `rhs` coordinate sytems with `lhs`
    public static func -(lhs: Vector<S>, rhs: Vector<S>) -> Vector<S> {
        let coordSystem: CoordinateSystem = lhs.coordinateSystem
        let left: Vector = lhs.toCoordinateSystem(coordSystem)
        let right: Vector = rhs.toCoordinateSystem(coordSystem)
        
        var result: Vector = Vector<S>(coordinateSystem: coordSystem)
        
        for i in 0..<max(left.dimensions, right.dimensions) {
            result[i] = left[i] - right[i]
        }
        
        return result
    }
    
    /// Subtracts the second vector from the first and stores the difference in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: A vector and store subtraction.
    ///   - rhs: The vector to subtract from `lhs`.
    /// - Note: If `lhs` has different coordinate system then `rhs`, matches `rhs` coordinate sytems with `lhs`
    public static func -=(lhs: inout Vector<S>, rhs: Vector<S>) {
        lhs = lhs - rhs
    }
}

extension Vector {
    //MARK: - Multiplication
    public func scale(by scalar: S) -> Vector<S> {
        switch coordinateSystem {
        case .Cartesian:
            var result: Vector = Vector<S>(coordinateSystem: .Cartesian)
            
            for i in 0..<dimensions {
                result[i] *= scalar
            }
            
            return result
        case .PolarSpherical:
            var result: Vector = self
            result[0] *= scalar
            return result
        case .PolarCylindrical:
            var result: Vector = Vector<S>(coordinateSystem: .PolarCylindrical)
            
            for i in 0..<dimensions {
                if(i != 1) {
                    result[i] *= scalar
                }
            }
            
            return result
        }
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
    public static func *(lhs: Vector<S>, rhs: S) -> Vector<S> {
        return lhs.scale(by: rhs)
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
    public static func *(lhs: S, rhs: Vector<S>) -> Vector<S> {
        return rhs.scale(by: lhs)
    }
    
    /// Multiplies a vector by a scalar and stores the result in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: The vector multiply.
    ///   - rhs: The scalar to multiply.
    public static func *=(lhs: inout Vector<S>, rhs: S) {
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
    public static func /(lhs: Vector<S>, rhs: S) -> Vector<S> {
        return lhs.scale(by: 1/rhs)
    }
    
    /// Divides a vector by a scalar and stores the result in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: The vector to be divided.
    ///   - rhs: The scalar to divide `lhs`.
    public static func /=(lhs: inout Vector<S>, rhs: S) {
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
    ///   - rhs: The vector on the right side of the operation.
    /// - Returns a Scalar.
    /// - Note: The Parameters are bilinear and commutaive (order does not matter).
    /// - Note: If returns `zero` then `self` and `rhs` are orthogonal.
    /// - Note: Converts both `lhs` and `rhs` to cartesian coordinate system first.
    public func dotProduct(for rhs: Vector<S>) -> S {
        let left: Vector = self.cartesianVector
        let right: Vector = rhs.cartesianVector
        var sum: S = 0
        
        //We can just look at the minimum of dimensions since any dimensions greater than the minimun whould be zero.
        //<1, 2> •* <3, 4, 5> = (1 * 3) + (2 * 4) + (0 * 5) = 3 + 8 + 0 = 11
        //<1, 2> •* <3, 4>    = (1 * 3) + (2 * 4)           = 3 + 8     = 11
        for i in 0..<min(left.dimensions, right.dimensions) {
            sum += left[i] * right[i]
        }
        
        return sum
    }
    
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
    /// - Note: Converts both `lhs` and `rhs` to cartesian coordinate system first.
    public static func •*(lhs: Vector<S>, rhs: Vector<S>) -> S {
        return lhs.dotProduct(for: rhs)
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
    ///   - rhs: The vector on the right side of the operation.
    /// - Returns: A vector that is orthogonal to both`self` and `rhs`. With the magnitude being the Area of the parallelogram created by the vectors `self` and `rhs`.
    /// - Note: The parameters are bilinear and anit-communative (order matters) `a +* b = -(b +* a)`
    /// - Note: If returns `zero` then `self` and `rhs` are parallel.
    /// - Note: Converts both `self` and `rhs` to cartesian coordinate system first, then converts them back to `self` coordinate sytem.
    public func crossProduct(for rhs: Vector<S>) -> Vector<S> {
        //TODO: Vecotr Cross Pruduct in different dimensions
        assert(self.compactDimensions <= 3 && rhs.compactDimensions <= 3, "To do a cross product, both vectors must be 3D or 2D")
        
        let left: Vector = self.cartesianVector
        let right: Vector = rhs.cartesianVector
        
        var result: Vector = Vector<S>(coordinateSystem: .Cartesian)
        
        result.x = (left.y * right.z) - (left.z * right.y)
        result.y = (left.z * right.x) - (left.x * right.z)
        result.z = (left.x * right.y) - (left.y * right.x)
        
        return result.toCoordinateSystem(coordinateSystem)
    }
    
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
    ///   - rhs: The vector on the right side of the operation.
    /// - Returns: A vector that is orthogonal to both`lhs` and `rhs`. With the magnitude being the Area of the parallelogram created by the vectors `self` and `rhs`.
    /// - Note: The parameters are bilinear and anit-communative (order matters) `a +* b = -(b +* a)`
    /// - Note: If returns `zero` then `lhs` and `rhs` are parallel.
    /// - Note: Converts both `lhs` and `rhs` to cartesian coordinate system first, then converts them back to `lhs` coordinate sytem.
    public static func +*(lhs: Vector<S>, rhs: Vector<S>) -> Vector<S> {
        return lhs.crossProduct(for: rhs)
    }
}
