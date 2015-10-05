//
//  VectorMath.swift
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

import Foundation

//MARK: Protocols

protocol Vector2Type {
  var __x: Scalar { get }
  var __y: Scalar { get }
}

protocol Vector3Type {
  var __x: Scalar { get }
  var __y: Scalar { get }
  var __z: Scalar { get }
}

protocol Vector4Type {
  var __x: Scalar { get }
  var __y: Scalar { get }
  var __z: Scalar { get }
  var __w: Scalar { get }
}

protocol QuaternionType: Vector4Type {}

protocol Matrix3Type {
  var __m11: Scalar { get }
  var __m12: Scalar { get }
  var __m13: Scalar { get }
  var __m21: Scalar { get }
  var __m22: Scalar { get }
  var __m23: Scalar { get }
  var __m31: Scalar { get }
  var __m32: Scalar { get }
  var __m33: Scalar { get }
}

protocol Matrix4Type {
  var __m11: Scalar { get }
  var __m12: Scalar { get }
  var __m13: Scalar { get }
  var __m14: Scalar { get }
  var __m21: Scalar { get }
  var __m22: Scalar { get }
  var __m23: Scalar { get }
  var __m24: Scalar { get }
  var __m31: Scalar { get }
  var __m32: Scalar { get }
  var __m33: Scalar { get }
  var __m34: Scalar { get }
  var __m41: Scalar { get }
  var __m42: Scalar { get }
  var __m43: Scalar { get }
  var __m44: Scalar { get }
}

protocol InstantiableVector2Type: Vector2Type {
  init(__x: Scalar, __y: Scalar)
}

protocol InstantiableVector3Type: Vector3Type {
  init(__x: Scalar, __y: Scalar, __z: Scalar)
}

protocol InstantiableVector4Type: Vector4Type {
  init(__x: Scalar, __y: Scalar, __z: Scalar, __w: Scalar)
}

protocol InstantiableQuaternionType: QuaternionType, InstantiableVector4Type {}

protocol InstantiableMatrix3Type: Matrix3Type {
  init(
    __m11: Scalar, __m12: Scalar, __m13: Scalar,
    __m21: Scalar, __m22: Scalar, __m23: Scalar,
    __m31: Scalar, __m32: Scalar, __m33: Scalar
  )
}

protocol InstantiableMatrix4Type: Matrix4Type {
  init(
    __m11: Scalar, __m12: Scalar, __m13: Scalar, __m14: Scalar,
    __m21: Scalar, __m22: Scalar, __m23: Scalar, __m24: Scalar,
    __m31: Scalar, __m32: Scalar, __m33: Scalar, __m34: Scalar,
    __m41: Scalar, __m42: Scalar, __m43: Scalar, __m44: Scalar
  )
}

//MARK: Vector2

extension Vector2Type {
  var lengthSquared: Scalar {
    return __x * __x + __y * __y
  }

  var length: Scalar {
    return sqrt(lengthSquared)
  }

  func toArray() -> [Scalar] {
    return [__x, __y]
  }

  func dot(v: Vector2Type) -> Scalar {
    return __x * v.__x + __y * v.__y
  }

  func cross(v: Vector2Type) -> Scalar {
    return __x * v.__y - __y * v.__x
  }

  func angleWith(v: Vector2Type) -> Scalar {
    if self.vector2IsEqual(v) {
      return 0
    }

    let t1 = Vector2(self).normalized()
    let t2 = Vector2(v).normalized()
    let cross = t1.cross(t2)
    let dot = max(-1, min(1, t1.dot(t2)))

    return atan2(cross, dot)
  }

  func vector2IsEqual(v: Vector2Type) -> Bool {
    return __x == v.__x && __y == v.__y
  }

  func vector2IsApproxEqual(v: Vector2Type) -> Bool {
    return __x ~= v.__x && __y ~= v.__y
  }
}

extension InstantiableVector2Type {
  var inverse: Self {
    return -self
  }

  func normalized() -> Self {
    let lengthSquared = self.lengthSquared
    if lengthSquared ~= 0 || lengthSquared ~= 1 {
      return self
    }
    return self / sqrt(lengthSquared)
  }

  func rotatedBy(radians: Scalar) -> Self {
    let cs = cos(radians)
    let sn = sin(radians)
    return Self(__x: __x * cs - __y * sn, __y: __x * sn + __y * cs)
  }

  func rotatedBy(radians: Scalar, around pivot: Vector2Type) -> Self {
    return (self - pivot).rotatedBy(radians) + pivot
  }

  func interpolatedWith(v: Vector2Type, t: Scalar) -> Self {
    return self + (v - self) * t
  }
}

prefix func +<T: InstantiableVector2Type>(v: T) -> T {
  return v
}

prefix func -<T: InstantiableVector2Type>(v: T) -> T {
  return T(__x: -v.__x, __y: -v.__y)
}

func +<T: InstantiableVector2Type>(lhs: T, rhs: T) -> T {
  return T(__x: lhs.__x + rhs.__x, __y: lhs.__y + rhs.__y)
}

func +<T: InstantiableVector2Type>(lhs: T, rhs: Vector2Type) -> T {
  return T(__x: lhs.__x + rhs.__x, __y: lhs.__y + rhs.__y)
}

func +<T: InstantiableVector2Type>(lhs: Vector2Type, rhs: T) -> T {
  return T(__x: lhs.__x + rhs.__x, __y: lhs.__y + rhs.__y)
}

func -<T: InstantiableVector2Type>(lhs: T, rhs: T) -> T {
  return T(__x: lhs.__x - rhs.__x, __y: lhs.__y - rhs.__y)
}

func -<T: InstantiableVector2Type>(lhs: T, rhs: Vector2Type) -> T {
  return T(__x: lhs.__x - rhs.__x, __y: lhs.__y - rhs.__y)
}

func -<T: InstantiableVector2Type>(lhs: Vector2Type, rhs: T) -> T {
  return T(__x: lhs.__x - rhs.__x, __y: lhs.__y - rhs.__y)
}

func *<T: InstantiableVector2Type>(lhs: T, rhs: T) -> T {
  return T(__x: lhs.__x * rhs.__x, __y: lhs.__y * rhs.__y)
}

func *<T: InstantiableVector2Type>(lhs: T, rhs: Vector2Type) -> T {
  return T(__x: lhs.__x * rhs.__x, __y: lhs.__y * rhs.__y)
}

func *<T: InstantiableVector2Type>(lhs: Vector2Type, rhs: T) -> T {
  return T(__x: lhs.__x * rhs.__x, __y: lhs.__y * rhs.__y)
}

func *<T: InstantiableVector2Type>(lhs: Scalar, rhs: T) -> T {
  return T(__x: lhs * rhs.__x, __y: lhs * rhs.__y)
}

func *<T: InstantiableVector2Type>(lhs: T, rhs: Scalar) -> T {
  return T(__x: lhs.__x * rhs, __y: lhs.__y * rhs)
}

func *<T: InstantiableVector2Type>(lhs: T, rhs: Matrix3Type) -> T {
  return T(
    __x: lhs.__x * rhs.__m11 + lhs.__y * rhs.__m21 + rhs.__m31,
    __y: lhs.__x * rhs.__m12 + lhs.__y * rhs.__m22 + rhs.__m32
  )
}

func *<T: InstantiableVector2Type>(lhs: Matrix3Type, rhs: T) -> T {
  return rhs * lhs
}

func /<T: InstantiableVector2Type>(lhs: T, rhs: T) -> T {
  return T(__x: lhs.__x / rhs.__x, __y: lhs.__y / rhs.__y)
}

func /<T: InstantiableVector2Type>(lhs: T, rhs: Vector2Type) -> T {
  return T(__x: lhs.__x / rhs.__x, __y: lhs.__y / rhs.__y)
}

func /<T: InstantiableVector2Type>(lhs: Vector2Type, rhs: T) -> T {
  return T(__x: lhs.__x / rhs.__x, __y: lhs.__y / rhs.__y)
}

func /<T: InstantiableVector2Type>(lhs: T, rhs: Scalar) -> T {
  return T(__x: lhs.__x / rhs, __y: lhs.__y / rhs)
}

//MARK: Vector3

extension Vector3Type {
  var lengthSquared: Scalar {
    return __x * __x + __y * __y + __z * __z
  }

  var length: Scalar {
    return sqrt(lengthSquared)
  }

  func toArray() -> [Scalar] {
    return [__x, __y, __z]
  }

  func dot(v: Vector3Type) -> Scalar {
    return __x * v.__x + __y * v.__y + __z * v.__z
  }

  func xy<T: InstantiableVector2Type>() -> T {
    return T(__x: __x, __y: __y)
  }

  func xz<T: InstantiableVector2Type>() -> T {
    return T(__x: __x, __y: __z)
  }

  func yz<T: InstantiableVector2Type>() -> T {
    return T(__x: __y, __y: __z)
  }

  func vector3IsEqual(v: Vector3Type) -> Bool {
    return __x == v.__x && __y == v.__y && __z == v.__z
  }

  func vector3IsApproxEqual(v: Vector3Type) -> Bool {
    return __x ~= v.__x && __y ~= v.__y && __z ~= v.__z
  }
}

