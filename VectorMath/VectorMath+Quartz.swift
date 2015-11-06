//
//  VectorMath+Quartz.swift
//  VectorMath
//
//  Version 0.9
//
//  Created by Janne Raiskila, based on VectorMath created by Nick Lockwood
//  on 24/11/2014. Copyright (c) 2014-2015 Nick Lockwood and Janne Raiskila
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/acdx/VectorMath
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
  var __x: Scalar { return Scalar(x) }
  var __y: Scalar { return Scalar(y) }
}

extension CGVector: Vector2Type {
  var __x: Scalar { return Scalar(dx) }
  var __y: Scalar { return Scalar(dy) }
}

extension CGSize: Vector2Type {
  var __x: Scalar { return Scalar(width) }
  var __y: Scalar { return Scalar(height) }
}

extension CGAffineTransform: Matrix3Type {
  var __m11: Scalar { return Scalar(a) }
  var __m12: Scalar { return Scalar(b) }
  var __m13: Scalar { return Scalar(0) }
  var __m21: Scalar { return Scalar(c) }
  var __m22: Scalar { return Scalar(d) }
  var __m23: Scalar { return Scalar(0) }
  var __m31: Scalar { return Scalar(tx) }
  var __m32: Scalar { return Scalar(ty) }
  var __m33: Scalar { return Scalar(1) }
}

extension CATransform3D: Matrix4Type {
  var __m11: Scalar { return Scalar(m11) }
  var __m12: Scalar { return Scalar(m12) }
  var __m13: Scalar { return Scalar(m13) }
  var __m14: Scalar { return Scalar(m14) }
  var __m21: Scalar { return Scalar(m21) }
  var __m22: Scalar { return Scalar(m22) }
  var __m23: Scalar { return Scalar(m23) }
  var __m24: Scalar { return Scalar(m24) }
  var __m31: Scalar { return Scalar(m31) }
  var __m32: Scalar { return Scalar(m32) }
  var __m33: Scalar { return Scalar(m33) }
  var __m34: Scalar { return Scalar(m34) }
  var __m41: Scalar { return Scalar(m41) }
  var __m42: Scalar { return Scalar(m42) }
  var __m43: Scalar { return Scalar(m43) }
  var __m44: Scalar { return Scalar(m44) }
}

extension CGPoint: InstantiableVector2Type {
  init(__x: Scalar, __y: Scalar) {
    self.init(x: CGFloat(__x), y: CGFloat(__y))
  }
}

extension CGVector: InstantiableVector2Type {
  init(__x: Scalar, __y: Scalar) {
    self.init(dx: CGFloat(__x), dy: CGFloat(__y))
  }
}

extension CGSize: InstantiableVector2Type {
  init(__x: Scalar, __y: Scalar) {
    self.init(width: CGFloat(__x), height: CGFloat(__y))
  }
}

extension CGAffineTransform: InstantiableMatrix3Type {
  init(
    __m11: Scalar, __m12: Scalar, __m13: Scalar,
    __m21: Scalar, __m22: Scalar, __m23: Scalar,
    __m31: Scalar, __m32: Scalar, __m33: Scalar) {
    self.init(
      a: CGFloat(__m11), b: CGFloat(__m12),
      c: CGFloat(__m21), d: CGFloat(__m22),
      tx: CGFloat(__m31), ty: CGFloat(__m32)
    )
  }

  init(scale: Vector2Type) {
    self.init(__scale: scale)
  }

  init(translation: Vector2Type) {
    self.init(__translation: translation)
  }

  init(rotation: Scalar) {
    self.init(__rotation: rotation)
  }
}

extension CATransform3D: InstantiableMatrix4Type {
  init(
    __m11: Scalar, __m12: Scalar, __m13: Scalar, __m14: Scalar,
    __m21: Scalar, __m22: Scalar, __m23: Scalar, __m24: Scalar,
    __m31: Scalar, __m32: Scalar, __m33: Scalar, __m34: Scalar,
    __m41: Scalar, __m42: Scalar, __m43: Scalar, __m44: Scalar) {
    self.init(
      m11: CGFloat(__m11), m12: CGFloat(__m12), m13: CGFloat(__m13), m14: CGFloat(__m14),
      m21: CGFloat(__m21), m22: CGFloat(__m22), m23: CGFloat(__m23), m24: CGFloat(__m24),
      m31: CGFloat(__m31), m32: CGFloat(__m32), m33: CGFloat(__m33), m34: CGFloat(__m34),
      m41: CGFloat(__m41), m42: CGFloat(__m42), m43: CGFloat(__m43), m44: CGFloat(__m44)
    )
  }

