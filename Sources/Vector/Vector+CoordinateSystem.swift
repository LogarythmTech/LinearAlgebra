// Vector+CoordinateSystem.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/MATH/blob/main/LICENSE for license information

extension Vector {
    /// Allows for components to store either Cartesian Coordinates or Polar Coordinates.
    ///
    /// Does this so that the numbers defined in components are precise. For example in a Polar Coordinates, r and θ are precise where as `x` and `y` whould be approxamations.
    public enum CoordinateSystem {
        /// Cartesian Corrdinate System
        case Cartesian
        
        /// Polar Spherical Coordinates Has a radius `r` of the sphere and angles (`θ`, `𝛗`, ...) to define the point on shere.
        ///
        /// [hyperspherical coordinates](https://en.wikipedia.org/wiki/N-sphere#Spherical_coordinates)
        case PolarSpherical
        
        /// Polar Cylindrical. Where it starts with (`r`, `θ`) then goes back to Cartesian starting with (`z`, `w`...)
        case PolarCylindrical
        
        //TODO: Other commonoly used coordinate systems?
        //https://en.wikipedia.org/wiki/Coordinate_system
    }
    
    public func toCoordinateSystem(_ coordinateSystem: CoordinateSystem) -> Vector<S> {
        switch coordinateSystem {
        case .Cartesian:
            return self.cartesianVector
        case .PolarSpherical:
            return self.sphericalVector
        case .PolarCylindrical:
            return self.cylindricalVector
        }
    }
}

//MARK: - Cartesian
extension Vector {
    public init(x: S, y: S, z: S = 0, w: S = 0) {
        self.init([x, y, z, w], corrdinateSystem: .Cartesian)
    }
    
    /// `{get set}` a cartesian components in the `Vector` where `0` is the first dimension.
    public subscript(cartesian dimension: Int) -> S {
        get {
            precondition(dimension >= 0, "Dimension must be positive.")
            guard dimension < dimensions else {
                return 0
            }
            
            //index is in components
            switch coordinateSystem {
            case .Cartesian:
                return self[dimension]
            case .PolarCylindrical:
                //Since after the first two dimensions (`r` and `θ`) Cylindrical Polar is the same as Cartesian (`z`, `w`,...) we can just return the component at index
                if(dimension >= 2) {
                    return self[dimension]
                }
                
                guard dimensions >= 2 else {
                    //dimensions == 1
                    return self[0]
                }
                
                //r = components[0]
                //θ = components[1]
                if(dimension == 0) {//getting x
                    return self[0] * self[1].cos()
                } else { //getting y
                    return self[0] * self[1].sin()
                }
            case .PolarSpherical:
                //r = components[0]
                //θ = components[1]
                //𝛗 = components[2]
                guard dimensions >= 2 else {
                    return self[0]
                }
                
                var trig: S = self[0]
                
                //Small Check to improve iffeciency
                if(trig == 0) {
                    return 0
                }
                
                /*
                 For n dimensions, components = [r, θ, 𝛗₁, 𝛗₂,...,𝛗ₙ₋₃, 𝛗ₙ₋₂]
                 x = r sin(𝛗ₙ₋₂)sin(𝝋ₙ₋₃)...sin(𝛗₁)sin(θ)
                 y = r sin(𝛗ₙ₋₂)sin(𝝋ₙ₋₃)...sin(𝛗₁)cos(θ)
                 z = r sin(𝛗ₙ₋₂)sin(𝝋ₙ₋₃)...sin(𝛗₂)cos(𝝋₁)
                 w = r sin(𝛗ₙ₋₂)sin(𝝋ₙ₋₃)...sin(𝛗₃)cos(𝛗₂)
                 ⋮ ⋮ = ⋮ ⋮
                 dₙ₋₁ = r sin(𝛗ₙ₋₂)cos(𝛗ₙ₋₃)
                 dₙ  = r cos(𝛗ₙ₋₂)
                 */
                if(dimension == 0) {
                    trig *= self[1].cos()
                } else if(dimension == 1) {
                    trig *= self[1].sin() //θ
                } else {
                    // index == 0: cos(θ)
                    // index == 2: cos(𝛗ₙ₋₂)
                    // index == 3: cos(𝛗ₙ₋₃)
                    trig *= self[dimension].cos()
                }
                
                //Small Check to improve iffeciency
                if(trig == 0) {
                    return 0
                }
                
                //For index 0: start = 2
                //For index 1: start = 2
                //For index 2: start = 3
                //For index 3: start = 4
                let startIndex = (dimension == 0 ? 2 : dimension + 1)
                if(startIndex < dimensions) {
                    for angle in startIndex..<dimensions {
                        trig *= self[angle].sin()
                    }
                }
                
                return trig
            }
        } set(newCoordinate) {
            precondition(dimension >= 0, "Dimension has to be positive.")
            
            switch coordinateSystem {
            case .Cartesian:
                self[dimension] = newCoordinate
            case .PolarCylindrical:
                var cartesianV: Vector = self.cartesianVector
                cartesianV[dimension] = newCoordinate
                self = cartesianV.cylindricalVector
            case .PolarSpherical:
                var cartesianV: Vector = self.cartesianVector
                cartesianV[dimension] = newCoordinate
                self = cartesianV.sphericalVector
            }
        }
    }
    