extension InstantiableVector3Type {
  var inverse: Self {
    return -self
  }

  func cross(v: Vector3Type) -> Self {
    return Self(
      __x: __y * v.__z - __z * v.__y,
      __y: __z * v.__x - __x * v.__z,
      __z: __x * v.__y - __y * v.__x
    )
  }

  func normalized() -> Self {
    let lengthSquared = self.lengthSquared
    if lengthSquared ~= 0 || lengthSquared ~= 1 {
      return self
    }
    return self / sqrt(lengthSquared)
  }

  func interpolatedWith(v: Vector3Type, t: Scalar) -> Self {
    return self + (v - self) * t
  }
}

prefix func +<T: InstantiableVector3Type>(v: T) -> T {
  return v
}

prefix func -<T: InstantiableVector3Type>(v: T) -> T {
  return T(__x: -v.__x, __y: -v.__y, __z: -v.__z)
}

func +<T: InstantiableVector3Type>(lhs: T, rhs: T) -> T {
  return T(__x: lhs.__x + rhs.__x, __y: lhs.__y + rhs.__y, __z: lhs.__z + rhs.__z)
}

func +<T: InstantiableVector3Type>(lhs: T, rhs: Vector3Type) -> T {
  return T(__x: lhs.__x + rhs.__x, __y: lhs.__y + rhs.__y, __z: lhs.__z + rhs.__z)
}

func +<T: InstantiableVector3Type>(lhs: Vector3Type, rhs: T) -> T {
  return T(__x: lhs.__x + rhs.__x, __y: lhs.__y + rhs.__y, __z: lhs.__z + rhs.__z)
}

func -<T: InstantiableVector3Type>(lhs: T, rhs: T) -> T {
  return T(__x: lhs.__x - rhs.__x, __y: lhs.__y - rhs.__y, __z: lhs.__z - rhs.__z)
}

func -<T: InstantiableVector3Type>(lhs: T, rhs: Vector3Type) -> T {
  return T(__x: lhs.__x - rhs.__x, __y: lhs.__y - rhs.__y, __z: lhs.__z - rhs.__z)
}

func -<T: InstantiableVector3Type>(lhs: Vector3Type, rhs: T) -> T {
  return T(__x: lhs.__x - rhs.__x, __y: lhs.__y - rhs.__y, __z: lhs.__z - rhs.__z)
}

func *<T: InstantiableVector3Type>(lhs: T, rhs: T) -> T {
  return T(__x: lhs.__x * rhs.__x, __y: lhs.__y * rhs.__y, __z: lhs.__z * rhs.__z)
}

func *<T: InstantiableVector3Type>(lhs: T, rhs: Vector3Type) -> T {
  return T(__x: lhs.__x * rhs.__x, __y: lhs.__y * rhs.__y, __z: lhs.__z * rhs.__z)
}

func *<T: InstantiableVector3Type>(lhs: Vector3Type, rhs: T) -> T {
  return T(__x: lhs.__x * rhs.__x, __y: lhs.__y * rhs.__y, __z: lhs.__z * rhs.__z)
}

func *<T: InstantiableVector3Type>(lhs: Scalar, rhs: T) -> T {
  return T(__x: lhs * rhs.__x, __y: lhs * rhs.__y, __z: lhs * rhs.__z)
}

func *<T: InstantiableVector3Type>(lhs: T, rhs: Scalar) -> T {
  return T(__x: lhs.__x * rhs, __y: lhs.__y * rhs, __z: lhs.__z * rhs)
}

func *<T: InstantiableVector3Type>(lhs: T, rhs: Matrix3Type) -> T {
  return T(
    __x: lhs.__x * rhs.__m11 + lhs.__y * rhs.__m21 + lhs.__z * rhs.__m31,
    __y: lhs.__x * rhs.__m12 + lhs.__y * rhs.__m22 + lhs.__z * rhs.__m32,
    __z: lhs.__x * rhs.__m13 + lhs.__y * rhs.__m23 + lhs.__z * rhs.__m33
  )
}

func *<T: InstantiableVector3Type>(lhs: T, rhs: Matrix4Type) -> T {
  return T(
    __x: lhs.__x * rhs.__m11 + lhs.__y * rhs.__m21 + lhs.__z * rhs.__m31 + rhs.__m41,
    __y: lhs.__x * rhs.__m12 + lhs.__y * rhs.__m22 + lhs.__z * rhs.__m32 + rhs.__m42,
    __z: lhs.__x * rhs.__m13 + lhs.__y * rhs.__m23 + lhs.__z * rhs.__m33 + rhs.__m43
  )
}

func *<T: InstantiableVector3Type>(lhs: Matrix3Type, rhs: T) -> T {
  return rhs * lhs
}

func *<T: InstantiableVector3Type>(lhs: Matrix4Type, rhs: T) -> T {
  return rhs * lhs
}

func *<T: InstantiableVector3Type>(v: T, q: QuaternionType) -> T {
  let qv: Vector3 = q.xyz()
  let uv = qv.cross(v)
  let uuv = qv.cross(uv)
  let sub = uv * 2 * q.__w
  return v + sub + (uuv * 2)
}

func *<T: InstantiableVector3Type>(lhs: QuaternionType, rhs: T) -> T {
  return rhs * lhs
}

func /<T: InstantiableVector3Type>(lhs: T, rhs: T) -> T {
  return T(__x: lhs.__x / rhs.__x, __y: lhs.__y / rhs.__y, __z: lhs.__z / rhs.__z)
}

func /<T: InstantiableVector3Type>(lhs: T, rhs: Vector3Type) -> T {
  return T(__x: lhs.__x / rhs.__x, __y: lhs.__y / rhs.__y, __z: lhs.__z / rhs.__z)
}

func /<T: InstantiableVector3Type>(lhs: Vector3Type, rhs: T) -> T {
  return T(__x: lhs.__x / rhs.__x, __y: lhs.__y / rhs.__y, __z: lhs.__z / rhs.__z)
}

func /<T: InstantiableVector3Type>(lhs: T, rhs: Scalar) -> T {
  return T(__x: lhs.__x / rhs, __y: lhs.__y / rhs, __z: lhs.__z / rhs)
}

//MARK: Vector4

extension Vector4Type {
  var lengthSquared: Scalar {
    return __x * __x + __y * __y + __z * __z + __w * __w
  }

  var length: Scalar {
    return sqrt(lengthSquared)
  }

  func toArray() -> [Scalar] {
    return [__x, __y, __z, __w]
  }

  func dot(v: Vector4Type) -> Scalar {
    return __x * v.__x + __y * v.__y + __z * v.__z + __w * v.__w
  }

  func xyz<T: InstantiableVector3Type>() -> T {
    return T(__x: __x, __y: __y, __z: __z)
  }

  func xy<T: InstantiableVector2Type>() -> T {
    return T(__x: __x, __y: __y)
  }

  func xz<T: InstantiableVector2Type>() -> T {
    return T(__x: __x, __y: __z)
  }

  func yz<T: InstantiableVector2Type>() -> T {
    return T(__x: __y, __y: __z)
  }

  func vector4IsEqual(v: Vector4Type) -> Bool {
    return __x == v.__x && __y == v.__y && __z == v.__z && __w == v.__w
  }

  func vector4IsApproxEqual(v: Vector4Type) -> Bool {
    return __x ~= v.__x && __y ~= v.__y && __z ~= v.__z && __w ~= v.__w
  }
}

extension InstantiableVector4Type {
  var inverse: Self {
    return -self
  }

  func normalized() -> Self {
    let lengthSquared = self.lengthSquared
    if lengthSquared ~= 0 || lengthSquared ~= 1 {
      return self
    }
    return self / sqrt(lengthSquared)
  }

  func interpolatedWith(v: Vector4Type, t: Scalar) -> Self {
    return self + (v - self) * t
  }
}

prefix func +<T: InstantiableVector4Type>(v: T) -> T {
  return v
}

prefix func -<T: InstantiableVector4Type>(v: T) -> T {
  return T(__x: -v.__x, __y: -v.__y, __z: -v.__z, __w: -v.__w)
}

func +<T: InstantiableVector4Type>(lhs: T, rhs: T) -> T {
  return T(__x: lhs.__x + rhs.__x, __y: lhs.__y + rhs.__y, __z: lhs.__z + rhs.__z, __w: lhs.__w + rhs.__w)
}

func +<T: InstantiableVector4Type>(lhs: T, rhs: Vector4Type) -> T {
  return T(__x: lhs.__x + rhs.__x, __y: lhs.__y + rhs.__y, __z: lhs.__z + rhs.__z, __w: lhs.__w + rhs.__w)
}

func +<T: InstantiableVector4Type>(lhs: Vector4Type, rhs: T) -> T {
  return T(__x: lhs.__x + rhs.__x, __y: lhs.__y + rhs.__y, __z: lhs.__z + rhs.__z, __w: lhs.__w + rhs.__w)
}

func -<T: InstantiableVector4Type>(lhs: T, rhs: T) -> T {
  return T(__x: lhs.__x - rhs.__x, __y: lhs.__y - rhs.__y, __z: lhs.__z - rhs.__z, __w: lhs.__w - rhs.__w)
}

