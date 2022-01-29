// Scalar+Trigonometry.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/LinearAlgebra/blob/main/LICENSE for license information

extension Scalar {
    //MARK: - Angle
    /// Converts `self` to radians (assumes `self` to be in degrees)
    public func toRadians() -> Self {
        // self/360 = rad/2π
        // rad = 2π (self/360) = (2*π*self)/360 = (π*self)/180
        return (Self.pi*self) / (180)
    }
    
    //MARK: Degrees
    /// Converts `self` to degrees (assumes `self` to be in radians)
    public func toDegrees() -> Self {
        // deg/360 = self/2π
        // deg = 360(self/2π) = 180*self / π
        return (180*self) / (Self.pi)
    }
    
    //MARK: - Sine
    /// Takes the sine of `self`
    public func sin() -> Self {
        var sin = self
        sin = sin.truncatingRemainder(dividingBy: 2*Self.pi)
        
        var sum: Self = 0
        var pos: Bool = true
        
        var i: Int = 1
        while(i < 20) {
            if(pos) {
                sum += sin.power(of: i) / Self(i.factorial())
                pos = false
            } else {
                sum -= sin.power(of: i) / Self(i.factorial())
                pos = true
            }
            
            i += 2
        }
        
        return sum
    }
    
    /// Takse the arcsine of `self`
    public func asin() -> Self {
        return 1/sin()
    }
    
    //TODO: hyperbolic sine
    //TODO: arc hyperbolic sine
    
    //MARK: - Cosine
    /// Takse the cosine of `self`
    public func cos() -> Self {
        var cos = self
        cos = cos.truncatingRemainder(dividingBy: 2*Self.pi)
        
        var sum: Self = 0
        var pos: Bool = true
        
        var i: Int = 0
        while(i < 20) {
            if(pos) {
                sum += cos.power(of: i) / Self(i.factorial())
                pos = false
            } else {
                sum -= cos.power(of: i) / Self(i.factorial())
                pos = true
            }
            
            i += 2
        }
        
        return sum
    }
    
    /// Takse the arccosine of `self`
    public func acos() -> Self {
        return 1/cos()
    }
    
    //TODO: hyperbolic cosine
    //TODO: arc hyperbolic cosine
    
    //MARK: - Tangent
    /// Takse the tangent of `self`
    public func tan() -> Self {
        return sin()/cos()
    }
    
    /// Takse the arctangent of `self`
    public func atan() -> Self {
        return 1/tan()
    }
    
    //TODO: hyperbolic tangent
    //TODO: arc hyperbolic tangent
    
    //MARK: - Cotangent
    //TODO: cotangent (cot)
    //TODO: arc cotangent
    //TODO: hyperbolic cotangent
    //TODO: arc hyperbolic cotangent
    
    //MARK: - Secant
    //TODO: secant (sec)
    //TODO: arc secant
    //TODO: hyperbolic secant
    //TODO: arc hyperbolic secant
    
    //MARK: - Cosecant
    //TODO: cosecant (csc)
    //TODO: arc cosecant
    //TODO: hyperbolic cosecant
    //TODO: arc hyperbolic cosecant
}
