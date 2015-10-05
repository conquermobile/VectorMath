//
//  VectorMath+SceneKit.swift
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

import SceneKit

extension SCNVector3: Vector3Type {
  var __x: Scalar { return Scalar(x) }
  var __y: Scalar { return Scalar(y) }
  var __z: Scalar { return Scalar(z) }
}

extension SCNVector4: Vector4Type {
  var __x: Scalar { return Scalar(x) }
  var __y: Scalar { return Scalar(y) }
  var __z: Scalar { return Scalar(z) }
  var __w: Scalar { return Scalar(w) }
}

extension SCNQuaternion: QuaternionType {}

extension SCNMatrix4: Matrix4Type {
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

extension SCNVector3: InstantiableVector3Type {
  init(__x: Scalar, __y: Scalar, __z: Scalar) {
    self.init(x: Float(__x), y: Float(__y), z: Float(__z))
  }
}

extension SCNVector4: InstantiableVector4Type {
  init(__x: Scalar, __y: Scalar, __z: Scalar, __w: Scalar) {
    self.init(x: Float(__x), y: Float(__y), z: Float(__z), w: Float(__w))
  }
}

extension SCNQuaternion : InstantiableQuaternionType {}

extension SCNMatrix4 : InstantiableMatrix4Type {
  init(
    __m11: Scalar, __m12: Scalar, __m13: Scalar, __m14: Scalar,
    __m21: Scalar, __m22: Scalar, __m23: Scalar, __m24: Scalar,
    __m31: Scalar, __m32: Scalar, __m33: Scalar, __m34: Scalar,
    __m41: Scalar, __m42: Scalar, __m43: Scalar, __m44: Scalar
  ) {
    self.init(
      m11: Float(__m11), m12: Float(__m12), m13: Float(__m13), m14: Float(__m14),
      m21: Float(__m21), m22: Float(__m22), m23: Float(__m23), m24: Float(__m24),
      m31: Float(__m31), m32: Float(__m32), m33: Float(__m33), m34: Float(__m34),
      m41: Float(__m41), m42: Float(__m42), m43: Float(__m43), m44: Float(__m44)
    )
  }
}

//MARK: SceneKit extensions

extension SCNVector3 {

    init(_ v: Vector3) {
        self.init(x: Float(v.x), y: Float(v.y), z: Float(v.z))
    }
}

extension SCNVector4 {

    init(_ v: Vector4) {
        self.init(x: Float(v.x), y: Float(v.y), z: Float(v.z), w: Float(v.w))
    }
}

extension SCNQuaternion {

  init(_ q:Quaternion) {
    self.init(x: Float(q.x), y: Float(q.y), z: Float(q.z), w: Float(q.w))
  }
}

extension SCNMatrix4 {

    init(_ m: Matrix4) {

        self.init(
            m11: Float(m.m11), m12: Float(m.m12), m13: Float(m.m13), m14: Float(m.m14),
            m21: Float(m.m21), m22: Float(m.m22), m23: Float(m.m23), m24: Float(m.m24),
            m31: Float(m.m31), m32: Float(m.m32), m33: Float(m.m33), m34: Float(m.m34),
            m41: Float(m.m41), m42: Float(m.m42), m43: Float(m.m43), m44: Float(m.m44)
        )
    }
}

//MARK: VectorMath extensions

extension Vector3 {

    init(_ v: SCNVector3) {
        self.init(x: Scalar(v.x), y: Scalar(v.y), z: Scalar(v.z))
    }
}

extension Vector4 {

    init(_ v: SCNVector4) {
        self.init(x: Scalar(v.x), y: Scalar(v.y), z: Scalar(v.z), w: Scalar(v.w))
    }
}

extension Quaternion {

  init(_ q: SCNQuaternion) {
    self.init(x: Scalar(q.x), y: Scalar(q.y), z: Scalar(q.z), w: Scalar(q.w))
  }
}

extension Matrix4 {

    init(_ m: SCNMatrix4) {

        self.init(
            m11: Scalar(m.m11), m12: Scalar(m.m12), m13: Scalar(m.m13), m14: Scalar(m.m14),
            m21: Scalar(m.m21), m22: Scalar(m.m22), m23: Scalar(m.m23), m24: Scalar(m.m24),
            m31: Scalar(m.m31), m32: Scalar(m.m32), m33: Scalar(m.m33), m34: Scalar(m.m34),
            m41: Scalar(m.m41), m42: Scalar(m.m42), m43: Scalar(m.m43), m44: Scalar(m.m44)
        )
    }
}