func -<T: InstantiableVector4Type>(lhs: T, rhs: Vector4Type) -> T {
  return T(__x: lhs.__x - rhs.__x, __y: lhs.__y - rhs.__y, __z: lhs.__z - rhs.__z, __w: lhs.__w - rhs.__w)
}

func -<T: InstantiableVector4Type>(lhs: Vector4Type, rhs: T) -> T {
  return T(__x: lhs.__x - rhs.__x, __y: lhs.__y - rhs.__y, __z: lhs.__z - rhs.__z, __w: lhs.__w - rhs.__w)
}

func *<T: InstantiableVector4Type>(lhs: T, rhs: T) -> T {
  return T(__x: lhs.__x * rhs.__x, __y: lhs.__y * rhs.__y, __z: lhs.__z * rhs.__z, __w: lhs.__w * rhs.__w)
}

func *<T: InstantiableVector4Type>(lhs: T, rhs: Vector4Type) -> T {
  return T(__x: lhs.__x * rhs.__x, __y: lhs.__y * rhs.__y, __z: lhs.__z * rhs.__z, __w: lhs.__w * rhs.__w)
}

func *<T: InstantiableVector4Type>(lhs: Vector4Type, rhs: T) -> T {
  return T(__x: lhs.__x * rhs.__x, __y: lhs.__y * rhs.__y, __z: lhs.__z * rhs.__z, __w: lhs.__w * rhs.__w)
}

func *<T: InstantiableVector4Type>(lhs: Scalar, rhs: T) -> T {
  return T(__x: lhs * rhs.__x, __y: lhs * rhs.__y, __z: lhs * rhs.__z, __w: lhs * rhs.__w)
}

func *<T: InstantiableVector4Type>(lhs: T, rhs: Scalar) -> T {
  return T(__x: lhs.__x * rhs, __y: lhs.__y * rhs, __z: lhs.__z * rhs, __w: lhs.__w * rhs)
}

func *<T: InstantiableVector4Type>(lhs: T, rhs: Matrix4Type) -> T {
  return T(
    __x: lhs.__x * rhs.__m11 + lhs.__y * rhs.__m21 + lhs.__z * rhs.__m31 + lhs.__w * rhs.__m41,
    __y: lhs.__x * rhs.__m12 + lhs.__y * rhs.__m22 + lhs.__z * rhs.__m32 + lhs.__w * rhs.__m42,
    __z: lhs.__x * rhs.__m13 + lhs.__y * rhs.__m23 + lhs.__z * rhs.__m33 + lhs.__w * rhs.__m43,
    __w: lhs.__x * rhs.__m14 + lhs.__y * rhs.__m24 + lhs.__z * rhs.__m34 + lhs.__w * rhs.__m44
  )
}

func *<T: InstantiableVector4Type>(lhs: Matrix4Type, rhs: T) -> T {
  return rhs * lhs
}

func /<T: InstantiableVector4Type>(lhs: T, rhs: T) -> T {
  return T(__x: lhs.__x / rhs.__x, __y: lhs.__y / rhs.__y, __z: lhs.__z / rhs.__z, __w: lhs.__w / rhs.__w)
}

func /<T: InstantiableVector4Type>(lhs: T, rhs: Vector4Type) -> T {
  return T(__x: lhs.__x / rhs.__x, __y: lhs.__y / rhs.__y, __z: lhs.__z / rhs.__z, __w: lhs.__w / rhs.__w)
}

func /<T: InstantiableVector4Type>(lhs: Vector4Type, rhs: T) -> T {
  return T(__x: lhs.__x / rhs.__x, __y: lhs.__y / rhs.__y, __z: lhs.__z / rhs.__z, __w: lhs.__w / rhs.__w)
}

func /<T: InstantiableVector4Type>(lhs: T, rhs: Scalar) -> T {
  return T(__x: lhs.__x / rhs, __y: lhs.__y / rhs, __z: lhs.__z / rhs, __w: lhs.__w / rhs)
}

//MARK: Quaternion

extension QuaternionType {
  var pitch: Scalar {
    return atan2(2 * (__y * __z + __w * __x), __w * __w - __x * __x - __y * __y + __z * __z)
  }

  var yaw: Scalar {
    return asin(-2 * (__x * __z - __w * __y))
  }

  var roll: Scalar {
    return atan2(2 * (__x * __y + __w * __z), __w * __w + __x * __x - __y * __y - __z * __z)
  }

  func toPitchYawRoll() -> (pitch: Scalar, yaw: Scalar, roll: Scalar) {
    return (pitch, yaw, roll)
  }

  func toAxisAngle<T: InstantiableVector4Type>() -> T {
    let xyzVector: Vector3 = xyz()
    let scale = xyzVector.length
    if scale ~= 0 || scale ~= .TwoPi {
      return T(__x: 0, __y: 0, __z: 1, __w: 0)
    } else {
      return T(__x: __x / scale, __y: __y / scale, __z: __z / scale, __w: acos(__w) * 2)
    }
  }

  func quaternionIsEqual(v: QuaternionType) -> Bool {
    return vector4IsEqual(v)
  }

  func quaternionIsApproxEqual(v: QuaternionType) -> Bool {
    return vector4IsApproxEqual(v)
  }
}

extension InstantiableQuaternionType {
  func interpolatedWith(q: QuaternionType, t: Scalar) -> Self {
    let dot = max(-1, min(1, self.dot(q)))
    if dot ~= 1 {
      return (self + (q - self) * t).normalized()
    }

    let theta = acos(dot) * t
    let t1 = self * cos(theta)
    let t2 = (q - (self * dot)).normalized() * sin(theta)
    return t1 + t2
  }

  init(axisAngle: Vector4Type) {
    let r = axisAngle.__w * 0.5
    let scale = sin(r)
    let xyzVector: Vector3 = axisAngle.xyz()
    let a = xyzVector * scale
    self.init(__x: a.__x, __y: a.__y, __z: a.__z, __w: cos(r))
  }

  init(pitch: Scalar, yaw: Scalar, roll: Scalar) {
    let sy = sin(yaw * 0.5)
    let cy = cos(yaw * 0.5)
    let sz = sin(roll * 0.5)
    let cz = cos(roll * 0.5)
    let sx = sin(pitch * 0.5)
    let cx = cos(pitch * 0.5)

    self.init(
      __x: cy * cz * cx - sy * sz * sx,
      __y: sy * sz * cx + cy * cz * sx,
      __z: sy * cz * cx + cy * sz * sx,
      __w: cy * sz * cx - sy * cz * sx
    )
  }

  init(rotationMatrix m: Matrix4Type) {
    let diagonal = m.__m11 + m.__m22 + m.__m33 + 1
    if diagonal ~= 0 {
      let scale = sqrt(diagonal) * 2
      self.init(
        __x: (m.__m32 - m.__m23) / scale,
        __y: (m.__m13 - m.__m31) / scale,
        __z: (m.__m21 - m.__m12) / scale,
        __w: 0.25 * scale
      )
    } else if m.__m11 > max(m.__m22, m.__m33) {
      let scale = sqrt(1 + m.__m11 - m.__m22 - m.__m33) * 2
      self.init(
        __x: 0.25 * scale,
        __y: (m.__m21 + m.__m12) / scale,
        __z: (m.__m13 + m.__m31) / scale,
        __w: (m.__m32 - m.__m23) / scale
      )
    } else if m.__m22 > m.__m33 {
      let scale = sqrt(1 + m.__m22 - m.__m11 - m.__m33) * 2
      self.init(
        __x: (m.__m21 + m.__m12) / scale,
        __y: 0.25 * scale,
        __z: (m.__m32 + m.__m23) / scale,
        __w: (m.__m13 - m.__m31) / scale
      )
    } else {
      let scale = sqrt(1 + m.__m33 - m.__m11 - m.__m22) * 2
      self.init(
        __x: (m.__m13 + m.__m31) / scale,
        __y: (m.__m32 + m.__m23) / scale,
        __z: 0.25 * scale,
        __w: (m.__m21 - m.__m12) / scale
      )
    }
  }
}

func *<T: InstantiableQuaternionType>(lhs: T, rhs: T) -> T {
  return T(
    __x: lhs.__w * rhs.__x + lhs.__x * rhs.__w + lhs.__y * rhs.__z - lhs.__z * rhs.__y,
    __y: lhs.__w * rhs.__y + lhs.__y * rhs.__w + lhs.__z * rhs.__x - lhs.__x * rhs.__z,
    __z: lhs.__w * rhs.__z + lhs.__z * rhs.__w + lhs.__x * rhs.__y - lhs.__y * rhs.__x,
    __w: lhs.__w * rhs.__w - lhs.__x * rhs.__x - lhs.__y * rhs.__y - lhs.__z * rhs.__z
  )
}

func *<T: InstantiableQuaternionType>(lhs: T, rhs: QuaternionType) -> T {
  return T(
    __x: lhs.__w * rhs.__x + lhs.__x * rhs.__w + lhs.__y * rhs.__z - lhs.__z * rhs.__y,
    __y: lhs.__w * rhs.__y + lhs.__y * rhs.__w + lhs.__z * rhs.__x - lhs.__x * rhs.__z,
    __z: lhs.__w * rhs.__z + lhs.__z * rhs.__w + lhs.__x * rhs.__y - lhs.__y * rhs.__x,
    __w: lhs.__w * rhs.__w - lhs.__x * rhs.__x - lhs.__y * rhs.__y - lhs.__z * rhs.__z
  )
}