  init(scale: Vector3Type) {
    self.init(__scale: scale)
  }

  init(translation: Vector3Type) {
    self.init(__translation: translation)
  }

  init(rotation: Vector4Type) {
    self.init(__rotation: rotation)
  }

  init(quaternion: QuaternionType) {
    self.init(__quaternion: quaternion)
  }

  init(fovx: Scalar, fovy: Scalar, near: Scalar, far: Scalar) {
    self.init(__fovx: fovx, __fovy: fovy, __near: near, __far: far)
  }

  init(fovx: Scalar, aspect: Scalar, near: Scalar, far: Scalar) {
    self.init(__fovx: fovx, __aspect: aspect, __near: near, __far: far)
  }

  init(fovy: Scalar, aspect: Scalar, near: Scalar, far: Scalar) {
    self.init(__fovy: fovy, __aspect: aspect, __near: near, __far: far)
  }

  init(top: Scalar, right: Scalar, bottom: Scalar, left: Scalar, near: Scalar, far: Scalar) {
    self.init(__top: top, __right: right, __bottom: bottom, __left: left, __near: near, __far: far)
  }
}

extension CGPoint {
  init(_ x: CGFloat, _ y: CGFloat) {
    self.init(__x: Scalar(x), __y: Scalar(y))
  }
}

extension CGVector {
  init(_ x: CGFloat, _ y: CGFloat) {
    self.init(__x: Scalar(x), __y: Scalar(y))
  }
}

extension CGSize {
  init(_ x: CGFloat, _ y: CGFloat) {
    self.init(__x: Scalar(x), __y: Scalar(y))
  }
}


extension CGPoint {

    init(_ v: __Vector2) {
        self.init(x: CGFloat(v.x), y: CGFloat(v.y))
    }
}

extension CGSize {

    init(_ v: __Vector2) {
        self.init(width: CGFloat(v.x), height: CGFloat(v.y))
    }
}

extension CGVector {

    init(_ v: __Vector2) {
        self.init(dx: CGFloat(v.x), dy: CGFloat(v.y))
    }
}

extension CGAffineTransform {

    init(_ m: __Matrix3) {

        self.init(
            a: CGFloat(m.m11), b: CGFloat(m.m12),
            c: CGFloat(m.m21), d: CGFloat(m.m22),
            tx: CGFloat(m.m31), ty: CGFloat(m.m32)
        )
    }
}

extension CATransform3D {

    init(_ m: __Matrix4) {

        self.init(
            m11: CGFloat(m.m11), m12: CGFloat(m.m12), m13: CGFloat(m.m13), m14: CGFloat(m.m14),
            m21: CGFloat(m.m21), m22: CGFloat(m.m22), m23: CGFloat(m.m23), m24: CGFloat(m.m24),
            m31: CGFloat(m.m31), m32: CGFloat(m.m32), m33: CGFloat(m.m33), m34: CGFloat(m.m34),
            m41: CGFloat(m.m41), m42: CGFloat(m.m42), m43: CGFloat(m.m43), m44: CGFloat(m.m44)
        )
    }
}

//MARK: VectorMath extensions

extension __Vector2 {

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

extension __Matrix3 {

    init(_ m: CGAffineTransform) {

        self.init(
            m11: Scalar(m.a), m12: Scalar(m.b), m13: 0,
            m21: Scalar(m.c), m22: Scalar(m.d), m23: 0,
            m31: Scalar(m.tx), m32: Scalar(m.ty), m33: 1
        )
    }
}

extension __Matrix4 {

    init(_ m: CATransform3D) {

        self.init(
            m11: Scalar(m.m11), m12: Scalar(m.m12), m13: Scalar(m.m13), m14: Scalar(m.m14),
            m21: Scalar(m.m21), m22: Scalar(m.m22), m23: Scalar(m.m23), m24: Scalar(m.m24),
            m31: Scalar(m.m31), m32: Scalar(m.m32), m33: Scalar(m.m33), m34: Scalar(m.m34),
            m41: Scalar(m.m41), m42: Scalar(m.m42), m43: Scalar(m.m43), m44: Scalar(m.m44)
        )
    }
}
