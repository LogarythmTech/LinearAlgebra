// Vector.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/LinearAlgebra/blob/main/LICENSE for license information

//TODO: Vector Function?

/// A `Vector` is a mathematical way to discribe both a magnitude and a direction.
public struct Vector<Scalar: FloatingPoint> {
    
    /// The `components` are how much the vecotor point's in each direction `(x, y, z, w,...)`
    public var components: [Scalar]
    
    public init(_ vector: [Scalar]) {
        self.components = vector
    }
}

//MARK: - Additional Initializers
extension Vector {
    /// A Defult initializers the equates to 0
    public init() {
        let vector: [Scalar] = Array(repeating: 0, count: 2)
        self.init(vector)
    }
    
    /// A Vector that equates to 0, with different dimension sizes.
    public init(dimensions: Int) {
        let vector: [Scalar] = Array(repeating: 0, count: dimensions)
        self.init(vector)
    }
}

// MARK: - Basic properties
extension Vector {
    /// The number of dimensions (the number of elements) in the `Vector`.
    public var dimensions: Int {
        get {
            return components.count
        } set(newValue) {
            while(components.count < newValue) {
                components.append(0)
            }
            
            while(components.count > 0 && components.count > newValue) {
                components.removeLast()
            }
        }
    }
    
    /// The number of dimensions, where it discludes the trailing zeros.
    ///
    /// For Example:
    ///
    ///     <1, 2, 0, 0, 0>.compactDimensions   //= 2 (2D)
    ///     <0, 0, 3>.compactDimensions         //= 3 (3D)
    ///     <1, 2, 0, 0, 3>.compactDimensions   //= 5 (5D)
    public var compactDimensions: Int {
        var countTrailingZeros: Int = 0
        
        for component in components.reversed() {
            if(component == 0) {//Component is a Trailing Zero
                countTrailingZeros += 1
            } else { //Component is not a trailing zero
                break
            }
        }
        
        return dimensions - countTrailingZeros
    }
    
    /// The magnitude of the vector squared.
    ///
    ///     ⟨1, 2, 3⟩.magnitude        = √(1^2 + 2^2 + 3^2)
    ///     ⟨1, 2, 3⟩.magnitudeSquared = (1^2 + 2^2 + 3^2)
    ///
    public var magnitudeSquared: Scalar {
        var sum: Scalar = 0
        
        for component in components {
            sum += (component*component) //component^2
        }
        
        return sum
    }
    
    /// The magnitude of the vector
    ///
    ///     ⟨1, 2, 3⟩.magnitudeSquared = (1^2 + 2^2 + 3^2)
    ///     ⟨1, 2, 3⟩.magnitude        = √(1^2 + 2^2 + 3^2)
    ///                                = ⟨1, 2, 3⟩.magnitudeSquared.squareRoot()
    public var magnitude: Scalar {
        return magnitudeSquared.squareRoot()
    }
    
    /// The direction of the vector. Equivalant to the unit vector.
    public var direction: Vector<Scalar> {
        return unitVector
    }
    
    /// The angle of the vector in the (`x`, `y`) plane from orgin. Typically represented by θ.
    public var theta: Scalar {
        //return atan(y / x)
        //TODO: Trig Functions
        return 0
    }
    
    
    /// The angle of the vector between the (`x`, `y`) plane and the `z` axis. Typically represented by 𝛗.
    public var phi: Scalar {
        //return atan(z / √(x^2 + y^2))
        //TODO: Trig Functions
        return 0
    }
    
    /// A vecotor of same direction as `self` but with a magnitude of `1`.
    public var unitVector: Vector<Scalar> {
        var unit: Vector<Scalar> = [0]
        
        for i in 0..<dimensions {
            unit[i] = self[i] / magnitude
        }
        
        return Vector(dimensions: 2)
    }
    
    //MARK: Static
    /// Equates to a vector `<0, 0>`
    public static var zero: Vector<Scalar> {
        return Vector(dimensions: 2)
    }
}

//MARK: - Getters and Setters
extension Vector {
    /// `{get set}` a component in the `Vector` where the first component starts at `index: 0`.
    public subscript(index: Int) -> Scalar {
        get {
            return index < dimensions ? components[index] : 0
        } set(newValue) {
            //Add dimensions until index can fit in to components
            while(dimensions <= index) {
                dimensions += 1
            }
            
            components[index] = newValue
        }
    }
    
    /// `{get set}` a subset of components in the `Vector`.
    public subscript(indices: Range<Int>) -> Vector<Scalar> {
        get {
            var results: [Scalar] = [Scalar]()
            
            for index in indices {
                results.append(self[index])
            }
            
            return Vector<Scalar>(results)
        } set(newValue) {
            precondition(newValue.dimensions == indices.count, "The new value must have the same number of components (dimensions) as the given range.")
            
            for index in indices {
                self[index] = newValue[index - indices.lowerBound]
            }
        }
    }
    
    /// `{get set}` a subset of components in the `Vector`.
    public subscript(indices: ClosedRange<Int>) -> Vector<Scalar> {
        get { return self[indices.lowerBound..<(indices.upperBound + 1)] } set(newValue) { self[indices.lowerBound..<(indices.upperBound + 1)] = newValue }
    }
    
    /// `{get set}` a subset of components in the `Vector`.
    public subscript(indices: PartialRangeThrough<Int>) -> Vector<Scalar> {
        get { return self[0...indices.upperBound] } set(newValue) { self[0...indices.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of components in the `Vector`.
    public subscript(indices: PartialRangeUpTo<Int>) -> Vector<Scalar> {
        get { return self[0..<indices.upperBound] } set(newValue) { self[0..<indices.upperBound] = newValue }
    }
    
    /// `{get set}` a subset of components in the `Vector`.
    public subscript(indices: PartialRangeFrom<Int>) -> Vector<Scalar> {
        get { return self[indices.lowerBound..<dimensions] } set(newValue) { self[indices.lowerBound..<dimensions] = newValue }
    }
    
    /// `{get set}` the `x` component (or the first element) in the `Vector`.
    public var x: Scalar {
        get {
            return self[0]
        } set(newValue) {
            self[0] = newValue
        }
    }
    
    /// `{get set}` the  `y` component (or the second element) in the `Vector`.
    public var y: Scalar {
        get {
            return self[1]
        } set(newValue) {
            self[1] = newValue
        }
    }
    
    /// `{get set}` the  `Z` component (or the third element) in the `Vector`.
    public var z: Scalar {
        get {
            return self[2]
        } set(newValue) {
            self[2] = newValue
        }
    }
    
    /// `{get set}` the `w` component (or the fourth element) in the `Vector`.
    public var w: Scalar {
        get {
            return self[3]
        } set(newValue) {
            self[3] = newValue
        }
    }
}