func *<T: InstantiableQuaternionType>(lhs: QuaternionType, rhs: T) -> T {
  return T(
    __x: lhs.__w * rhs.__x + lhs.__x * rhs.__w + lhs.__y * rhs.__z - lhs.__z * rhs.__y,
    __y: lhs.__w * rhs.__y + lhs.__y * rhs.__w + lhs.__z * rhs.__x - lhs.__x * rhs.__z,
    __z: lhs.__w * rhs.__z + lhs.__z * rhs.__w + lhs.__x * rhs.__y - lhs.__y * rhs.__x,
    __w: lhs.__w * rhs.__w - lhs.__x * rhs.__x - lhs.__y * rhs.__y - lhs.__z * rhs.__z
  )
}

//MARK: Matrix3

extension Matrix3Type {
  func toArray() -> [Scalar] {
    return [__m11, __m12, __m13, __m21, __m22, __m23, __m31, __m32, __m33]
  }

  var determinant: Scalar {
    return (__m11 * __m22 * __m33 + __m12 * __m23 * __m31 + __m13 * __m21 * __m32)
      - (__m13 * __m22 * __m31 + __m11 * __m23 * __m32 + __m12 * __m21 * __m33)
  }

  func matrix3IsEqual(m: Matrix3Type) -> Bool {
    return
      __m11 == m.__m11 && __m12 == m.__m12 && __m13 == m.__m13 &&
      __m21 == m.__m21 && __m22 == m.__m22 && __m23 == m.__m23 &&
      __m31 == m.__m31 && __m32 == m.__m32 && __m33 == m.__m33
  }

  func matrix3IsApproxEqual(m: Matrix3Type) -> Bool {
    return
      __m11 ~= m.__m11 && __m12 ~= m.__m12 && __m13 ~= m.__m13 &&
      __m21 ~= m.__m21 && __m22 ~= m.__m22 && __m23 ~= m.__m23 &&
      __m31 ~= m.__m31 && __m32 ~= m.__m32 && __m33 ~= m.__m33
  }
}

extension InstantiableMatrix3Type {
  var adjugate: Self {
    return Self(
      __m11: __m22 * __m33 - __m23 * __m32,
      __m12: __m13 * __m32 - __m12 * __m33,
      __m13: __m12 * __m23 - __m13 * __m22,
      __m21: __m23 * __m31 - __m21 * __m33,
      __m22: __m11 * __m33 - __m13 * __m31,
      __m23: __m13 * __m21 - __m11 * __m23,
      __m31: __m21 * __m32 - __m22 * __m31,
      __m32: __m12 * __m31 - __m11 * __m32,
      __m33: __m11 * __m22 - __m12 * __m21
    )
  }

  var transpose: Self {
    return Self(
      __m11: __m11, __m12: __m21, __m13: __m31,
      __m21: __m12, __m22: __m22, __m23: __m32,
      __m31: __m13, __m32: __m23, __m33: __m33
    )
  }

  var inverse: Self {
    return adjugate * (1 / determinant)
  }

  func interpolatedWith(m: Matrix3Type, t: Scalar) -> Self {
    return Self(
      __m11: __m11 + (m.__m11 - __m11) * t,
      __m12: __m12 + (m.__m12 - __m12) * t,
      __m13: __m13 + (m.__m13 - __m13) * t,
      __m21: __m21 + (m.__m21 - __m21) * t,
      __m22: __m22 + (m.__m22 - __m22) * t,
      __m23: __m23 + (m.__m23 - __m23) * t,
      __m31: __m31 + (m.__m31 - __m31) * t,
      __m32: __m32 + (m.__m32 - __m32) * t,
      __m33: __m33 + (m.__m33 - __m33) * t
    )
  }

  init(scale: Vector2Type) {
    self.init(
      __m11: scale.__x, __m12: 0, __m13: 0,
      __m21: 0, __m22: scale.__y, __m23: 0,
      __m31: 0, __m32: 0, __m33: 1
    )
  }

  init(translation: Vector2Type) {
    self.init(
      __m11: 1, __m12: 0, __m13: 0,
      __m21: 0, __m22: 1, __m23: 0,
      __m31: translation.__x, __m32: translation.__y, __m33: 1
    )
  }

  init(rotation radians: Scalar) {
    let cs = cos(radians)
    let sn = sin(radians)
    self.init(
      __m11: cs, __m12: sn, __m13: 0,
      __m21: -sn, __m22: cs, __m23: 0,
      __m31: 0, __m32: 0, __m33: 1
    )
  }
}

prefix func +<T: InstantiableMatrix3Type>(m: T) -> T {
  return m
}

prefix func -<T: InstantiableMatrix3Type>(m: T) -> T {
  return m.inverse
}

func *<T: InstantiableMatrix3Type>(lhs: T, rhs: T) -> T {
  return T(
    __m11: lhs.__m11 * rhs.__m11 + lhs.__m21 * rhs.__m12 + lhs.__m31 * rhs.__m13,
    __m12: lhs.__m12 * rhs.__m11 + lhs.__m22 * rhs.__m12 + lhs.__m32 * rhs.__m13,
    __m13: lhs.__m13 * rhs.__m11 + lhs.__m23 * rhs.__m12 + lhs.__m33 * rhs.__m13,
    __m21: lhs.__m11 * rhs.__m21 + lhs.__m21 * rhs.__m22 + lhs.__m31 * rhs.__m23,
    __m22: lhs.__m12 * rhs.__m21 + lhs.__m22 * rhs.__m22 + lhs.__m32 * rhs.__m23,
    __m23: lhs.__m13 * rhs.__m21 + lhs.__m23 * rhs.__m22 + lhs.__m33 * rhs.__m23,
    __m31: lhs.__m11 * rhs.__m31 + lhs.__m21 * rhs.__m32 + lhs.__m31 * rhs.__m33,
    __m32: lhs.__m12 * rhs.__m31 + lhs.__m22 * rhs.__m32 + lhs.__m32 * rhs.__m33,
    __m33: lhs.__m13 * rhs.__m31 + lhs.__m23 * rhs.__m32 + lhs.__m33 * rhs.__m33
  )
}

func *<T: InstantiableMatrix3Type>(lhs: T, rhs: Matrix3Type) -> T {
  return T(
    __m11: lhs.__m11 * rhs.__m11 + lhs.__m21 * rhs.__m12 + lhs.__m31 * rhs.__m13,
    __m12: lhs.__m12 * rhs.__m11 + lhs.__m22 * rhs.__m12 + lhs.__m32 * rhs.__m13,
    __m13: lhs.__m13 * rhs.__m11 + lhs.__m23 * rhs.__m12 + lhs.__m33 * rhs.__m13,
    __m21: lhs.__m11 * rhs.__m21 + lhs.__m21 * rhs.__m22 + lhs.__m31 * rhs.__m23,
    __m22: lhs.__m12 * rhs.__m21 + lhs.__m22 * rhs.__m22 + lhs.__m32 * rhs.__m23,
    __m23: lhs.__m13 * rhs.__m21 + lhs.__m23 * rhs.__m22 + lhs.__m33 * rhs.__m23,
    __m31: lhs.__m11 * rhs.__m31 + lhs.__m21 * rhs.__m32 + lhs.__m31 * rhs.__m33,
    __m32: lhs.__m12 * rhs.__m31 + lhs.__m22 * rhs.__m32 + lhs.__m32 * rhs.__m33,
    __m33: lhs.__m13 * rhs.__m31 + lhs.__m23 * rhs.__m32 + lhs.__m33 * rhs.__m33
  )
}

func *<T: InstantiableMatrix3Type>(lhs: Matrix3Type, rhs: T) -> T {
  return T(
    __m11: lhs.__m11 * rhs.__m11 + lhs.__m21 * rhs.__m12 + lhs.__m31 * rhs.__m13,
    __m12: lhs.__m12 * rhs.__m11 + lhs.__m22 * rhs.__m12 + lhs.__m32 * rhs.__m13,
    __m13: lhs.__m13 * rhs.__m11 + lhs.__m23 * rhs.__m12 + lhs.__m33 * rhs.__m13,
    __m21: lhs.__m11 * rhs.__m21 + lhs.__m21 * rhs.__m22 + lhs.__m31 * rhs.__m23,
    __m22: lhs.__m12 * rhs.__m21 + lhs.__m22 * rhs.__m22 + lhs.__m32 * rhs.__m23,
    __m23: lhs.__m13 * rhs.__m21 + lhs.__m23 * rhs.__m22 + lhs.__m33 * rhs.__m23,
    __m31: lhs.__m11 * rhs.__m31 + lhs.__m21 * rhs.__m32 + lhs.__m31 * rhs.__m33,
    __m32: lhs.__m12 * rhs.__m31 + lhs.__m22 * rhs.__m32 + lhs.__m32 * rhs.__m33,
    __m33: lhs.__m13 * rhs.__m31 + lhs.__m23 * rhs.__m32 + lhs.__m33 * rhs.__m33
  )
}

