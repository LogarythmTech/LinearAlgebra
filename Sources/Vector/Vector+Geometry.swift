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
    public func isParallel(to other: Vector<Scalar>) -> Bool {
        let cross: Vector<Scalar> = self +* other
        return false //FIXME: cross == 0 !! Allow Vector Equatable with scalar
    }
    
    //TODO: Anit-Parallel
    public func isAntiParallel(to other: Vector<Scalar>) -> Bool {
        return false
    }
    
    //TODO: Return a parallel Vector (s) to `self`
    
    //MARK: - Orthogonal
    /// Determines if `self` and `other` are orthogonal (perpendicular) to each other.
    ///
    /// `self` and `other` are orthogonal if `self •* other == 0`
    ///
    /// - Parameter other: The other vector to compare `self` with.
    /// - Returns: `true` is `self` and `other` are orthogonal.
    public func isOrthogonal(to other: Vector<Scalar>) -> Bool {
        let dot: Scalar = self •* other
        return dot == 0
    }
    
    //TODO: Return a Orthogonal Vector (s) to `self`
    
    
    //MARK: - Line
    //TODO: `self` lies on line
    
    //MARK: - Plane
    //TODO: `self` lies on Plane

    //MARK: Parelogram
    //TODO: Area of parrelogram -> |a⨯b|
    //TODO: Volume of parrelogram -> |(a⨯b)•c|
}