    /// `{get}` The Vector in Cartesian Corrdinates.
    public var cartesianVector: Vector<S> {
        switch coordinateSystem {
        case .Cartesian:
            return self
        default:
            var v: Vector = Vector<S>([0], corrdinateSystem: .Cartesian)
            
            for i in 0..<dimensions {
                v[i] = self[cartesian: i]
            }
            
            return v
        }
    }
    
    /// `{get set}` The `x` component of the `Vector` in cartesian corrdinates.
    public var x: S {
        get { return self[cartesian: 0] } set { self[cartesian: 0] = newValue }
    }
    
    /// `{get set}` The `y` component of the the `Vector` in cartesian corrdinates.
    public var y: S {
        get { return self[cartesian: 1] } set { self[cartesian: 1] = newValue }
    }
    
    /// `{get set}` The `z` component of the `Vector` in cartesian and cylindrical corrdinates.
    public var z: S {
        get { return self[cartesian: 2] } set { self[cartesian: 2] = newValue }
    }
    
    /// `{get set}` The `w` component of the `Vector` in cartesian and cylindrical corrdinates.
    public var w: S {
        get { return self[cartesian: 3] } set { self[cartesian: 3] = newValue }
    }
}

//MARK: - Polar (Spherical)
extension Vector {
    public subscript(spherical dimension: Int) -> S {
        get {
            precondition(dimension >= 0, "Dimension must be positive.")
            guard dimension < dimensions else {
                return 0
            }
            
            switch coordinateSystem {
            case .PolarSpherical:
                return self[dimension]
            case .Cartesian:
                if(dimension == 0) {
                    return magnitude
                }
                
                let endDimension: Int = dimension == 0 ? 2 : dimension + 1
                var radiusSquared: S = 0
                for dim in 0..<endDimension {
                    radiusSquared += self[dim]*self[dim]
                }
                
                let currentRadius: S = radiusSquared.squareRoot()
                
                return (self[dimension] / currentRadius).acos()
            default:
                if(dimension == 0) {
                    return magnitude
                } else if(dimension == 1) {
                    return self[1]
                }
                
                var radiusSquared: S = self[0]
                for dim in 2...dimension {
                    radiusSquared += self[dim]*self[dim]
                }
                
                let currentRadius: S = radiusSquared.squareRoot()
                
                return (self[dimension] / currentRadius).acos()
            }
        } set(newCoordinate) {
            precondition(dimension >= 0, "Dimension has to be positive.")
            
            switch coordinateSystem {
            case .PolarSpherical:
                self[dimension] = newCoordinate
            case .Cartesian:
                var polar: Vector = self.sphericalVector
                polar[dimension] = newCoordinate
                self = polar.sphericalVector
            case .PolarCylindrical:
                var polar: Vector = self.sphericalVector
                polar[dimension] = newCoordinate
                self = polar.cylindricalVector
            }
        }
    }
    
    /// `{get}` The vector in Spherical Polar Corrdinates.
    public var sphericalVector: Vector<S> {
        switch coordinateSystem {
        case .PolarSpherical:
            return self
        default:
            var v: Vector = Vector<S>([0], corrdinateSystem: .PolarSpherical)
            
            for i in 0..<dimensions {
                v[i] = self[spherical: i]
            }
            
            return v
        }
    }
    