func *<T: InstantiableMatrix3Type>(lhs: Scalar, rhs: T) -> T {
  return T(
    __m11: lhs * rhs.__m11, __m12: lhs * rhs.__m12, __m13: lhs * rhs.__m13,
    __m21: lhs * rhs.__m21, __m22: lhs * rhs.__m22, __m23: lhs * rhs.__m23,
    __m31: lhs * rhs.__m31, __m32: lhs * rhs.__m32, __m33: lhs * rhs.__m33
  )
}

func *<T: InstantiableMatrix3Type>(lhs: T, rhs: Scalar) -> T {
  return T(
    __m11: lhs.__m11 * rhs, __m12: lhs.__m12 * rhs, __m13: lhs.__m13 * rhs,
    __m21: lhs.__m21 * rhs, __m22: lhs.__m22 * rhs, __m23: lhs.__m23 * rhs,
    __m31: lhs.__m31 * rhs, __m32: lhs.__m32 * rhs, __m33: lhs.__m33 * rhs
  )
}

//MARK: Matrix4

extension Matrix4Type {
  func toArray() -> [Scalar] {
    return [
      __m11, __m12, __m13, __m14,
      __m21, __m22, __m23, __m24,
      __m31, __m32, __m33, __m34,
      __m41, __m42, __m43, __m44
    ]
  }

  private func determinantForAdjugate(m: Matrix4Type) -> Scalar {
    return __m11 * m.__m11 + __m12 * m.__m21 + __m13 * m.__m31 + __m14 * m.__m41
  }

  var determinant: Scalar {
    let copy = Matrix4(self)
    return determinantForAdjugate(copy.adjugate)
  }

  func matrix4IsEqual(m: Matrix4Type) -> Bool {
    return
      __m11 == m.__m11 && __m12 == m.__m12 && __m13 == m.__m13 && __m14 == m.__m14 &&
      __m21 == m.__m21 && __m22 == m.__m22 && __m23 == m.__m23 && __m24 == m.__m24 &&
      __m31 == m.__m31 && __m32 == m.__m32 && __m33 == m.__m33 && __m34 == m.__m34 &&
      __m41 == m.__m41 && __m42 == m.__m42 && __m43 == m.__m43 && __m44 == m.__m44
  }

  func matrix4IsApproxEqual(m: Matrix4Type) -> Bool {
    return
      __m11 ~= m.__m11 && __m12 ~= m.__m12 && __m13 ~= m.__m13 && __m14 ~= m.__m14 &&
      __m21 ~= m.__m21 && __m22 ~= m.__m22 && __m23 ~= m.__m23 && __m24 ~= m.__m24 &&
      __m31 ~= m.__m31 && __m32 ~= m.__m32 && __m33 ~= m.__m33 && __m34 ~= m.__m34 &&
      __m41 ~= m.__m41 && __m42 ~= m.__m42 && __m43 ~= m.__m43 && __m44 ~= m.__m44
  }
}

extension InstantiableMatrix4Type {
  var adjugate: Self {
    return Self(
      __m11: (__m22 * __m33 * __m44 - __m22 * __m34 * __m43) +
      (-__m32 * __m23 * __m44 + __m32 * __m24 * __m43) +
      (__m42 * __m23 * __m34 - __m42 * __m24 * __m33),

      __m12: (-__m12 * __m33 * __m44 + __m12 * __m34 * __m43) +
      (__m32 * __m13 * __m44 - __m32 * __m14 * __m43) +
      (-__m42 * __m13 * __m34 + __m42 * __m14 * __m33),

      __m13: (__m12 * __m23 * __m44 - __m12 * __m24 * __m43) +
      (-__m22 * __m13 * __m44 + __m22 * __m14 * __m43) +
      (__m42 * __m13 * __m24 - __m42 * __m14 * __m23),

      __m14: (-__m12 * __m23 * __m34 + __m12 * __m24 * __m33) +
      (__m22 * __m13 * __m34 - __m22 * __m14 * __m33) +
      (-__m32 * __m13 * __m24 + __m32 * __m14 * __m23),

      __m21: (-__m21 * __m33 * __m44 + __m21 * __m34 * __m43) +
      (__m31 * __m23 * __m44 - __m31 * __m24 * __m43) +
      (-__m41 * __m23 * __m34 + __m41 * __m24 * __m33),

      __m22: (__m11 * __m33 * __m44 - __m11 * __m34 * __m43) +
      (-__m31 * __m13 * __m44 + __m31 * __m14 * __m43) +
      (__m41 * __m13 * __m34 - __m41 * __m14 * __m33),

      __m23: (-__m11 * __m23 * __m44 + __m11 * __m24 * __m43) +
      (__m21 * __m13 * __m44 - __m21 * __m14 * __m43) +
      (-__m41 * __m13 * __m24 + __m41 * __m14 * __m23),

      __m24: (__m11 * __m23 * __m34 - __m11 * __m24 * __m33) +
      (-__m21 * __m13 * __m34 + __m21 * __m14 * __m33) +
      (__m31 * __m13 * __m24 - __m31 * __m14 * __m23),

      __m31: (__m21 * __m32 * __m44 - __m21 * __m34 * __m42) +
      (-__m31 * __m22 * __m44 + __m31 * __m24 * __m42) +
      (__m41 * __m22 * __m34 - __m41 * __m24 * __m32),

      __m32: (-__m11 * __m32 * __m44 + __m11 * __m34 * __m42) +
      (__m31 * __m12 * __m44 - __m31 * __m14 * __m42) +
      (-__m41 * __m12 * __m34 + __m41 * __m14 * __m32),

      __m33: (__m11 * __m22 * __m44 - __m11 * __m24 * __m42) +
      (-__m21 * __m12 * __m44 + __m21 * __m14 * __m42) +
      (__m41 * __m12 * __m24 - __m41 * __m14 * __m22),

      __m34: (-__m11 * __m22 * __m34 + __m11 * __m24 * __m32) +
      (__m21 * __m12 * __m34 - __m21 * __m14 * __m32) +
      (-__m31 * __m12 * __m24 + __m31 * __m14 * __m22),

      __m41: (-__m21 * __m32 * __m43 + __m21 * __m33 * __m42) +
      (__m31 * __m22 * __m43 - __m31 * __m23 * __m42) +
      (-__m41 * __m22 * __m33 + __m41 * __m23 * __m32),

      __m42: (__m11 * __m32 * __m43 - __m11 * __m33 * __m42) +
      (-__m31 * __m12 * __m43 + __m31 * __m13 * __m42) +
      (__m41 * __m12 * __m33 - __m41 * __m13 * __m32),

      __m43: (-__m11 * __m22 * __m43 + __m11 * __m23 * __m42) +
      (__m21 * __m12 * __m43 - __m21 * __m13 * __m42) +
      (-__m41 * __m12 * __m23 + __m41 * __m13 * __m22),

      __m44: (__m11 * __m22 * __m33 - __m11 * __m23 * __m32) +
      (-__m21 * __m12 * __m33 + __m21 * __m13 * __m32) +
      (__m31 * __m12 * __m23 - __m31 * __m13 * __m22)
    )
  }

  var transpose: Self {
    return Self(
      __m11: __m11, __m12: __m21, __m13: __m31, __m14: __m41,
      __m21: __m12, __m22: __m22, __m23: __m32, __m24: __m42,
      __m31: __m13, __m32: __m23, __m33: __m33, __m34: __m43,
      __m41: __m14, __m42: __m24, __m43: __m34, __m44: __m44
    )
  }

  var inverse: Self {
    let adjugate = self.adjugate
    let determinant = determinantForAdjugate(adjugate)
    return adjugate * (1 / determinant)
  }

  init(scale s: Vector3Type) {
    self.init(
      __m11: s.__x, __m12: 0, __m13: 0, __m14: 0,
      __m21: 0, __m22: s.__y, __m23: 0, __m24: 0,
      __m31: 0, __m32: 0, __m33: s.__z, __m34: 0,
      __m41: 0, __m42: 0, __m43: 0, __m44: 1
    )
  }

  init(translation t: Vector3Type) {
    self.init(
      __m11: 1, __m12: 0, __m13: 0, __m14: 0,
      __m21: 0, __m22: 1, __m23: 0, __m24: 0,
      __m31: 0, __m32: 0, __m33: 1, __m34: 0,
      __m41: t.__x, __m42: t.__y, __m43: t.__z, __m44: 1
    )
  }

  init(rotation axisAngle: Vector4Type) {
    self.init(quaternion: Quaternion(axisAngle: axisAngle))
  }

  init(quaternion q: QuaternionType) {
    self.init(
      __m11: 1 - 2 * (q.__y * q.__y + q.__z * q.__z), __m12: 2 * (q.__x * q.__y + q.__z * q.__w),
      __m13: 2 * (q.__x * q.__z - q.__y * q.__w), __m14: 0,

      __m21: 2 * (q.__x * q.__y - q.__z * q.__w), __m22: 1 - 2 * (q.__x * q.__x + q.__z * q.__z),
      __m23: 2 * (q.__y * q.__z + q.__x * q.__w), __m24: 0,

      __m31: 2 * (q.__x * q.__z + q.__y * q.__w), __m32: 2 * (q.__y * q.__z - q.__x * q.__w),
      __m33: 1 - 2 * (q.__x * q.__x + q.__y * q.__y), __m34: 0,

      __m41: 0, __m42: 0, __m43: 0, __m44: 1
    )
  }

