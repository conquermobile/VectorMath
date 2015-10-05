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
  var _x: Scalar { get }
  var _y: Scalar { get }
}

protocol Vector3Type {
  var _x: Scalar { get }
  var _y: Scalar { get }
  var _z: Scalar { get }
}

protocol Vector4Type {
  var _x: Scalar { get }
  var _y: Scalar { get }
  var _z: Scalar { get }
  var _w: Scalar { get }
}

protocol QuaternionType: Vector4Type {}

protocol Matrix3Type {
  var _m11: Scalar { get }
  var _m12: Scalar { get }
  var _m13: Scalar { get }
  var _m21: Scalar { get }
  var _m22: Scalar { get }
  var _m23: Scalar { get }
  var _m31: Scalar { get }
  var _m32: Scalar { get }
  var _m33: Scalar { get }
}

protocol Matrix4Type {
  var _m11: Scalar { get }
  var _m12: Scalar { get }
  var _m13: Scalar { get }
  var _m14: Scalar { get }
  var _m21: Scalar { get }
  var _m22: Scalar { get }
  var _m23: Scalar { get }
  var _m24: Scalar { get }
  var _m31: Scalar { get }
  var _m32: Scalar { get }
  var _m33: Scalar { get }
  var _m34: Scalar { get }
  var _m41: Scalar { get }
  var _m42: Scalar { get }
  var _m43: Scalar { get }
  var _m44: Scalar { get }
}

protocol InstantiableVector2Type: Vector2Type {
  init(_x: Scalar, _y: Scalar)
}

protocol InstantiableVector3Type: Vector3Type {
  init(_x: Scalar, _y: Scalar, _z: Scalar)
}

protocol InstantiableVector4Type: Vector4Type {
  init(_x: Scalar, _y: Scalar, _z: Scalar, _w: Scalar)
}

protocol InstantiableQuaternionType: QuaternionType, InstantiableVector4Type {}

protocol InstantiableMatrix3Type: Matrix3Type {
  init(
    _m11: Scalar, _m12: Scalar, _m13: Scalar,
    _m21: Scalar, _m22: Scalar, _m23: Scalar,
    _m31: Scalar, _m32: Scalar, _m33: Scalar
  )
}

protocol InstantiableMatrix4Type: Matrix4Type {
  init(
    _m11: Scalar, _m12: Scalar, _m13: Scalar, _m14: Scalar,
    _m21: Scalar, _m22: Scalar, _m23: Scalar, _m24: Scalar,
    _m31: Scalar, _m32: Scalar, _m33: Scalar, _m34: Scalar,
    _m41: Scalar, _m42: Scalar, _m43: Scalar, _m44: Scalar
  )
}

//MARK: Vector2

extension Vector2Type {
  var lengthSquared: Scalar {
    return _x * _x + _y * _y
  }

  var length: Scalar {
    return sqrt(lengthSquared)
  }

  func toArray() -> [Scalar] {
    return [_x, _y]
  }

  func dot(v: Vector2Type) -> Scalar {
    return _x * v._x + _y * v._y
  }

  func cross(v: Vector2Type) -> Scalar {
    return _x * v._y - _y * v._x
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
    return _x == v._x && _y == v._y
  }

  func vector2IsApproxEqual(v: Vector2Type) -> Bool {
    return _x ~= v._x && _y ~= v._y
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
    return Self(_x: _x * cs - _y * sn, _y: _x * sn + _y * cs)
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
  return T(_x: -v._x, _y: -v._y)
}

func +<T: InstantiableVector2Type>(lhs: T, rhs: T) -> T {
  return T(_x: lhs._x + rhs._x, _y: lhs._y + rhs._y)
}

func +<T: InstantiableVector2Type>(lhs: T, rhs: Vector2Type) -> T {
  return T(_x: lhs._x + rhs._x, _y: lhs._y + rhs._y)
}

func +<T: InstantiableVector2Type>(lhs: Vector2Type, rhs: T) -> T {
  return T(_x: lhs._x + rhs._x, _y: lhs._y + rhs._y)
}

func -<T: InstantiableVector2Type>(lhs: T, rhs: T) -> T {
  return T(_x: lhs._x - rhs._x, _y: lhs._y - rhs._y)
}

func -<T: InstantiableVector2Type>(lhs: T, rhs: Vector2Type) -> T {
  return T(_x: lhs._x - rhs._x, _y: lhs._y - rhs._y)
}

func -<T: InstantiableVector2Type>(lhs: Vector2Type, rhs: T) -> T {
  return T(_x: lhs._x - rhs._x, _y: lhs._y - rhs._y)
}

func *<T: InstantiableVector2Type>(lhs: T, rhs: T) -> T {
  return T(_x: lhs._x * rhs._x, _y: lhs._y * rhs._y)
}

func *<T: InstantiableVector2Type>(lhs: T, rhs: Vector2Type) -> T {
  return T(_x: lhs._x * rhs._x, _y: lhs._y * rhs._y)
}

func *<T: InstantiableVector2Type>(lhs: Vector2Type, rhs: T) -> T {
  return T(_x: lhs._x * rhs._x, _y: lhs._y * rhs._y)
}

func *<T: InstantiableVector2Type>(lhs: Scalar, rhs: T) -> T {
  return T(_x: lhs * rhs._x, _y: lhs * rhs._y)
}

func *<T: InstantiableVector2Type>(lhs: T, rhs: Scalar) -> T {
  return T(_x: lhs._x * rhs, _y: lhs._y * rhs)
}

func *<T: InstantiableVector2Type>(lhs: T, rhs: Matrix3Type) -> T {
  return T(
    _x: lhs._x * rhs._m11 + lhs._y * rhs._m21 + rhs._m31,
    _y: lhs._x * rhs._m12 + lhs._y * rhs._m22 + rhs._m32
  )
}

func *<T: InstantiableVector2Type>(lhs: Matrix3Type, rhs: T) -> T {
  return rhs * lhs
}

func /<T: InstantiableVector2Type>(lhs: T, rhs: T) -> T {
  return T(_x: lhs._x / rhs._x, _y: lhs._y / rhs._y)
}

func /<T: InstantiableVector2Type>(lhs: T, rhs: Vector2Type) -> T {
  return T(_x: lhs._x / rhs._x, _y: lhs._y / rhs._y)
}

func /<T: InstantiableVector2Type>(lhs: Vector2Type, rhs: T) -> T {
  return T(_x: lhs._x / rhs._x, _y: lhs._y / rhs._y)
}

func /<T: InstantiableVector2Type>(lhs: T, rhs: Scalar) -> T {
  return T(_x: lhs._x / rhs, _y: lhs._y / rhs)
}

//MARK: Vector3

extension Vector3Type {
  var lengthSquared: Scalar {
    return _x * _x + _y * _y + _z * _z
  }

  var length: Scalar {
    return sqrt(lengthSquared)
  }

  func toArray() -> [Scalar] {
    return [_x, _y, _z]
  }

  func dot(v: Vector3Type) -> Scalar {
    return _x * v._x + _y * v._y + _z * v._z
  }

