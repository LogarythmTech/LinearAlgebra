// Vector+Geometry.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/LinearAlgebra/blob/main/LICENSE for license information

extension Vector {
    //MARK: - OTher
    //TODO: Distance to
    //TODO: Angle to
    
    //MARK: - Parallel
    /// Determines if `self` and `other` are parallel to each other.
    ///
    /// `self` and `other` are parallel if `self +* other == 0`
    ///
    /// - Parameter other: The other vector to compare `self` with.
    /// - Returns: `true` if `self` and `other` are parallel.
    public func isParallel(to other: Vector<S>) -> Bool {
        let cross: Vector<S> = self +* other
        return cross == 0
    }
    
    //TODO: Anit-Parallel
    public func isAntiParallel(to other: Vector<S>) -> Bool {
        return false
    }
    
    
    //MARK: - Orthogonal
    /// Determines if `self` and `other` are orthogonal (perpendicular) to each other.
    ///
    /// `self` and `other` are orthogonal if `self •* other == 0`
    ///
    /// - Parameter other: The other vector to compare `self` with.
    /// - Returns: `true` is `self` and `other` are orthogonal.
    public func isOrthogonal(to other: Vector<S>) -> Bool {
        let dot: S = self •* other
        return dot == 0
    }
    
    //TODO: Return a Orthogonal Vector (s) to `self`
    
    
    //MARK: - Line
    //TODO: `self` lies on line
    
    //MARK: - Plane
    //TODO: `self` lies on Plane

    //MARK: - Parelogram
    /// The area of a parreleogram created by the two vectors `self` and `other`.
    public func areaOfParrelogram(with other: Vector<S>) -> S {
        return (self +* other).magnitude
    }
    
    /// The Volume of a parrelogram created by three vectors `self`, `a`, and `b`.
    public func volumeOfParrelogram(with a: Vector<S>, _ b: Vector<S>) -> S {
        return abs((self +* b) •* b)
    }
}