  init(fovx: Scalar, fovy: Scalar, near: Scalar, far: Scalar) {
    self.init(fovy: fovy, aspect: fovx / fovy, near: near, far: far)
  }

  init(fovx: Scalar, aspect: Scalar, near: Scalar, far: Scalar) {
    self.init(fovy: fovx / aspect, aspect: aspect, near: near, far: far)
  }

  init(fovy: Scalar, aspect: Scalar, near: Scalar, far: Scalar) {
    let dz = far - near

    assert(dz > 0, "far value must be greater than near")
    assert(fovy > 0, "field of view must be nonzero and positive")
    assert(aspect > 0, "aspect ratio must be nonzero and positive")

    let r = fovy / 2
    let cotangent = cos(r) / sin(r)

    self.init(
      __m11: cotangent / aspect, __m12: 0, __m13: 0, __m14: 0,
      __m21: 0, __m22: cotangent, __m23: 0, __m24: 0,
      __m31: 0, __m32: 0, __m33: -(far + near) / dz, __m34: -1,
      __m41: 0, __m42: 0, __m43: -2 * near * far / dz, __m44: 0
    )
  }

  init(top: Scalar, right: Scalar, bottom: Scalar, left: Scalar, near: Scalar, far: Scalar) {
    let dx = right - left
    let dy = top - bottom
    let dz = far - near

    self.init(
      __m11: 2 / dx, __m12: 0, __m13: 0, __m14: 0,
      __m21: 0, __m22: 2 / dy, __m23: 0, __m24: 0,
      __m31: 0, __m32: 0, __m33: -2 / dz, __m34: 0,
      __m41: -(right + left) / dx, __m42: -(top + bottom) / dy, __m43: -(far + near) / dz, __m44: 1
    )
  }
}

prefix func +<T: InstantiableMatrix4Type>(m: T) -> T {
  return m
}

prefix func -<T: InstantiableMatrix4Type>(m: T) -> T {
  return m.inverse
}

func *<T: InstantiableMatrix4Type>(lhs: T, rhs: T) -> T {
  return T(
    __m11: (lhs.__m11 * rhs.__m11 + lhs.__m21 * rhs.__m12) +
    (lhs.__m31 * rhs.__m13 + lhs.__m41 * rhs.__m14),

    __m12: (lhs.__m12 * rhs.__m11 + lhs.__m22 * rhs.__m12) +
    (lhs.__m32 * rhs.__m13 + lhs.__m42 * rhs.__m14),

    __m13: (lhs.__m13 * rhs.__m11 + lhs.__m23 * rhs.__m12) +
    (lhs.__m33 * rhs.__m13 + lhs.__m43 * rhs.__m14),

    __m14: (lhs.__m14 * rhs.__m11 + lhs.__m24 * rhs.__m12) +
    (lhs.__m34 * rhs.__m13 + lhs.__m44 * rhs.__m14),

    __m21: (lhs.__m11 * rhs.__m21 + lhs.__m21 * rhs.__m22) +
    (lhs.__m31 * rhs.__m23 + lhs.__m41 * rhs.__m24),

    __m22: (lhs.__m12 * rhs.__m21 + lhs.__m22 * rhs.__m22) +
    (lhs.__m32 * rhs.__m23 + lhs.__m42 * rhs.__m24),

    __m23: (lhs.__m13 * rhs.__m21 + lhs.__m23 * rhs.__m22) +
    (lhs.__m33 * rhs.__m23 + lhs.__m43 * rhs.__m24),

    __m24: (lhs.__m14 * rhs.__m21 + lhs.__m24 * rhs.__m22) +
    (lhs.__m34 * rhs.__m23 + lhs.__m44 * rhs.__m24),

    __m31: (lhs.__m11 * rhs.__m31 + lhs.__m21 * rhs.__m32) +
    (lhs.__m31 * rhs.__m33 + lhs.__m41 * rhs.__m34),

    __m32: (lhs.__m12 * rhs.__m31 + lhs.__m22 * rhs.__m32) +
    (lhs.__m32 * rhs.__m33 + lhs.__m42 * rhs.__m34),

    __m33: (lhs.__m13 * rhs.__m31 + lhs.__m23 * rhs.__m32) +
    (lhs.__m33 * rhs.__m33 + lhs.__m43 * rhs.__m34),

    __m34: (lhs.__m14 * rhs.__m31 + lhs.__m24 * rhs.__m32) +
    (lhs.__m34 * rhs.__m33 + lhs.__m44 * rhs.__m34),

    __m41: (lhs.__m11 * rhs.__m41 + lhs.__m21 * rhs.__m42) +
    (lhs.__m31 * rhs.__m43 + lhs.__m41 * rhs.__m44),

    __m42: (lhs.__m12 * rhs.__m41 + lhs.__m22 * rhs.__m42) +
    (lhs.__m32 * rhs.__m43 + lhs.__m42 * rhs.__m44),

    __m43: (lhs.__m13 * rhs.__m41 + lhs.__m23 * rhs.__m42) +
    (lhs.__m33 * rhs.__m43 + lhs.__m43 * rhs.__m44),

    __m44: (lhs.__m14 * rhs.__m41 + lhs.__m24 * rhs.__m42) +
    (lhs.__m34 * rhs.__m43 + lhs.__m44 * rhs.__m44)
  )
}

func *<T: InstantiableMatrix4Type>(lhs: T, rhs: Matrix4Type) -> T {
  return T(
    __m11: (lhs.__m11 * rhs.__m11 + lhs.__m21 * rhs.__m12) +
    (lhs.__m31 * rhs.__m13 + lhs.__m41 * rhs.__m14),

    __m12: (lhs.__m12 * rhs.__m11 + lhs.__m22 * rhs.__m12) +
    (lhs.__m32 * rhs.__m13 + lhs.__m42 * rhs.__m14),

    __m13: (lhs.__m13 * rhs.__m11 + lhs.__m23 * rhs.__m12) +
    (lhs.__m33 * rhs.__m13 + lhs.__m43 * rhs.__m14),

    __m14: (lhs.__m14 * rhs.__m11 + lhs.__m24 * rhs.__m12) +
    (lhs.__m34 * rhs.__m13 + lhs.__m44 * rhs.__m14),

    __m21: (lhs.__m11 * rhs.__m21 + lhs.__m21 * rhs.__m22) +
    (lhs.__m31 * rhs.__m23 + lhs.__m41 * rhs.__m24),

    __m22: (lhs.__m12 * rhs.__m21 + lhs.__m22 * rhs.__m22) +
    (lhs.__m32 * rhs.__m23 + lhs.__m42 * rhs.__m24),

    __m23: (lhs.__m13 * rhs.__m21 + lhs.__m23 * rhs.__m22) +
    (lhs.__m33 * rhs.__m23 + lhs.__m43 * rhs.__m24),

    __m24: (lhs.__m14 * rhs.__m21 + lhs.__m24 * rhs.__m22) +
    (lhs.__m34 * rhs.__m23 + lhs.__m44 * rhs.__m24),

    __m31: (lhs.__m11 * rhs.__m31 + lhs.__m21 * rhs.__m32) +
    (lhs.__m31 * rhs.__m33 + lhs.__m41 * rhs.__m34),

    __m32: (lhs.__m12 * rhs.__m31 + lhs.__m22 * rhs.__m32) +
    (lhs.__m32 * rhs.__m33 + lhs.__m42 * rhs.__m34),

    __m33: (lhs.__m13 * rhs.__m31 + lhs.__m23 * rhs.__m32) +
    (lhs.__m33 * rhs.__m33 + lhs.__m43 * rhs.__m34),

    __m34: (lhs.__m14 * rhs.__m31 + lhs.__m24 * rhs.__m32) +
    (lhs.__m34 * rhs.__m33 + lhs.__m44 * rhs.__m34),

    __m41: (lhs.__m11 * rhs.__m41 + lhs.__m21 * rhs.__m42) +
    (lhs.__m31 * rhs.__m43 + lhs.__m41 * rhs.__m44),

    __m42: (lhs.__m12 * rhs.__m41 + lhs.__m22 * rhs.__m42) +
    (lhs.__m32 * rhs.__m43 + lhs.__m42 * rhs.__m44),

    __m43: (lhs.__m13 * rhs.__m41 + lhs.__m23 * rhs.__m42) +
    (lhs.__m33 * rhs.__m43 + lhs.__m43 * rhs.__m44),

    __m44: (lhs.__m14 * rhs.__m41 + lhs.__m24 * rhs.__m42) +
    (lhs.__m34 * rhs.__m43 + lhs.__m44 * rhs.__m44)
  )
}

