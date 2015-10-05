//
//  VectorMath+Quartz.swift
//  VectorMath
//
//  Version 0.1
//
//  Created by Nick Lockwood on 24/11/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/VectorMath
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

import QuartzCore

//MARK: Quartz extensions

extension CGPoint: Vector2Type {
  var _x: Scalar { return Scalar(x) }
  var _y: Scalar { return Scalar(y) }
}

extension CGVector: Vector2Type {
  var _x: Scalar { return Scalar(dx) }
  var _y: Scalar { return Scalar(dy) }
}

extension CGSize: Vector2Type {
  var _x: Scalar { return Scalar(width) }
  var _y: Scalar { return Scalar(height) }
}

extension CGPoint: InstantiableVector2Type {
  init(_x: Scalar, _y: Scalar) {
    self.init(x: CGFloat(_x), y: CGFloat(_y))
  }
}

extension CGVector: InstantiableVector2Type {
  init(_x: Scalar, _y: Scalar) {
    self.init(dx: CGFloat(_x), dy: CGFloat(_y))
  }
}

extension CGSize: InstantiableVector2Type {
  init(_x: Scalar, _y: Scalar) {
    self.init(width: CGFloat(_x), height: CGFloat(_y))
  }
}

extension CGAffineTransform: Matrix3Type {
  var _m11: Scalar { return Scalar(a) }
  var _m12: Scalar { return Scalar(b) }
  var _m13: Scalar { return Scalar(0) }
  var _m21: Scalar { return Scalar(c) }
  var _m22: Scalar { return Scalar(d) }
  var _m23: Scalar { return Scalar(0) }
  var _m31: Scalar { return Scalar(tx) }
  var _m32: Scalar { return Scalar(ty) }
  var _m33: Scalar { return Scalar(1) }
}

extension CGAffineTransform: InstantiableMatrix3Type {
  init(
    _m11: Scalar, _m12: Scalar, _m13: Scalar,
    _m21: Scalar, _m22: Scalar, _m23: Scalar,
    _m31: Scalar, _m32: Scalar, _m33: Scalar) {
    self.init(
      a: CGFloat(_m11), b: CGFloat(_m12),
      c: CGFloat(_m21), d: CGFloat(_m22),
      tx: CGFloat(_m31), ty: CGFloat(_m32)
    )
  }
}

extension CATransform3D: Matrix4Type {
  var _m11: Scalar { return Scalar(m11) }
  var _m12: Scalar { return Scalar(m12) }
  var _m13: Scalar { return Scalar(m13) }
  var _m14: Scalar { return Scalar(m14) }
  var _m21: Scalar { return Scalar(m21) }
  var _m22: Scalar { return Scalar(m22) }
  var _m23: Scalar { return Scalar(m23) }
  var _m24: Scalar { return Scalar(m24) }
  var _m31: Scalar { return Scalar(m31) }
  var _m32: Scalar { return Scalar(m32) }
  var _m33: Scalar { return Scalar(m33) }
  var _m34: Scalar { return Scalar(m34) }
  var _m41: Scalar { return Scalar(m41) }
  var _m42: Scalar { return Scalar(m42) }
  var _m43: Scalar { return Scalar(m43) }
  var _m44: Scalar { return Scalar(m44) }
}

extension CATransform3D: InstantiableMatrix4Type {
  init(
    _m11: Scalar, _m12: Scalar, _m13: Scalar, _m14: Scalar,
    _m21: Scalar, _m22: Scalar, _m23: Scalar, _m24: Scalar,
    _m31: Scalar, _m32: Scalar, _m33: Scalar, _m34: Scalar,
    _m41: Scalar, _m42: Scalar, _m43: Scalar, _m44: Scalar) {
    self.init(
      m11: CGFloat(_m11), m12: CGFloat(_m12), m13: CGFloat(_m13), m14: CGFloat(_m14),
      m21: CGFloat(_m21), m22: CGFloat(_m22), m23: CGFloat(_m23), m24: CGFloat(_m24),
      m31: CGFloat(_m31), m32: CGFloat(_m32), m33: CGFloat(_m33), m34: CGFloat(_m34),
      m41: CGFloat(_m41), m42: CGFloat(_m42), m43: CGFloat(_m43), m44: CGFloat(_m44)
    )
  }
}

extension CGPoint {

    init(_ v: Vector2) {
        self.init(x: CGFloat(v.x), y: CGFloat(v.y))
    }
}

extension CGSize {

    init(_ v: Vector2) {
        self.init(width: CGFloat(v.x), height: CGFloat(v.y))
    }
}

extension CGVector {

    init(_ v: Vector2) {
        self.init(dx: CGFloat(v.x), dy: CGFloat(v.y))
    }
}

extension CGAffineTransform {

    init(_ m: Matrix3) {

        self.init(
            a: CGFloat(m.m11), b: CGFloat(m.m12),
            c: CGFloat(m.m21), d: CGFloat(m.m22),
            tx: CGFloat(m.m31), ty: CGFloat(m.m32)
        )
    }
}

extension CATransform3D {

    init(_ m: Matrix4) {

        self.init(
            m11: CGFloat(m.m11), m12: CGFloat(m.m12), m13: CGFloat(m.m13), m14: CGFloat(m.m14),
            m21: CGFloat(m.m21), m22: CGFloat(m.m22), m23: CGFloat(m.m23), m24: CGFloat(m.m24),
            m31: CGFloat(m.m31), m32: CGFloat(m.m32), m33: CGFloat(m.m33), m34: CGFloat(m.m34),
            m41: CGFloat(m.m41), m42: CGFloat(m.m42), m43: CGFloat(m.m43), m44: CGFloat(m.m44)
        )
    }
}

//MARK: VectorMath extensions

extension Vector2 {

    init(_ v: CGPoint) {
        self.init(x: Scalar(v.x), y: Scalar(v.y))
    }

    init(_ v: CGSize) {
        self.init(x: Scalar(v.width), y: Scalar(v.height))
    }

    init(_ v: CGVector) {
        self.init(x: Scalar(v.dx), y: Scalar(v.dy))
    }
}

extension Matrix3 {

    init(_ m: CGAffineTransform) {

        self.init(
            m11: Scalar(m.a), m12: Scalar(m.b), m13: 0,
            m21: Scalar(m.c), m22: Scalar(m.d), m23: 0,
            m31: Scalar(m.tx), m32: Scalar(m.ty), m33: 1
        )
    }
}

extension Matrix4 {

    init(_ m: CATransform3D) {

        self.init(
            m11: Scalar(m.m11), m12: Scalar(m.m12), m13: Scalar(m.m13), m14: Scalar(m.m14),
            m21: Scalar(m.m21), m22: Scalar(m.m22), m23: Scalar(m.m23), m24: Scalar(m.m24),
            m31: Scalar(m.m31), m32: Scalar(m.m32), m33: Scalar(m.m33), m34: Scalar(m.m34),
            m41: Scalar(m.m41), m42: Scalar(m.m42), m43: Scalar(m.m43), m44: Scalar(m.m44)
        )
    }
}