    /// `{get set}` The `radius r` component of the `Vector` in spherical corrdinates.
    public var sphericalRadius: S {
        get { return self[spherical: 0] } set { self[spherical: 0] = newValue }
    }
    
    /// `{get set}` The `theta θ` component of the `Vector` in spherical and cylindrical corrdinates.
    public var theta: S {
        get { return self[spherical: 1] } set { self[spherical: 1] = newValue }
    }
    
    /// `{get set}` The `theta θ`component of the `Vector` in spherical and cylindrical corrdinates.
    public var θ: S {
        get { return theta } set { theta = newValue }
    }
    
    /// `{get set}` The `phi 𝛗`component of the `Vector` in spherical corrdinates.
    public var phi: S {
        get { return self[spherical: 2] } set { self[spherical: 2] = newValue }
    }
    
    /// `{get set}` The`phi 𝛗` component of the `Vector` in spherical corrdinates.
    public var 𝛗: S {
        get { return phi } set { phi = newValue }
    }
    
    //theta can go from (0-360) and phi+ can go form (0-90)
    public init(radius r: S, theta: S, phi: S = 0) {
        self.init([r, theta, phi], corrdinateSystem: .PolarSpherical)
    }
    
    public init(radius r: S, θ theta: S, 𝛗 phi: S = 0) {
        self.init(radius: r, theta: theta, phi: phi)
    }
}


//MARK: - Polar (Cylindrical)
extension Vector {
    public subscript(cylindrical dimension: Int) -> S {
        get {
            precondition(dimension >= 0, "Dimension must be positive.")
            guard dimension < dimensions else {
                return 0
            }
            
            switch coordinateSystem {
            case .PolarCylindrical:
                return self[dimension]
            case .Cartesian:
                if(dimension >= 2) {
                    return self[dimension]
                }
                
                let x: S = self[0]
                let y: S = self[1]
                
                if(dimension == 0) {
                    //We want r = √(x^2 + y^2)
                    return (x*x + y*y).squareRoot()
                }
                
                //We want θ = asin(y/x)
                return (y/x).asin()
            case .PolarSpherical:
                if(dimension == 1) {
                    //We want θ
                    return self[dimension]
                }
                
                if(dimensions == 2 && dimension == 0) {
                    //We have two dimensions <r, θ>
                    //and we want r
                    return self[dimension]
                }
                
                var trig: S = self[0] //r
                
                //dimension == 0, start at 2
                //dimension == 2, start at 3
                //dimension == 3, start at 4
                let startDimension = (dimension == 0 ? 2 : dimension + 1)
                if(startDimension < dimensions) {
                    for angle in (startDimension + 1)..<dimensions {
                        trig *= self[angle].sin()
                    }
                }
                
                if(dimension == 0) {
                    //We want r
                } else {
                    trig *= self[dimension].cos()
                }
                
                return trig
            }
        } set(newCoordinate) {
            precondition(dimension >= 0, "Dimension must be positive.")
            
            switch coordinateSystem {
            case .PolarCylindrical:
                self[dimension] = newCoordinate
            case .PolarSpherical:
                var polar: Vector = self.cylindricalVector
                polar[dimension] = newCoordinate
                self = polar.sphericalVector
            case .Cartesian:
                var polar: Vector = self.cylindricalVector
                polar[dimension] = newCoordinate
                self = polar.cartesianVector
            }
        }
    }
    
    /// `{get}` The vector in Cylindrical Polar Corrdinates.
    public var cylindricalVector: Vector<S> {
        switch coordinateSystem {
        case .PolarCylindrical:
            return self
        default:
            var v: Vector = Vector<S>([0], corrdinateSystem: .PolarCylindrical)
            
            for i in 0..<dimensions {
                v[i] = self[cylindrical: i]
            }
            
            return v
        }
    }
    
    /// `{get set}` The `radius r` component of the `Vector` in cylindrical corrdinates.
    public var cylindricalRadius: S {
        get { return self[cylindrical: 0] } set { self[cylindrical: 0] = newValue }
    }
    
    public init(radius r: S, theta: S, z: S) {
        self.init([r, theta, z], corrdinateSystem: .PolarCylindrical)
    }
    
    public init(radius r: S, θ theta: S, z: S) {
        self.init(radius: r, theta: theta, z: z)
    }
}