func *<T: InstantiableMatrix4Type>(lhs: Matrix4Type, rhs: T) -> T {
  return T(
    __m11: (lhs.__m11 * rhs.__m11 + lhs.__m21 * rhs.__m12) +
    (lhs.__m31 * rhs.__m13 + lhs.__m41 * rhs.__m14),

    __m12: (lhs.__m12 * rhs.__m11 + lhs.__m22 * rhs.__m12) +
    (lhs.__m32 * rhs.__m13 + lhs.__m42 * rhs.__m14),

    __m13: (lhs.__m13 * rhs.__m11 + lhs.__m23 * rhs.__m12) +
    (lhs.__m33 * rhs.__m13 + lhs.__m43 * rhs.__m14),

    __m14: (lhs.__m14 * rhs.__m11 + lhs.__m24 * rhs.__m12) +
    (lhs.__m34 * rhs.__m13 + lhs.__m44 * rhs.__m14),

    __m21: (lhs.__m11 * rhs.__m21 + lhs.__m21 * rhs.__m22) +
    (lhs.__m31 * rhs.__m23 + lhs.__m41 * rhs.__m24),

    __m22: (lhs.__m12 * rhs.__m21 + lhs.__m22 * rhs.__m22) +
    (lhs.__m32 * rhs.__m23 + lhs.__m42 * rhs.__m24),

    __m23: (lhs.__m13 * rhs.__m21 + lhs.__m23 * rhs.__m22) +
    (lhs.__m33 * rhs.__m23 + lhs.__m43 * rhs.__m24),

    __m24: (lhs.__m14 * rhs.__m21 + lhs.__m24 * rhs.__m22) +
    (lhs.__m34 * rhs.__m23 + lhs.__m44 * rhs.__m24),

    __m31: (lhs.__m11 * rhs.__m31 + lhs.__m21 * rhs.__m32) +
    (lhs.__m31 * rhs.__m33 + lhs.__m41 * rhs.__m34),

    __m32: (lhs.__m12 * rhs.__m31 + lhs.__m22 * rhs.__m32) +
    (lhs.__m32 * rhs.__m33 + lhs.__m42 * rhs.__m34),

    __m33: (lhs.__m13 * rhs.__m31 + lhs.__m23 * rhs.__m32) +
    (lhs.__m33 * rhs.__m33 + lhs.__m43 * rhs.__m34),

    __m34: (lhs.__m14 * rhs.__m31 + lhs.__m24 * rhs.__m32) +
    (lhs.__m34 * rhs.__m33 + lhs.__m44 * rhs.__m34),

    __m41: (lhs.__m11 * rhs.__m41 + lhs.__m21 * rhs.__m42) +
    (lhs.__m31 * rhs.__m43 + lhs.__m41 * rhs.__m44),

    __m42: (lhs.__m12 * rhs.__m41 + lhs.__m22 * rhs.__m42) +
    (lhs.__m32 * rhs.__m43 + lhs.__m42 * rhs.__m44),

    __m43: (lhs.__m13 * rhs.__m41 + lhs.__m23 * rhs.__m42) +
    (lhs.__m33 * rhs.__m43 + lhs.__m43 * rhs.__m44),

    __m44: (lhs.__m14 * rhs.__m41 + lhs.__m24 * rhs.__m42) +
    (lhs.__m34 * rhs.__m43 + lhs.__m44 * rhs.__m44)
  )
}

func *<T: InstantiableMatrix4Type>(lhs: Scalar, rhs: T) -> T {
  return T(
    __m11: lhs * rhs.__m11, __m12: lhs * rhs.__m12, __m13: lhs * rhs.__m13, __m14: lhs * rhs.__m14,
    __m21: lhs * rhs.__m21, __m22: lhs * rhs.__m22, __m23: lhs * rhs.__m23, __m24: lhs * rhs.__m24,
    __m31: lhs * rhs.__m31, __m32: lhs * rhs.__m32, __m33: lhs * rhs.__m33, __m34: lhs * rhs.__m34,
    __m41: lhs * rhs.__m41, __m42: lhs * rhs.__m42, __m43: lhs * rhs.__m43, __m44: lhs * rhs.__m44
  )
}

func *<T: InstantiableMatrix4Type>(lhs: T, rhs: Scalar) -> T {
  return T(
    __m11: lhs.__m11 * rhs, __m12: lhs.__m12 * rhs, __m13: lhs.__m13 * rhs, __m14: lhs.__m14 * rhs,
    __m21: lhs.__m21 * rhs, __m22: lhs.__m22 * rhs, __m23: lhs.__m23 * rhs, __m24: lhs.__m24 * rhs,
    __m31: lhs.__m31 * rhs, __m32: lhs.__m32 * rhs, __m33: lhs.__m33 * rhs, __m34: lhs.__m34 * rhs,
    __m41: lhs.__m41 * rhs, __m42: lhs.__m42 * rhs, __m43: lhs.__m43 * rhs, __m44: lhs.__m44 * rhs
  )
}

//MARK: Concrete types

typealias Scalar = Double

struct Vector2 {
  var x: Scalar
  var y: Scalar
}

struct Vector3 {
  var x: Scalar
  var y: Scalar
  var z: Scalar
}

struct Vector4 {
  var x: Scalar
  var y: Scalar
  var z: Scalar
  var w: Scalar
}

struct Quaternion {
  var x: Scalar
  var y: Scalar
  var z: Scalar
  var w: Scalar
}

struct Matrix3 {
  var m11: Scalar
  var m12: Scalar
  var m13: Scalar
  var m21: Scalar
  var m22: Scalar
  var m23: Scalar
  var m31: Scalar
  var m32: Scalar
  var m33: Scalar
}

struct Matrix4 {
  var m11: Scalar
  var m12: Scalar
  var m13: Scalar
  var m14: Scalar
  var m21: Scalar
  var m22: Scalar
  var m23: Scalar
  var m24: Scalar
  var m31: Scalar
  var m32: Scalar
  var m33: Scalar
  var m34: Scalar
  var m41: Scalar
  var m42: Scalar
  var m43: Scalar
  var m44: Scalar
}

extension Vector2: Vector2Type {
  var __x: Scalar { return x }
  var __y: Scalar { return y }
}

extension Vector3: Vector3Type {
  var __x: Scalar { return x }
  var __y: Scalar { return y }
  var __z: Scalar { return z }
}

extension Vector4: Vector4Type {
  var __x: Scalar { return x }
  var __y: Scalar { return y }
  var __z: Scalar { return z }
  var __w: Scalar { return w }
}

extension Quaternion: QuaternionType {
  var __x: Scalar { return x }
  var __y: Scalar { return y }
  var __z: Scalar { return z }
  var __w: Scalar { return w }
}

extension Matrix3: Matrix3Type {
  var __m11: Scalar { return m11 }
  var __m12: Scalar { return m12 }
  var __m13: Scalar { return m13 }
  var __m21: Scalar { return m21 }
  var __m22: Scalar { return m22 }
  var __m23: Scalar { return m23 }
  var __m31: Scalar { return m31 }
  var __m32: Scalar { return m32 }
  var __m33: Scalar { return m33 }
}

extension Matrix4: Matrix4Type {
  var __m11: Scalar { return m11 }
  var __m12: Scalar { return m12 }
  var __m13: Scalar { return m13 }
  var __m14: Scalar { return m14 }
  var __m21: Scalar { return m21 }
  var __m22: Scalar { return m22 }
  var __m23: Scalar { return m23 }
  var __m24: Scalar { return m24 }
  var __m31: Scalar { return m31 }
  var __m32: Scalar { return m32 }
  var __m33: Scalar { return m33 }
  var __m34: Scalar { return m34 }
  var __m41: Scalar { return m41 }
  var __m42: Scalar { return m42 }
  var __m43: Scalar { return m43 }
  var __m44: Scalar { return m44 }
}

extension Vector2: InstantiableVector2Type {
  init(__x: Scalar, __y: Scalar) {
    self.init(__x, __y)
  }
}

extension Vector3: InstantiableVector3Type {
  init(__x: Scalar, __y: Scalar, __z: Scalar) {
    self.init(__x, __y, __z)
  }
}

extension Vector4: InstantiableVector4Type {
  init(__x: Scalar, __y: Scalar, __z: Scalar, __w: Scalar) {
    self.init(__x, __y, __z, __w)
  }
}

extension Quaternion: InstantiableQuaternionType {
  init(__x: Scalar, __y: Scalar, __z: Scalar, __w: Scalar) {
    self.init(__x, __y, __z, __w)
  }
}

extension Matrix3: InstantiableMatrix3Type {
  init(
    __m11: Scalar, __m12: Scalar, __m13: Scalar,
    __m21: Scalar, __m22: Scalar, __m23: Scalar,
    __m31: Scalar, __m32: Scalar, __m33: Scalar
  ) {
    self.init(
      __m11, __m12, __m13,
      __m21, __m22, __m23,
      __m31, __m32, __m33
    )
  }
}

extension Matrix4: InstantiableMatrix4Type {
  init(
    __m11: Scalar, __m12: Scalar, __m13: Scalar, __m14: Scalar,
    __m21: Scalar, __m22: Scalar, __m23: Scalar, __m24: Scalar,
    __m31: Scalar, __m32: Scalar, __m33: Scalar, __m34: Scalar,
    __m41: Scalar, __m42: Scalar, __m43: Scalar, __m44: Scalar
  ) {
    self.init(
      __m11, __m12, __m13, __m14,
      __m21, __m22, __m23, __m24,
      __m31, __m32, __m33, __m34,
      __m41, __m42, __m43, __m44
    )
  }
}

