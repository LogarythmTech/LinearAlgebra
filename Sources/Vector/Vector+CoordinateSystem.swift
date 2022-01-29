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
    }
}

//MARK: - Cartesian
extension Vector {
    public init(x: S, y: S, z: S = 0, w: S = 0) {
        self.init([x, y, z, w], corrdinateSystem: .Cartesian)
    }
    
    /// `{get set}` a cartesian components in the `Vector` where `0` is the first dimension.
    public subscript(cartesian dimension: Int) -> S {
        precondition(dimension >= 0, "Dimension must be positive.")
        guard dimension < dimensions else {
            return 0
        }
        
        //index is in components
        switch coordinateSystem {
        case .Cartesian:
            return components[dimension]
        case .PolarCylindrical:
            //Since after the first two dimensions (`r` and `θ`) Cylindrical Polar is the same as Cartesian (`z`, `w`,...) we can just return the component at index
            if(dimension >= 2) {
                return components[dimension]
            }
            
            guard dimensions >= 2 else {
                //dimensions == 1
                return components[0]
            }
            
            //r = components[0]
            //θ = components[1]
            if(dimension == 0) {//getting x
                return components[0] * components[1].cos()
            } else { //getting y
                return components[0] * components[1].sin()
            }
        case .PolarSpherical:
            //r = components[0]
            //θ = components[1]
            //𝛗 = components[2]
            guard dimensions >= 2 else {
                return components[0]
            }
            
            var trig: S = components[0]
            
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
                trig *= components[1].cos()
            } else if(dimension == 1) {
                trig *= components[1].sin() //θ
            } else {
                // index == 0: cos(θ)
                // index == 2: cos(𝛗ₙ₋₂)
                // index == 3: cos(𝛗ₙ₋₃)
                trig *= components[dimension].cos()
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
                    trig *= components[angle].sin()
                }
            }
            
            return trig
        }
    }
    
    /// `{get}` the cartesian vector
    public var cartesianVector: Vector<S> {
        switch coordinateSystem {
        case .Cartesian:
            return self
        case .PolarSpherical:
            return self
        case .PolarCylindrical:
            return self
        }
    }
    
    /// `{get set}` the `x` component (or the first element) in the `Vector`.
    public var x: S {
        get {
            switch coordinateSystem {
            case .Cartesian:
                return self[0]
            case .PolarCylindrical:
                //return r cos θ
                return self[0] * /*cos*/(self[1]).cos()
            case .PolarSpherical:
                //self[0] = r
                //self[1] = theta
                return self[0]
            }
        } set(newValue) {
            switch coordinateSystem {
            case .Cartesian:
                self[0] = newValue
            case .PolarCylindrical:
                precondition(newValue <= self[0], "New x value must be able to lie on the circle of radius r (self[0]).")
                //Assuming we want the same magnitude
                //x = r cos θ
                //x / r = cos θ
                //θ = arc cos(x / r)
                self[1] = /*acos*/(newValue / self[0])
            case .PolarSpherical:
                //TODO: Set PolarSpherical
                self[0] = newValue
            }
        }
    }
}

//MARK: - Polar (Spherical)
extension Vector {
    public var radiusSpherical: S {
        get {
            return magnitude
        } set(newValue) {
            magnitude = newValue
        }
    }
    
    //TODO: r
    //TODO: Theta
    //TODO: Phi
    
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
    //TODO: r
    //TODO: theta
    //TODO: z
    
    public init(radius r: S, theta: S, z: S) {
        self.init([r, theta, z], corrdinateSystem: .PolarCylindrical)
    }
    
    public init(radius r: S, θ theta: S, z: S) {
        self.init(radius: r, theta: theta, z: z)
    }
}