  func xy<T: InstantiableVector2Type>() -> T {
    return T(_x: _x, _y: _y)
  }

  func xz<T: InstantiableVector2Type>() -> T {
    return T(_x: _x, _y: _z)
  }

  func yz<T: InstantiableVector2Type>() -> T {
    return T(_x: _y, _y: _z)
  }

  func vector3IsEqual(v: Vector3Type) -> Bool {
    return _x == v._x && _y == v._y && _z == v._z
  }

  func vector3IsApproxEqual(v: Vector3Type) -> Bool {
    return _x ~= v._x && _y ~= v._y && _z ~= v._z
  }
}

extension InstantiableVector3Type {
  var inverse: Self {
    return -self
  }

  func cross(v: Vector3Type) -> Self {
    return Self(
      _x: _y * v._z - _z * v._y,
      _y: _z * v._x - _x * v._z,
      _z: _x * v._y - _y * v._x
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
  return T(_x: -v._x, _y: -v._y, _z: -v._z)
}

func +<T: InstantiableVector3Type>(lhs: T, rhs: T) -> T {
  return T(_x: lhs._x + rhs._x, _y: lhs._y + rhs._y, _z: lhs._z + rhs._z)
}

func +<T: InstantiableVector3Type>(lhs: T, rhs: Vector3Type) -> T {
  return T(_x: lhs._x + rhs._x, _y: lhs._y + rhs._y, _z: lhs._z + rhs._z)
}

func +<T: InstantiableVector3Type>(lhs: Vector3Type, rhs: T) -> T {
  return T(_x: lhs._x + rhs._x, _y: lhs._y + rhs._y, _z: lhs._z + rhs._z)
}

func -<T: InstantiableVector3Type>(lhs: T, rhs: T) -> T {
  return T(_x: lhs._x - rhs._x, _y: lhs._y - rhs._y, _z: lhs._z - rhs._z)
}

func -<T: InstantiableVector3Type>(lhs: T, rhs: Vector3Type) -> T {
  return T(_x: lhs._x - rhs._x, _y: lhs._y - rhs._y, _z: lhs._z - rhs._z)
}

func -<T: InstantiableVector3Type>(lhs: Vector3Type, rhs: T) -> T {
  return T(_x: lhs._x - rhs._x, _y: lhs._y - rhs._y, _z: lhs._z - rhs._z)
}

func *<T: InstantiableVector3Type>(lhs: T, rhs: T) -> T {
  return T(_x: lhs._x * rhs._x, _y: lhs._y * rhs._y, _z: lhs._z * rhs._z)
}

func *<T: InstantiableVector3Type>(lhs: T, rhs: Vector3Type) -> T {
  return T(_x: lhs._x * rhs._x, _y: lhs._y * rhs._y, _z: lhs._z * rhs._z)
}

func *<T: InstantiableVector3Type>(lhs: Vector3Type, rhs: T) -> T {
  return T(_x: lhs._x * rhs._x, _y: lhs._y * rhs._y, _z: lhs._z * rhs._z)
}

func *<T: InstantiableVector3Type>(lhs: Scalar, rhs: T) -> T {
  return T(_x: lhs * rhs._x, _y: lhs * rhs._y, _z: lhs * rhs._z)
}

func *<T: InstantiableVector3Type>(lhs: T, rhs: Scalar) -> T {
  return T(_x: lhs._x * rhs, _y: lhs._y * rhs, _z: lhs._z * rhs)
}

func *<T: InstantiableVector3Type>(lhs: T, rhs: Matrix3Type) -> T {
  return T(
    _x: lhs._x * rhs._m11 + lhs._y * rhs._m21 + lhs._z * rhs._m31,
    _y: lhs._x * rhs._m12 + lhs._y * rhs._m22 + lhs._z * rhs._m32,
    _z: lhs._x * rhs._m13 + lhs._y * rhs._m23 + lhs._z * rhs._m33
  )
}

func *<T: InstantiableVector3Type>(lhs: T, rhs: Matrix4Type) -> T {
  return T(
    _x: lhs._x * rhs._m11 + lhs._y * rhs._m21 + lhs._z * rhs._m31 + rhs._m41,
    _y: lhs._x * rhs._m12 + lhs._y * rhs._m22 + lhs._z * rhs._m32 + rhs._m42,
    _z: lhs._x * rhs._m13 + lhs._y * rhs._m23 + lhs._z * rhs._m33 + rhs._m43
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
  let sub = uv * 2 * q._w
  return v + sub + (uuv * 2)
}

func *<T: InstantiableVector3Type>(lhs: QuaternionType, rhs: T) -> T {
  return rhs * lhs
}

func /<T: InstantiableVector3Type>(lhs: T, rhs: T) -> T {
  return T(_x: lhs._x / rhs._x, _y: lhs._y / rhs._y, _z: lhs._z / rhs._z)
}

func /<T: InstantiableVector3Type>(lhs: T, rhs: Vector3Type) -> T {
  return T(_x: lhs._x / rhs._x, _y: lhs._y / rhs._y, _z: lhs._z / rhs._z)
}

func /<T: InstantiableVector3Type>(lhs: Vector3Type, rhs: T) -> T {
  return T(_x: lhs._x / rhs._x, _y: lhs._y / rhs._y, _z: lhs._z / rhs._z)
}

func /<T: InstantiableVector3Type>(lhs: T, rhs: Scalar) -> T {
  return T(_x: lhs._x / rhs, _y: lhs._y / rhs, _z: lhs._z / rhs)
}

//MARK: Vector4

extension Vector4Type {
  var lengthSquared: Scalar {
    return _x * _x + _y * _y + _z * _z + _w * _w
  }

  var length: Scalar {
    return sqrt(lengthSquared)
  }

  func toArray() -> [Scalar] {
    return [_x, _y, _z, _w]
  }

  func dot(v: Vector4Type) -> Scalar {
    return _x * v._x + _y * v._y + _z * v._z + _w * v._w
  }

  func xyz<T: InstantiableVector3Type>() -> T {
    return T(_x: _x, _y: _y, _z: _z)
  }

  func xy<T: InstantiableVector2Type>() -> T {
    return T(_x: _x, _y: _y)
  }

  func xz<T: InstantiableVector2Type>() -> T {
    return T(_x: _x, _y: _z)
  }

  func yz<T: InstantiableVector2Type>() -> T {
    return T(_x: _y, _y: _z)
  }

  func vector4IsEqual(v: Vector4Type) -> Bool {
    return _x == v._x && _y == v._y && _z == v._z && _w == v._w
  }

  func vector4IsApproxEqual(v: Vector4Type) -> Bool {
    return _x ~= v._x && _y ~= v._y && _z ~= v._z && _w ~= v._w
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
  return T(_x: -v._x, _y: -v._y, _z: -v._z, _w: -v._w)
}

func +<T: InstantiableVector4Type>(lhs: T, rhs: T) -> T {
  return T(_x: lhs._x + rhs._x, _y: lhs._y + rhs._y, _z: lhs._z + rhs._z, _w: lhs._w + rhs._w)
}

func +<T: InstantiableVector4Type>(lhs: T, rhs: Vector4Type) -> T {
  return T(_x: lhs._x + rhs._x, _y: lhs._y + rhs._y, _z: lhs._z + rhs._z, _w: lhs._w + rhs._w)
}

func +<T: InstantiableVector4Type>(lhs: Vector4Type, rhs: T) -> T {
  return T(_x: lhs._x + rhs._x, _y: lhs._y + rhs._y, _z: lhs._z + rhs._z, _w: lhs._w + rhs._w)
}

func -<T: InstantiableVector4Type>(lhs: T, rhs: T) -> T {
  return T(_x: lhs._x - rhs._x, _y: lhs._y - rhs._y, _z: lhs._z - rhs._z, _w: lhs._w - rhs._w)
}

func -<T: InstantiableVector4Type>(lhs: T, rhs: Vector4Type) -> T {
  return T(_x: lhs._x - rhs._x, _y: lhs._y - rhs._y, _z: lhs._z - rhs._z, _w: lhs._w - rhs._w)
}

func -<T: InstantiableVector4Type>(lhs: Vector4Type, rhs: T) -> T {
  return T(_x: lhs._x - rhs._x, _y: lhs._y - rhs._y, _z: lhs._z - rhs._z, _w: lhs._w - rhs._w)
}

func *<T: InstantiableVector4Type>(lhs: T, rhs: T) -> T {
  return T(_x: lhs._x * rhs._x, _y: lhs._y * rhs._y, _z: lhs._z * rhs._z, _w: lhs._w * rhs._w)
}

func *<T: InstantiableVector4Type>(lhs: T, rhs: Vector4Type) -> T {
  return T(_x: lhs._x * rhs._x, _y: lhs._y * rhs._y, _z: lhs._z * rhs._z, _w: lhs._w * rhs._w)
}

func *<T: InstantiableVector4Type>(lhs: Vector4Type, rhs: T) -> T {
  return T(_x: lhs._x * rhs._x, _y: lhs._y * rhs._y, _z: lhs._z * rhs._z, _w: lhs._w * rhs._w)
}

func *<T: InstantiableVector4Type>(lhs: Scalar, rhs: T) -> T {
  return T(_x: lhs * rhs._x, _y: lhs * rhs._y, _z: lhs * rhs._z, _w: lhs * rhs._w)
}

func *<T: InstantiableVector4Type>(lhs: T, rhs: Scalar) -> T {
  return T(_x: lhs._x * rhs, _y: lhs._y * rhs, _z: lhs._z * rhs, _w: lhs._w * rhs)
}

func *<T: InstantiableVector4Type>(lhs: T, rhs: Matrix4Type) -> T {
  return T(
    _x: lhs._x * rhs._m11 + lhs._y * rhs._m21 + lhs._z * rhs._m31 + lhs._w * rhs._m41,
    _y: lhs._x * rhs._m12 + lhs._y * rhs._m22 + lhs._z * rhs._m32 + lhs._w * rhs._m42,
    _z: lhs._x * rhs._m13 + lhs._y * rhs._m23 + lhs._z * rhs._m33 + lhs._w * rhs._m43,
    _w: lhs._x * rhs._m14 + lhs._y * rhs._m24 + lhs._z * rhs._m34 + lhs._w * rhs._m44
  )
}

func *<T: InstantiableVector4Type>(lhs: Matrix4Type, rhs: T) -> T {
  return rhs * lhs
}

func /<T: InstantiableVector4Type>(lhs: T, rhs: T) -> T {
  return T(_x: lhs._x / rhs._x, _y: lhs._y / rhs._y, _z: lhs._z / rhs._z, _w: lhs._w / rhs._w)
}

func /<T: InstantiableVector4Type>(lhs: T, rhs: Vector4Type) -> T {
  return T(_x: lhs._x / rhs._x, _y: lhs._y / rhs._y, _z: lhs._z / rhs._z, _w: lhs._w / rhs._w)
}

func /<T: InstantiableVector4Type>(lhs: Vector4Type, rhs: T) -> T {
  return T(_x: lhs._x / rhs._x, _y: lhs._y / rhs._y, _z: lhs._z / rhs._z, _w: lhs._w / rhs._w)
}

func /<T: InstantiableVector4Type>(lhs: T, rhs: Scalar) -> T {
  return T(_x: lhs._x / rhs, _y: lhs._y / rhs, _z: lhs._z / rhs, _w: lhs._w / rhs)
}

//MARK: Quaternion

extension QuaternionType {
  var pitch: Scalar {
    return atan2(2 * (_y * _z + _w * _x), _w * _w - _x * _x - _y * _y + _z * _z)
  }

  var yaw: Scalar {
    return asin(-2 * (_x * _z - _w * _y))
  }

  var roll: Scalar {
    return atan2(2 * (_x * _y + _w * _z), _w * _w + _x * _x - _y * _y - _z * _z)
  }

  func toPitchYawRoll() -> (pitch: Scalar, yaw: Scalar, roll: Scalar) {
    return (pitch, yaw, roll)
  }

  func toAxisAngle<T: InstantiableVector4Type>() -> T {
    let xyzVector: Vector3 = xyz()
    let scale = xyzVector.length
    if scale ~= 0 || scale ~= .TwoPi {
      return T(_x: 0, _y: 0, _z: 1, _w: 0)
    } else {
      return T(_x: _x / scale, _y: _y / scale, _z: _z / scale, _w: acos(_w) * 2)
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
}

func *<T: InstantiableQuaternionType>(lhs: T, rhs: T) -> T {
  return T(
    _x: lhs._w * rhs._x + lhs._x * rhs._w + lhs._y * rhs._z - lhs._z * rhs._y,
    _y: lhs._w * rhs._y + lhs._y * rhs._w + lhs._z * rhs._x - lhs._x * rhs._z,
    _z: lhs._w * rhs._z + lhs._z * rhs._w + lhs._x * rhs._y - lhs._y * rhs._x,
    _w: lhs._w * rhs._w - lhs._x * rhs._x - lhs._y * rhs._y - lhs._z * rhs._z
  )
}

func *<T: InstantiableQuaternionType>(lhs: T, rhs: QuaternionType) -> T {
  return T(
    _x: lhs._w * rhs._x + lhs._x * rhs._w + lhs._y * rhs._z - lhs._z * rhs._y,
    _y: lhs._w * rhs._y + lhs._y * rhs._w + lhs._z * rhs._x - lhs._x * rhs._z,
    _z: lhs._w * rhs._z + lhs._z * rhs._w + lhs._x * rhs._y - lhs._y * rhs._x,
    _w: lhs._w * rhs._w - lhs._x * rhs._x - lhs._y * rhs._y - lhs._z * rhs._z
  )
}

func *<T: InstantiableQuaternionType>(lhs: QuaternionType, rhs: T) -> T {
  return T(
    _x: lhs._w * rhs._x + lhs._x * rhs._w + lhs._y * rhs._z - lhs._z * rhs._y,
    _y: lhs._w * rhs._y + lhs._y * rhs._w + lhs._z * rhs._x - lhs._x * rhs._z,
    _z: lhs._w * rhs._z + lhs._z * rhs._w + lhs._x * rhs._y - lhs._y * rhs._x,
    _w: lhs._w * rhs._w - lhs._x * rhs._x - lhs._y * rhs._y - lhs._z * rhs._z
  )
}

//MARK: Matrix3

extension Matrix3Type {
  func toArray() -> [Scalar] {
    return [_m11, _m12, _m13, _m21, _m22, _m23, _m31, _m32, _m33]
  }

  var determinant: Scalar {
    return (_m11 * _m22 * _m33 + _m12 * _m23 * _m31 + _m13 * _m21 * _m32)
      - (_m13 * _m22 * _m31 + _m11 * _m23 * _m32 + _m12 * _m21 * _m33)
  }

  func matrix3IsEqual(m: Matrix3Type) -> Bool {
    return
      _m11 == m._m11 && _m12 == m._m12 && _m13 == m._m13 &&
      _m21 == m._m21 && _m22 == m._m22 && _m23 == m._m23 &&
      _m31 == m._m31 && _m32 == m._m32 && _m33 == m._m33
  }

  func matrix3IsApproxEqual(m: Matrix3Type) -> Bool {
    return
      _m11 ~= m._m11 && _m12 ~= m._m12 && _m13 ~= m._m13 &&
      _m21 ~= m._m21 && _m22 ~= m._m22 && _m23 ~= m._m23 &&
      _m31 ~= m._m31 && _m32 ~= m._m32 && _m33 ~= m._m33
  }
}

extension InstantiableMatrix3Type {
  var adjugate: Self {
    return Self(
      _m11: _m22 * _m33 - _m23 * _m32,
      _m12: _m13 * _m32 - _m12 * _m33,
      _m13: _m12 * _m23 - _m13 * _m22,
      _m21: _m23 * _m31 - _m21 * _m33,
      _m22: _m11 * _m33 - _m13 * _m31,
      _m23: _m13 * _m21 - _m11 * _m23,
      _m31: _m21 * _m32 - _m22 * _m31,
      _m32: _m12 * _m31 - _m11 * _m32,
      _m33: _m11 * _m22 - _m12 * _m21
    )
  }

  var transpose: Self {
    return Self(
      _m11: _m11, _m12: _m21, _m13: _m31,
      _m21: _m12, _m22: _m22, _m23: _m32,
      _m31: _m13, _m32: _m23, _m33: _m33
    )
  }

  var inverse: Self {
    return adjugate * (1 / determinant)
  }

  func interpolatedWith(m: Matrix3Type, t: Scalar) -> Self {
    return Self(
      _m11: _m11 + (m._m11 - _m11) * t,
      _m12: _m12 + (m._m12 - _m12) * t,
      _m13: _m13 + (m._m13 - _m13) * t,
      _m21: _m21 + (m._m21 - _m21) * t,
      _m22: _m22 + (m._m22 - _m22) * t,
      _m23: _m23 + (m._m23 - _m23) * t,
      _m31: _m31 + (m._m31 - _m31) * t,
      _m32: _m32 + (m._m32 - _m32) * t,
      _m33: _m33 + (m._m33 - _m33) * t
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
    _m11: lhs._m11 * rhs._m11 + lhs._m21 * rhs._m12 + lhs._m31 * rhs._m13,
    _m12: lhs._m12 * rhs._m11 + lhs._m22 * rhs._m12 + lhs._m32 * rhs._m13,
    _m13: lhs._m13 * rhs._m11 + lhs._m23 * rhs._m12 + lhs._m33 * rhs._m13,
    _m21: lhs._m11 * rhs._m21 + lhs._m21 * rhs._m22 + lhs._m31 * rhs._m23,
    _m22: lhs._m12 * rhs._m21 + lhs._m22 * rhs._m22 + lhs._m32 * rhs._m23,
    _m23: lhs._m13 * rhs._m21 + lhs._m23 * rhs._m22 + lhs._m33 * rhs._m23,
    _m31: lhs._m11 * rhs._m31 + lhs._m21 * rhs._m32 + lhs._m31 * rhs._m33,
    _m32: lhs._m12 * rhs._m31 + lhs._m22 * rhs._m32 + lhs._m32 * rhs._m33,
    _m33: lhs._m13 * rhs._m31 + lhs._m23 * rhs._m32 + lhs._m33 * rhs._m33
  )
}

func *<T: InstantiableMatrix3Type>(lhs: T, rhs: Matrix3Type) -> T {
  return T(
    _m11: lhs._m11 * rhs._m11 + lhs._m21 * rhs._m12 + lhs._m31 * rhs._m13,
    _m12: lhs._m12 * rhs._m11 + lhs._m22 * rhs._m12 + lhs._m32 * rhs._m13,
    _m13: lhs._m13 * rhs._m11 + lhs._m23 * rhs._m12 + lhs._m33 * rhs._m13,
    _m21: lhs._m11 * rhs._m21 + lhs._m21 * rhs._m22 + lhs._m31 * rhs._m23,
    _m22: lhs._m12 * rhs._m21 + lhs._m22 * rhs._m22 + lhs._m32 * rhs._m23,
    _m23: lhs._m13 * rhs._m21 + lhs._m23 * rhs._m22 + lhs._m33 * rhs._m23,
    _m31: lhs._m11 * rhs._m31 + lhs._m21 * rhs._m32 + lhs._m31 * rhs._m33,
    _m32: lhs._m12 * rhs._m31 + lhs._m22 * rhs._m32 + lhs._m32 * rhs._m33,
    _m33: lhs._m13 * rhs._m31 + lhs._m23 * rhs._m32 + lhs._m33 * rhs._m33
  )
}

func *<T: InstantiableMatrix3Type>(lhs: Matrix3Type, rhs: T) -> T {
  return T(
    _m11: lhs._m11 * rhs._m11 + lhs._m21 * rhs._m12 + lhs._m31 * rhs._m13,
    _m12: lhs._m12 * rhs._m11 + lhs._m22 * rhs._m12 + lhs._m32 * rhs._m13,
    _m13: lhs._m13 * rhs._m11 + lhs._m23 * rhs._m12 + lhs._m33 * rhs._m13,
    _m21: lhs._m11 * rhs._m21 + lhs._m21 * rhs._m22 + lhs._m31 * rhs._m23,
    _m22: lhs._m12 * rhs._m21 + lhs._m22 * rhs._m22 + lhs._m32 * rhs._m23,
    _m23: lhs._m13 * rhs._m21 + lhs._m23 * rhs._m22 + lhs._m33 * rhs._m23,
    _m31: lhs._m11 * rhs._m31 + lhs._m21 * rhs._m32 + lhs._m31 * rhs._m33,
    _m32: lhs._m12 * rhs._m31 + lhs._m22 * rhs._m32 + lhs._m32 * rhs._m33,
    _m33: lhs._m13 * rhs._m31 + lhs._m23 * rhs._m32 + lhs._m33 * rhs._m33
  )
}

func *<T: InstantiableMatrix3Type>(lhs: Scalar, rhs: T) -> T {
  return T(
    _m11: lhs * rhs._m11, _m12: lhs * rhs._m12, _m13: lhs * rhs._m13,
    _m21: lhs * rhs._m21, _m22: lhs * rhs._m22, _m23: lhs * rhs._m23,
    _m31: lhs * rhs._m31, _m32: lhs * rhs._m32, _m33: lhs * rhs._m33
  )
}

func *<T: InstantiableMatrix3Type>(lhs: T, rhs: Scalar) -> T {
  return T(
    _m11: lhs._m11 * rhs, _m12: lhs._m12 * rhs, _m13: lhs._m13 * rhs,
    _m21: lhs._m21 * rhs, _m22: lhs._m22 * rhs, _m23: lhs._m23 * rhs,
    _m31: lhs._m31 * rhs, _m32: lhs._m32 * rhs, _m33: lhs._m33 * rhs
  )
}

//MARK: Matrix4

extension Matrix4Type {
  func toArray() -> [Scalar] {
    return [
      _m11, _m12, _m13, _m14,
      _m21, _m22, _m23, _m24,
      _m31, _m32, _m33, _m34,
      _m41, _m42, _m43, _m44
    ]
  }

  private func determinantForAdjugate(m: Matrix4Type) -> Scalar {
    return _m11 * m._m11 + _m12 * m._m21 + _m13 * m._m31 + _m14 * m._m41
  }

  var determinant: Scalar {
    let copy = Matrix4(self)
    return determinantForAdjugate(copy.adjugate)
  }

  func matrix4IsEqual(m: Matrix4Type) -> Bool {
    return
      _m11 == m._m11 && _m12 == m._m12 && _m13 == m._m13 && _m14 == m._m14 &&
      _m21 == m._m21 && _m22 == m._m22 && _m23 == m._m23 && _m24 == m._m24 &&
      _m31 == m._m31 && _m32 == m._m32 && _m33 == m._m33 && _m34 == m._m34 &&
      _m41 == m._m41 && _m42 == m._m42 && _m43 == m._m43 && _m44 == m._m44
  }

  func matrix4IsApproxEqual(m: Matrix4Type) -> Bool {
    return
      _m11 ~= m._m11 && _m12 ~= m._m12 && _m13 ~= m._m13 && _m14 ~= m._m14 &&
      _m21 ~= m._m21 && _m22 ~= m._m22 && _m23 ~= m._m23 && _m24 ~= m._m24 &&
      _m31 ~= m._m31 && _m32 ~= m._m32 && _m33 ~= m._m33 && _m34 ~= m._m34 &&
      _m41 ~= m._m41 && _m42 ~= m._m42 && _m43 ~= m._m43 && _m44 ~= m._m44
  }
}

extension InstantiableMatrix4Type {
  var adjugate: Self {
    return Self(
      _m11: (_m22 * _m33 * _m44 - _m22 * _m34 * _m43) +
      (-_m32 * _m23 * _m44 + _m32 * _m24 * _m43) +
      (_m42 * _m23 * _m34 - _m42 * _m24 * _m33),

      _m12: (-_m12 * _m33 * _m44 + _m12 * _m34 * _m43) +
      (_m32 * _m13 * _m44 - _m32 * _m14 * _m43) +
      (-_m42 * _m13 * _m34 + _m42 * _m14 * _m33),

      _m13: (_m12 * _m23 * _m44 - _m12 * _m24 * _m43) +
      (-_m22 * _m13 * _m44 + _m22 * _m14 * _m43) +
      (_m42 * _m13 * _m24 - _m42 * _m14 * _m23),

      _m14: (-_m12 * _m23 * _m34 + _m12 * _m24 * _m33) +
      (_m22 * _m13 * _m34 - _m22 * _m14 * _m33) +
      (-_m32 * _m13 * _m24 + _m32 * _m14 * _m23),

      _m21: (-_m21 * _m33 * _m44 + _m21 * _m34 * _m43) +
      (_m31 * _m23 * _m44 - _m31 * _m24 * _m43) +
      (-_m41 * _m23 * _m34 + _m41 * _m24 * _m33),

      _m22: (_m11 * _m33 * _m44 - _m11 * _m34 * _m43) +
      (-_m31 * _m13 * _m44 + _m31 * _m14 * _m43) +
      (_m41 * _m13 * _m34 - _m41 * _m14 * _m33),

      _m23: (-_m11 * _m23 * _m44 + _m11 * _m24 * _m43) +
      (_m21 * _m13 * _m44 - _m21 * _m14 * _m43) +
      (-_m41 * _m13 * _m24 + _m41 * _m14 * _m23),

      _m24: (_m11 * _m23 * _m34 - _m11 * _m24 * _m33) +
      (-_m21 * _m13 * _m34 + _m21 * _m14 * _m33) +
      (_m31 * _m13 * _m24 - _m31 * _m14 * _m23),

      _m31: (_m21 * _m32 * _m44 - _m21 * _m34 * _m42) +
      (-_m31 * _m22 * _m44 + _m31 * _m24 * _m42) +
      (_m41 * _m22 * _m34 - _m41 * _m24 * _m32),

      _m32: (-_m11 * _m32 * _m44 + _m11 * _m34 * _m42) +
      (_m31 * _m12 * _m44 - _m31 * _m14 * _m42) +
      (-_m41 * _m12 * _m34 + _m41 * _m14 * _m32),

      _m33: (_m11 * _m22 * _m44 - _m11 * _m24 * _m42) +
      (-_m21 * _m12 * _m44 + _m21 * _m14 * _m42) +
      (_m41 * _m12 * _m24 - _m41 * _m14 * _m22),

      _m34: (-_m11 * _m22 * _m34 + _m11 * _m24 * _m32) +
      (_m21 * _m12 * _m34 - _m21 * _m14 * _m32) +
      (-_m31 * _m12 * _m24 + _m31 * _m14 * _m22),

      _m41: (-_m21 * _m32 * _m43 + _m21 * _m33 * _m42) +
      (_m31 * _m22 * _m43 - _m31 * _m23 * _m42) +
      (-_m41 * _m22 * _m33 + _m41 * _m23 * _m32),

      _m42: (_m11 * _m32 * _m43 - _m11 * _m33 * _m42) +
      (-_m31 * _m12 * _m43 + _m31 * _m13 * _m42) +
      (_m41 * _m12 * _m33 - _m41 * _m13 * _m32),

      _m43: (-_m11 * _m22 * _m43 + _m11 * _m23 * _m42) +
      (_m21 * _m12 * _m43 - _m21 * _m13 * _m42) +
      (-_m41 * _m12 * _m23 + _m41 * _m13 * _m22),

      _m44: (_m11 * _m22 * _m33 - _m11 * _m23 * _m32) +
      (-_m21 * _m12 * _m33 + _m21 * _m13 * _m32) +
      (_m31 * _m12 * _m23 - _m31 * _m13 * _m22)
    )
  }

  var transpose: Self {
    return Self(
      _m11: _m11, _m12: _m21, _m13: _m31, _m14: _m41,
      _m21: _m12, _m22: _m22, _m23: _m32, _m24: _m42,
      _m31: _m13, _m32: _m23, _m33: _m33, _m34: _m43,
      _m41: _m14, _m42: _m24, _m43: _m34, _m44: _m44
    )
  }

  var inverse: Self {
    let adjugate = self.adjugate
    let determinant = determinantForAdjugate(adjugate)
    return adjugate * (1 / determinant)
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
    _m11: (lhs._m11 * rhs._m11 + lhs._m21 * rhs._m12) +
    (lhs._m31 * rhs._m13 + lhs._m41 * rhs._m14),

    _m12: (lhs._m12 * rhs._m11 + lhs._m22 * rhs._m12) +
    (lhs._m32 * rhs._m13 + lhs._m42 * rhs._m14),

    _m13: (lhs._m13 * rhs._m11 + lhs._m23 * rhs._m12) +
    (lhs._m33 * rhs._m13 + lhs._m43 * rhs._m14),

    _m14: (lhs._m14 * rhs._m11 + lhs._m24 * rhs._m12) +
    (lhs._m34 * rhs._m13 + lhs._m44 * rhs._m14),

    _m21: (lhs._m11 * rhs._m21 + lhs._m21 * rhs._m22) +
    (lhs._m31 * rhs._m23 + lhs._m41 * rhs._m24),

    _m22: (lhs._m12 * rhs._m21 + lhs._m22 * rhs._m22) +
    (lhs._m32 * rhs._m23 + lhs._m42 * rhs._m24),

    _m23: (lhs._m13 * rhs._m21 + lhs._m23 * rhs._m22) +
    (lhs._m33 * rhs._m23 + lhs._m43 * rhs._m24),

    _m24: (lhs._m14 * rhs._m21 + lhs._m24 * rhs._m22) +
    (lhs._m34 * rhs._m23 + lhs._m44 * rhs._m24),

    _m31: (lhs._m11 * rhs._m31 + lhs._m21 * rhs._m32) +
    (lhs._m31 * rhs._m33 + lhs._m41 * rhs._m34),

    _m32: (lhs._m12 * rhs._m31 + lhs._m22 * rhs._m32) +
    (lhs._m32 * rhs._m33 + lhs._m42 * rhs._m34),

    _m33: (lhs._m13 * rhs._m31 + lhs._m23 * rhs._m32) +
    (lhs._m33 * rhs._m33 + lhs._m43 * rhs._m34),

    _m34: (lhs._m14 * rhs._m31 + lhs._m24 * rhs._m32) +
    (lhs._m34 * rhs._m33 + lhs._m44 * rhs._m34),

    _m41: (lhs._m11 * rhs._m41 + lhs._m21 * rhs._m42) +
    (lhs._m31 * rhs._m43 + lhs._m41 * rhs._m44),

    _m42: (lhs._m12 * rhs._m41 + lhs._m22 * rhs._m42) +
    (lhs._m32 * rhs._m43 + lhs._m42 * rhs._m44),

    _m43: (lhs._m13 * rhs._m41 + lhs._m23 * rhs._m42) +
    (lhs._m33 * rhs._m43 + lhs._m43 * rhs._m44),

    _m44: (lhs._m14 * rhs._m41 + lhs._m24 * rhs._m42) +
    (lhs._m34 * rhs._m43 + lhs._m44 * rhs._m44)
  )
}

func *<T: InstantiableMatrix4Type>(lhs: T, rhs: Matrix4Type) -> T {
  return T(
    _m11: (lhs._m11 * rhs._m11 + lhs._m21 * rhs._m12) +
    (lhs._m31 * rhs._m13 + lhs._m41 * rhs._m14),

    _m12: (lhs._m12 * rhs._m11 + lhs._m22 * rhs._m12) +
    (lhs._m32 * rhs._m13 + lhs._m42 * rhs._m14),

    _m13: (lhs._m13 * rhs._m11 + lhs._m23 * rhs._m12) +
    (lhs._m33 * rhs._m13 + lhs._m43 * rhs._m14),

    _m14: (lhs._m14 * rhs._m11 + lhs._m24 * rhs._m12) +
    (lhs._m34 * rhs._m13 + lhs._m44 * rhs._m14),

    _m21: (lhs._m11 * rhs._m21 + lhs._m21 * rhs._m22) +
    (lhs._m31 * rhs._m23 + lhs._m41 * rhs._m24),

    _m22: (lhs._m12 * rhs._m21 + lhs._m22 * rhs._m22) +
    (lhs._m32 * rhs._m23 + lhs._m42 * rhs._m24),

    _m23: (lhs._m13 * rhs._m21 + lhs._m23 * rhs._m22) +
    (lhs._m33 * rhs._m23 + lhs._m43 * rhs._m24),

    _m24: (lhs._m14 * rhs._m21 + lhs._m24 * rhs._m22) +
    (lhs._m34 * rhs._m23 + lhs._m44 * rhs._m24),

    _m31: (lhs._m11 * rhs._m31 + lhs._m21 * rhs._m32) +
    (lhs._m31 * rhs._m33 + lhs._m41 * rhs._m34),

    _m32: (lhs._m12 * rhs._m31 + lhs._m22 * rhs._m32) +
    (lhs._m32 * rhs._m33 + lhs._m42 * rhs._m34),

    _m33: (lhs._m13 * rhs._m31 + lhs._m23 * rhs._m32) +
    (lhs._m33 * rhs._m33 + lhs._m43 * rhs._m34),

    _m34: (lhs._m14 * rhs._m31 + lhs._m24 * rhs._m32) +
    (lhs._m34 * rhs._m33 + lhs._m44 * rhs._m34),

    _m41: (lhs._m11 * rhs._m41 + lhs._m21 * rhs._m42) +
    (lhs._m31 * rhs._m43 + lhs._m41 * rhs._m44),

    _m42: (lhs._m12 * rhs._m41 + lhs._m22 * rhs._m42) +
    (lhs._m32 * rhs._m43 + lhs._m42 * rhs._m44),

    _m43: (lhs._m13 * rhs._m41 + lhs._m23 * rhs._m42) +
    (lhs._m33 * rhs._m43 + lhs._m43 * rhs._m44),

    _m44: (lhs._m14 * rhs._m41 + lhs._m24 * rhs._m42) +
    (lhs._m34 * rhs._m43 + lhs._m44 * rhs._m44)
  )
}

func *<T: InstantiableMatrix4Type>(lhs: Matrix4Type, rhs: T) -> T {
  return T(
    _m11: (lhs._m11 * rhs._m11 + lhs._m21 * rhs._m12) +
    (lhs._m31 * rhs._m13 + lhs._m41 * rhs._m14),

    _m12: (lhs._m12 * rhs._m11 + lhs._m22 * rhs._m12) +
    (lhs._m32 * rhs._m13 + lhs._m42 * rhs._m14),

    _m13: (lhs._m13 * rhs._m11 + lhs._m23 * rhs._m12) +
    (lhs._m33 * rhs._m13 + lhs._m43 * rhs._m14),

    _m14: (lhs._m14 * rhs._m11 + lhs._m24 * rhs._m12) +
    (lhs._m34 * rhs._m13 + lhs._m44 * rhs._m14),

    _m21: (lhs._m11 * rhs._m21 + lhs._m21 * rhs._m22) +
    (lhs._m31 * rhs._m23 + lhs._m41 * rhs._m24),

    _m22: (lhs._m12 * rhs._m21 + lhs._m22 * rhs._m22) +
    (lhs._m32 * rhs._m23 + lhs._m42 * rhs._m24),

    _m23: (lhs._m13 * rhs._m21 + lhs._m23 * rhs._m22) +
    (lhs._m33 * rhs._m23 + lhs._m43 * rhs._m24),

    _m24: (lhs._m14 * rhs._m21 + lhs._m24 * rhs._m22) +
    (lhs._m34 * rhs._m23 + lhs._m44 * rhs._m24),

    _m31: (lhs._m11 * rhs._m31 + lhs._m21 * rhs._m32) +
    (lhs._m31 * rhs._m33 + lhs._m41 * rhs._m34),

    _m32: (lhs._m12 * rhs._m31 + lhs._m22 * rhs._m32) +
    (lhs._m32 * rhs._m33 + lhs._m42 * rhs._m34),

    _m33: (lhs._m13 * rhs._m31 + lhs._m23 * rhs._m32) +
    (lhs._m33 * rhs._m33 + lhs._m43 * rhs._m34),

    _m34: (lhs._m14 * rhs._m31 + lhs._m24 * rhs._m32) +
    (lhs._m34 * rhs._m33 + lhs._m44 * rhs._m34),

    _m41: (lhs._m11 * rhs._m41 + lhs._m21 * rhs._m42) +
    (lhs._m31 * rhs._m43 + lhs._m41 * rhs._m44),

    _m42: (lhs._m12 * rhs._m41 + lhs._m22 * rhs._m42) +
    (lhs._m32 * rhs._m43 + lhs._m42 * rhs._m44),

    _m43: (lhs._m13 * rhs._m41 + lhs._m23 * rhs._m42) +
    (lhs._m33 * rhs._m43 + lhs._m43 * rhs._m44),

    _m44: (lhs._m14 * rhs._m41 + lhs._m24 * rhs._m42) +
    (lhs._m34 * rhs._m43 + lhs._m44 * rhs._m44)
  )
}

func *<T: InstantiableMatrix4Type>(lhs: Scalar, rhs: T) -> T {
  return T(
    _m11: lhs * rhs._m11, _m12: lhs * rhs._m12, _m13: lhs * rhs._m13, _m14: lhs * rhs._m14,
    _m21: lhs * rhs._m21, _m22: lhs * rhs._m22, _m23: lhs * rhs._m23, _m24: lhs * rhs._m24,
    _m31: lhs * rhs._m31, _m32: lhs * rhs._m32, _m33: lhs * rhs._m33, _m34: lhs * rhs._m34,
    _m41: lhs * rhs._m41, _m42: lhs * rhs._m42, _m43: lhs * rhs._m43, _m44: lhs * rhs._m44
  )
}

func *<T: InstantiableMatrix4Type>(lhs: T, rhs: Scalar) -> T {
  return T(
    _m11: lhs._m11 * rhs, _m12: lhs._m12 * rhs, _m13: lhs._m13 * rhs, _m14: lhs._m14 * rhs,
    _m21: lhs._m21 * rhs, _m22: lhs._m22 * rhs, _m23: lhs._m23 * rhs, _m24: lhs._m24 * rhs,
    _m31: lhs._m31 * rhs, _m32: lhs._m32 * rhs, _m33: lhs._m33 * rhs, _m34: lhs._m34 * rhs,
    _m41: lhs._m41 * rhs, _m42: lhs._m42 * rhs, _m43: lhs._m43 * rhs, _m44: lhs._m44 * rhs
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
  var _x: Scalar { return x }
  var _y: Scalar { return y }
}

extension Vector3: Vector3Type {
  var _x: Scalar { return x }
  var _y: Scalar { return y }
  var _z: Scalar { return z }
}

extension Vector4: Vector4Type {
  var _x: Scalar { return x }
  var _y: Scalar { return y }
  var _z: Scalar { return z }
  var _w: Scalar { return w }
}

extension Quaternion: QuaternionType {
  var _x: Scalar { return x }
  var _y: Scalar { return y }
  var _z: Scalar { return z }
  var _w: Scalar { return w }
}

extension Matrix3: Matrix3Type {
  var _m11: Scalar { return m11 }
  var _m12: Scalar { return m12 }
  var _m13: Scalar { return m13 }
  var _m21: Scalar { return m21 }
  var _m22: Scalar { return m22 }
  var _m23: Scalar { return m23 }
  var _m31: Scalar { return m31 }
  var _m32: Scalar { return m32 }
  var _m33: Scalar { return m33 }
}

extension Matrix4: Matrix4Type {
  var _m11: Scalar { return m11 }
  var _m12: Scalar { return m12 }
  var _m13: Scalar { return m13 }
  var _m14: Scalar { return m14 }
  var _m21: Scalar { return m21 }
  var _m22: Scalar { return m22 }
  var _m23: Scalar { return m23 }
  var _m24: Scalar { return m24 }
  var _m31: Scalar { return m31 }
  var _m32: Scalar { return m32 }
  var _m33: Scalar { return m33 }
  var _m34: Scalar { return m34 }
  var _m41: Scalar { return m41 }
  var _m42: Scalar { return m42 }
  var _m43: Scalar { return m43 }
  var _m44: Scalar { return m44 }
}

extension Vector2: InstantiableVector2Type {
  init(_x: Scalar, _y: Scalar) {
    self.init(_x, _y)
  }
}

extension Vector3: InstantiableVector3Type {
  init(_x: Scalar, _y: Scalar, _z: Scalar) {
    self.init(_x, _y, _z)
  }
}

extension Vector4: InstantiableVector4Type {
  init(_x: Scalar, _y: Scalar, _z: Scalar, _w: Scalar) {
    self.init(_x, _y, _z, _w)
  }
}

extension Quaternion: InstantiableQuaternionType {
  init(_x: Scalar, _y: Scalar, _z: Scalar, _w: Scalar) {
    self.init(_x, _y, _z, _w)
  }
}

extension Matrix3: InstantiableMatrix3Type {
  init(
    _m11: Scalar, _m12: Scalar, _m13: Scalar,
    _m21: Scalar, _m22: Scalar, _m23: Scalar,
    _m31: Scalar, _m32: Scalar, _m33: Scalar
  ) {
    self.init(
      _m11, _m12, _m13,
      _m21, _m22, _m23,
      _m31, _m32, _m33
    )
  }
}

extension Matrix4: InstantiableMatrix4Type {
  init(
    _m11: Scalar, _m12: Scalar, _m13: Scalar, _m14: Scalar,
    _m21: Scalar, _m22: Scalar, _m23: Scalar, _m24: Scalar,
    _m31: Scalar, _m32: Scalar, _m33: Scalar, _m34: Scalar,
    _m41: Scalar, _m42: Scalar, _m43: Scalar, _m44: Scalar
  ) {
    self.init(
      _m11, _m12, _m13, _m14,
      _m21, _m22, _m23, _m24,
      _m31, _m32, _m33, _m34,
      _m41, _m42, _m43, _m44
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
    return _x.hashValue &+ _y.hashValue
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
    self.init(v._x, v._y)
  }
}

extension Vector3: Equatable, Hashable {
  static let Zero = Vector3(0, 0, 0)
  static let X = Vector3(1, 0, 0)
  static let Y = Vector3(0, 1, 0)
  static let Z = Vector3(0, 0, 1)

  var hashValue: Int {
    return _x.hashValue &+ _y.hashValue &+ _z.hashValue
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
    self.init(v._x, v._y, v._z)
  }
}

extension Vector4: Equatable, Hashable {
  static let Zero = Vector4(0, 0, 0, 0)
  static let X = Vector4(1, 0, 0, 0)
  static let Y = Vector4(0, 1, 0, 0)
  static let Z = Vector4(0, 0, 1, 0)
  static let W = Vector4(0, 0, 0, 1)

  var hashValue: Int {
    return _x.hashValue &+ _y.hashValue &+ _z.hashValue &+ _w.hashValue
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
    self.init(v._x, v._y, v._z, v._w)
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

  init(axisAngle: Vector4) {
    let r = axisAngle.w * 0.5
    let scale = sin(r)
    let xyzVector: Vector3 = axisAngle.xyz()
    let a = xyzVector * scale
    self.init(a.x, a.y, a.z, cos(r))
  }

  init(pitch: Scalar, yaw: Scalar, roll: Scalar) {
    let sy = sin(yaw * 0.5)
    let cy = cos(yaw * 0.5)
    let sz = sin(roll * 0.5)
    let cz = cos(roll * 0.5)
    let sx = sin(pitch * 0.5)
    let cx = cos(pitch * 0.5)

    self.init(
      cy * cz * cx - sy * sz * sx,
      sy * sz * cx + cy * cz * sx,
      sy * cz * cx + cy * sz * sx,
      cy * sz * cx - sy * cz * sx
    )
  }

  init(rotationMatrix m: Matrix4) {
    let diagonal = m.m11 + m.m22 + m.m33 + 1
    if diagonal ~= 0 {
      let scale = sqrt(diagonal) * 2
      self.init(
        (m.m32 - m.m23) / scale,
        (m.m13 - m.m31) / scale,
        (m.m21 - m.m12) / scale,
        0.25 * scale
      )
    } else if m.m11 > max(m.m22, m.m33) {
      let scale = sqrt(1 + m.m11 - m.m22 - m.m33) * 2
      self.init(
        0.25 * scale,
        (m.m21 + m.m12) / scale,
        (m.m13 + m.m31) / scale,
        (m.m32 - m.m23) / scale
      )
    } else if m.m22 > m.m33 {
      let scale = sqrt(1 + m.m22 - m.m11 - m.m33) * 2
      self.init(
        (m.m21 + m.m12) / scale,
        0.25 * scale,
        (m.m32 + m.m23) / scale,
        (m.m13 - m.m31) / scale
      )
    } else {
      let scale = sqrt(1 + m.m33 - m.m11 - m.m22) * 2
      self.init(
        (m.m13 + m.m31) / scale,
        (m.m32 + m.m23) / scale,
        0.25 * scale,
        (m.m21 - m.m12) / scale
      )
    }
  }

  init(_ v: [Scalar]) {
    assert(v.count == 4, "array must contain 4 elements, contained \(v.count)")

    x = v[0]
    y = v[1]
    z = v[2]
    w = v[3]
  }

  init(_ v: QuaternionType) {
    self.init(v._x, v._y, v._z, v._w)
  }
}

extension Matrix3: Equatable, Hashable {
  static let Identity = Matrix3(1, 0 ,0 ,0, 1, 0, 0, 0, 1)

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

  init(scale: Vector2) {
    self.init(
      scale.x, 0, 0,
      0, scale.y, 0,
      0, 0, 1
    )
  }

  init(translation: Vector2) {
    self.init(
      1, 0, 0,
      0, 1, 0,
      translation.x, translation.y, 1
    )
  }

  init(rotation radians: Scalar) {
    let cs = cos(radians)
    let sn = sin(radians)
    self.init(
      cs, sn, 0,
      -sn, cs, 0,
      0, 0, 1
    )
  }

  init(_ m: [Scalar]) {
    assert(m.count == 9, "array must contain 9 elements, contained \(m.count)")

    self.init(m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8])
  }

  init(_ m: Matrix3Type) {
    self.init(
      m._m11, m._m12, m._m13,
      m._m21, m._m22, m._m23,
      m._m31, m._m32, m._m33
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

  init(scale s: Vector3) {
    self.init(
      s.x, 0, 0, 0,
      0, s.y, 0, 0,
      0, 0, s.z, 0,
      0, 0, 0, 1
    )
  }

  init(translation t: Vector3) {
    self.init(
      1, 0, 0, 0,
      0, 1, 0, 0,
      0, 0, 1, 0,
      t.x, t.y, t.z, 1
    )
  }

  init(rotation axisAngle: Vector4) {
    self.init(quaternion: Quaternion(axisAngle: axisAngle))
  }

  init(quaternion q: Quaternion) {
    self.init(
      1 - 2 * (q.y * q.y + q.z * q.z), 2 * (q.x * q.y + q.z * q.w), 2 * (q.x * q.z - q.y * q.w), 0,
      2 * (q.x * q.y - q.z * q.w), 1 - 2 * (q.x * q.x + q.z * q.z), 2 * (q.y * q.z + q.x * q.w), 0,
      2 * (q.x * q.z + q.y * q.w), 2 * (q.y * q.z - q.x * q.w), 1 - 2 * (q.x * q.x + q.y * q.y), 0,
      0, 0, 0, 1
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
      cotangent / aspect, 0, 0, 0,
      0, cotangent, 0, 0,
      0, 0, -(far + near) / dz, -1,
      0, 0, -2 * near * far / dz, 0
    )
  }

  init(top: Scalar, right: Scalar, bottom: Scalar, left: Scalar, near: Scalar, far: Scalar) {
    let dx = right - left
    let dy = top - bottom
    let dz = far - near

    self.init(
      2 / dx, 0, 0, 0,
      0, 2 / dy, 0, 0,
      0, 0, -2 / dz, 0,
      -(right + left) / dx, -(top + bottom) / dy, -(far + near) / dz, 1
    )
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
      m._m11, m._m12, m._m13, m._m14,
      m._m21, m._m22, m._m23, m._m24,
      m._m31, m._m32, m._m33, m._m34,
      m._m41, m._m42, m._m43, m._m44
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