extension Scalar {
  static let Pi = Scalar(M_PI)
  static let HalfPi = Scalar(M_PI_2)
  static let QuarterPi = Scalar(M_PI_4)
  static let TwoPi = Scalar(M_PI * 2)
  static let DegreesPerRadian = 180 / Pi
  static let RadiansPerDegree = Pi / 180
  static let Epsilon: Scalar = 0.0001
}

extension Vector2: Equatable, Hashable {
  static let Zero = Vector2(0, 0)
  static let X = Vector2(1, 0)
  static let Y = Vector2(0, 1)

  var hashValue: Int {
    return __x.hashValue &+ __y.hashValue
  }

  init(_ x: Scalar, _ y: Scalar) {
    self.init(x: x, y: y)
  }

  init(_ v: [Scalar]) {
    assert(v.count == 2, "array must contain 2 elements, contained \(v.count)")

    x = v[0]
    y = v[1]
  }

  init(_ v: Vector2Type) {
    self.init(v.__x, v.__y)
  }
}

extension Vector3: Equatable, Hashable {
  static let Zero = Vector3(0, 0, 0)
  static let X = Vector3(1, 0, 0)
  static let Y = Vector3(0, 1, 0)
  static let Z = Vector3(0, 0, 1)

  var hashValue: Int {
    return __x.hashValue &+ __y.hashValue &+ __z.hashValue
  }

  init(_ x: Scalar, _ y: Scalar, _ z: Scalar) {
    self.init(x: x, y: y, z: z)
  }

  init(_ v: [Scalar]) {
    assert(v.count == 3, "array must contain 3 elements, contained \(v.count)")

    x = v[0]
    y = v[1]
    z = v[2]
  }

  init(_ v: Vector3Type) {
    self.init(v.__x, v.__y, v.__z)
  }
}

extension Vector4: Equatable, Hashable {
  static let Zero = Vector4(0, 0, 0, 0)
  static let X = Vector4(1, 0, 0, 0)
  static let Y = Vector4(0, 1, 0, 0)
  static let Z = Vector4(0, 0, 1, 0)
  static let W = Vector4(0, 0, 0, 1)

  var hashValue: Int {
    return __x.hashValue &+ __y.hashValue &+ __z.hashValue &+ __w.hashValue
  }

  init(_ x: Scalar, _ y: Scalar, _ z: Scalar, _ w: Scalar) {
    self.init(x: x, y: y, z: z, w: w)
  }

  init(_ v: [Scalar]) {
    assert(v.count == 4, "array must contain 4 elements, contained \(v.count)")

    x = v[0]
    y = v[1]
    z = v[2]
    w = v[3]
  }

  init(_ v: Vector4Type) {
    self.init(v.__x, v.__y, v.__z, v.__w)
  }
}

extension Quaternion: Equatable, Hashable {
  static let Zero = Quaternion(0, 0, 0, 0)
  static let Identity = Quaternion(0, 0, 0, 1)

  var hashValue: Int {
    return x.hashValue &+ y.hashValue &+ z.hashValue &+ w.hashValue
  }

  init(_ x: Scalar, _ y: Scalar, _ z: Scalar, _ w: Scalar) {
    self.init(x: x, y: y, z: z, w: w)
  }

  init(_ v: [Scalar]) {
    assert(v.count == 4, "array must contain 4 elements, contained \(v.count)")

    x = v[0]
    y = v[1]
    z = v[2]
    w = v[3]
  }

  init(_ v: QuaternionType) {
    self.init(v.__x, v.__y, v.__z, v.__w)
  }
}

extension Matrix3: Equatable, Hashable {
  static let Identity = Matrix3(1, 0, 0, 0, 1, 0, 0, 0, 1)

  var hashValue: Int {
    var hash = m11.hashValue &+ m12.hashValue &+ m13.hashValue
    hash = hash &+ m21.hashValue &+ m22.hashValue &+ m23.hashValue
    hash = hash &+ m31.hashValue &+ m32.hashValue &+ m33.hashValue
    return hash
  }

  init(_ m11: Scalar, _ m12: Scalar, _ m13: Scalar,
    _ m21: Scalar, _ m22: Scalar, _ m23: Scalar,
    _ m31: Scalar, _ m32: Scalar, _ m33: Scalar) {

    self.m11 = m11 // 0
    self.m12 = m12 // 1
    self.m13 = m13 // 2
    self.m21 = m21 // 3
    self.m22 = m22 // 4
    self.m23 = m23 // 5
    self.m31 = m31 // 6
    self.m32 = m32 // 7
    self.m33 = m33 // 8
  }

  init(_ m: [Scalar]) {
    assert(m.count == 9, "array must contain 9 elements, contained \(m.count)")

    self.init(m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8])
  }

  init(_ m: Matrix3Type) {
    self.init(
      m.__m11, m.__m12, m.__m13,
      m.__m21, m.__m22, m.__m23,
      m.__m31, m.__m32, m.__m33
    )
  }
}

extension Matrix4: Equatable, Hashable {
  static let Identity = Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)

  var hashValue: Int {
    var hash = m11.hashValue &+ m12.hashValue &+ m13.hashValue &+ m14.hashValue
    hash = hash &+ m21.hashValue &+ m22.hashValue &+ m23.hashValue &+ m24.hashValue
    hash = hash &+ m31.hashValue &+ m32.hashValue &+ m33.hashValue &+ m34.hashValue
    hash = hash &+ m41.hashValue &+ m42.hashValue &+ m43.hashValue &+ m44.hashValue
    return hash
  }

  init(_ m11: Scalar, _ m12: Scalar, _ m13: Scalar, _ m14: Scalar,
    _ m21: Scalar, _ m22: Scalar, _ m23: Scalar, _ m24: Scalar,
    _ m31: Scalar, _ m32: Scalar, _ m33: Scalar, _ m34: Scalar,
    _ m41: Scalar, _ m42: Scalar, _ m43: Scalar, _ m44: Scalar) {

    self.m11 = m11 // 0
    self.m12 = m12 // 1
    self.m13 = m13 // 2
    self.m14 = m14 // 3
    self.m21 = m21 // 4
    self.m22 = m22 // 5
    self.m23 = m23 // 6
    self.m24 = m24 // 7
    self.m31 = m31 // 8
    self.m32 = m32 // 9
    self.m33 = m33 // 10
    self.m34 = m34 // 11
    self.m41 = m41 // 12
    self.m42 = m42 // 13
    self.m43 = m43 // 14
    self.m44 = m44 // 15
  }

  init(_ m: [Scalar]) {
    assert(m.count == 16, "array must contain 16 elements, contained \(m.count)")

    m11 = m[0]
    m12 = m[1]
    m13 = m[2]
    m14 = m[3]
    m21 = m[4]
    m22 = m[5]
    m23 = m[6]
    m24 = m[7]
    m31 = m[8]
    m32 = m[9]
    m33 = m[10]
    m34 = m[11]
    m41 = m[12]
    m42 = m[13]
    m43 = m[14]
    m44 = m[15]
  }

  init(_ m: Matrix4Type) {
    self.init(
      m.__m11, m.__m12, m.__m13, m.__m14,
      m.__m21, m.__m22, m.__m23, m.__m24,
      m.__m31, m.__m32, m.__m33, m.__m34,
      m.__m41, m.__m42, m.__m43, m.__m44
    )
  }
}

func ~=(lhs: Scalar, rhs: Scalar) -> Bool {
  return abs(lhs - rhs) < .Epsilon
}

func ==(lhs: Vector2, rhs: Vector2) -> Bool {
  return lhs.vector2IsEqual(rhs)
}

func ==(lhs: Vector3, rhs: Vector3) -> Bool {
  return lhs.vector3IsEqual(rhs)
}

func ==(lhs: Vector4, rhs: Vector4) -> Bool {
  return lhs.vector4IsEqual(rhs)
}

func ==(lhs: Quaternion, rhs: Quaternion) -> Bool {
  return lhs.quaternionIsEqual(rhs)
}

func ==(lhs: Matrix3, rhs: Matrix3) -> Bool {
  return lhs.matrix3IsEqual(rhs)
}

func ==(lhs: Matrix4, rhs: Matrix4) -> Bool {
  return lhs.matrix4IsEqual(rhs)
}

func ~=(lhs: Vector2, rhs: Vector2) -> Bool {
  return lhs.vector2IsApproxEqual(rhs)
}

func ~=(lhs: Vector3, rhs: Vector3) -> Bool {
  return lhs.vector3IsApproxEqual(rhs)
}

func ~=(lhs: Vector4, rhs: Vector4) -> Bool {
  return lhs.vector4IsApproxEqual(rhs)
}

func ~=(lhs: Quaternion, rhs: Quaternion) -> Bool {
  return lhs.quaternionIsApproxEqual(rhs)
}

func ~=(lhs: Matrix3, rhs: Matrix3) -> Bool {
  return lhs.matrix3IsApproxEqual(rhs)
}

func ~=(lhs: Matrix4, rhs: Matrix4) -> Bool {
  return lhs.matrix4IsApproxEqual(rhs)
}

