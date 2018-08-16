//
//  CGExtension.swift
//
//  This file is part of LyricsX
//  Copyright (C) 2017 Xander Deng - https://github.com/ddddxxx/LyricsX
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import CoreGraphics
import QuartzCore

// swiftlint:disable shorthand_operator identifier_name operator_whitespace

// MARK: - CGFloat

extension CGFloat {
    
    /// degrees to radians
    func toRadians() -> CGFloat {
        return self * .pi / 180
    }
    
    /// radians to degrees
    func toDegrees() -> CGFloat {
        return self * 180 / .pi
    }
}

// MARK: - CGPoint

extension CGPoint {
    
    init(_ vector: CGVector) {
        self.init(x: vector.dx, y: vector.dy)
    }
    
    func distance(to point: CGPoint) -> CGFloat {
        return CGVector(from: self, to: point).length
    }
    
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func +=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs + rhs
    }
    
    static func +(lhs: CGPoint, rhs: CGVector) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
    }
    
    static func +=(lhs: inout CGPoint, rhs: CGVector) {
        lhs = lhs + rhs
    }
    
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func -=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs - rhs
    }
    
    static func -(lhs: CGPoint, rhs: CGVector) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.dx, y: lhs.y - rhs.dy)
    }
    
    static func -=(lhs: inout CGPoint, rhs: CGVector) {
        lhs = lhs - rhs
    }
    
    static func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    
    static func *=(point: inout CGPoint, scalar: CGFloat) {
        point = point * scalar
    }
    
    static func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x / scalar, y: point.y / scalar)
    }
    
    static func /=(point: inout CGPoint, scalar: CGFloat) {
        point = point / scalar
    }
    
    mutating func apply(t: CGAffineTransform) {
        self = applying(t)
    }
}

// MARK: - CGVector

extension CGVector {
    
    init(_ point: CGPoint) {
        self.init(dx: point.x, dy: point.y)
    }
    
    init(from: CGPoint, to: CGPoint) {
        self.init(dx: to.x - from.x, dy: to.y - from.y)
    }
    
    init(angle: CGFloat, length: CGFloat = 1) {
        self.init(dx: cos(angle) * length, dy: sin(angle) * length)
    }
    
    var length: CGFloat {
        get {
            return hypot(dx, dy)
        }
        set {
            guard self != .zero else { return }
            let scale = newValue / length
            dx *= scale
            dy *= scale
        }
    }
    
    /// in radians
    var angle: CGFloat {
        return atan2(dy, dx)
    }
    
    static func +(lhs: CGVector, rhs: CGVector) -> CGVector {
        return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
    }
    
    static func +=(lhs: inout CGVector, rhs: CGVector) {
        lhs = lhs + rhs
    }
    
    static func -(lhs: CGVector, rhs: CGVector) -> CGVector {
        return CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
    }
    
    static func -=(lhs: inout CGVector, rhs: CGVector) {
        lhs = lhs - rhs
    }
    
    static func *(vector: CGVector, scalar: CGFloat) -> CGVector {
        return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
    }
    
    static func *=(vector: inout CGVector, scalar: CGFloat) {
        vector = vector * scalar
    }
    
    static func /(vector: CGVector, scalar: CGFloat) -> CGVector {
        return CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
    }
    
    static func /=(vector: inout CGVector, scalar: CGFloat) {
        vector = vector / scalar
    }
}

// MARK: - CGSize

extension CGSize {
    
    var area: CGFloat {
        return width * height
    }
    
    func aspectFit(to size: CGSize) -> CGSize {
        let xScale = size.width / width
        let yScale = size.height / height
        return self * min(xScale, yScale)
    }
    
    var aspectFitSquare: CGSize {
        let minSide = min(width, height)
        return CGSize(width: minSide, height: minSide)
    }
    
    func aspectFill(to size: CGSize) -> CGSize {
        let xScale = size.width / width
        let yScale = size.height / height
        return self * max(xScale, yScale)
    }
    
    var aspectFillSquare: CGSize {
        let maxSide = max(width, height)
        return CGSize(width: maxSide, height: maxSide)
    }
    
    static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    static func +=(lhs: inout CGSize, rhs: CGSize) {
        lhs = lhs + rhs
    }
    
    static func -(lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
    
    static func -=(lhs: inout CGSize, rhs: CGSize) {
        lhs = lhs - rhs
    }
    
    static func *(size: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: size.width * scalar, height: size.height * scalar)
    }
    
    static func *=(size: inout CGSize, scalar: CGFloat) {
        size = size * scalar
    }
    
    static func /(size: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: size.width / scalar, height: size.height / scalar)
    }
    
    static func /=(size: inout CGSize, scalar: CGFloat) {
        size = size / scalar
    }
    
    mutating func apply(t: CGAffineTransform) {
        self = applying(t)
    }
}

// MARK: - CGRect

extension CGRect {
    
    init(minX: CGFloat, minY: CGFloat, maxX: CGFloat, maxY: CGFloat) {
        self.init(x: minX,
                  y: minY,
                  width: maxX - minX,
                  height: maxY - minY)
    }
    
    init(center: CGPoint, size: CGSize) {
        self.init(x: center.x - size.width / 2,
                  y: center.y - size.height / 2,
                  width: size.width,
                  height: size.height)
    }
    
    var area: CGFloat {
        return width * height
    }
    
    var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
        set {
            origin.x = newValue.x - size.width / 2
            origin.y = newValue.y - size.height / 2
        }
    }
    
    func center(on edge: CGRectEdge) -> CGPoint {
        switch edge {
        case .maxXEdge: return CGPoint(x: maxX, y: midY)
        case .maxYEdge: return CGPoint(x: midX, y: maxY)
        case .minXEdge: return CGPoint(x: minX, y: midY)
        case .minYEdge: return CGPoint(x: midX, y: minY)
        }
    }
    
    func offsetBy(dx: CGFloat = 0, dy: CGFloat = 0) -> CGRect {
        return CGRect(x: minX + dx, y: minY + dy, width: width, height: height)
    }
    
    mutating func formOffsetBy(dx: CGFloat = 0, dy: CGFloat = 0) {
        self = offsetBy(dx: dx, dy: dy)
    }
    
    func insetBy(x: CGFloat = 0, y: CGFloat = 0) -> CGRect {
        return insetBy(minX: x, minY: y, maxX: x, maxY: y)
    }
    
    mutating func formInsetBy(x: CGFloat = 0, y: CGFloat = 0) {
        self = insetBy(x: x, y: y)
    }
    
    func insetBy(minX: CGFloat = 0, minY: CGFloat = 0, maxX: CGFloat = 0, maxY: CGFloat = 0) -> CGRect {
        return CGRect(x: self.minX + minX,
                      y: self.minY + minY,
                      width: width - minX - maxX,
                      height: height - minY - maxY)
    }
    
    mutating func formInsetBy(minX: CGFloat = 0, minY: CGFloat = 0, maxX: CGFloat = 0, maxY: CGFloat = 0) {
        self = insetBy(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
    }
    
    func extendBy(x: CGFloat = 0, y: CGFloat = 0) -> CGRect {
        return insetBy(x: -x, y: -y)
    }
    
    mutating func formExtendBy(x: CGFloat = 0, y: CGFloat = 0) {
        self = extendBy(x: x, y: y)
    }
    
    func extendBy(minX: CGFloat = 0, minY: CGFloat = 0, maxX: CGFloat = 0, maxY: CGFloat = 0) -> CGRect {
        return insetBy(minX: -minX, minY: -minY, maxX: -maxX, maxY: -maxY)
    }
    
    mutating func formExtendBy(minX: CGFloat = 0, minY: CGFloat = 0, maxX: CGFloat = 0, maxY: CGFloat = 0) {
        self = extendBy(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
    }
    
    mutating func apply(t: CGAffineTransform) {
        self = applying(t)
    }
}

// MARK: - CGAffineTransform

extension CGAffineTransform {
    
    // MARK: creat
    
    init() {
        self = .identity
    }
    
    static func translate(x: CGFloat = 0, y: CGFloat = 0) -> CGAffineTransform {
        return CGAffineTransform(translationX: x, y: y)
    }
    
    static func scale(x: CGFloat = 1, y: CGFloat = 1) -> CGAffineTransform {
        return CGAffineTransform(scaleX: x, y: y)
    }
    
    static func rotate(_ angle: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(rotationAngle: angle)
    }
    
    static func flip(height: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: 0, y: height).scaledBy(x: 1, y: -1)
    }
    
    static func swap() -> CGAffineTransform {
        return CGAffineTransform(scaleX: -1, y: 1).rotated(by: .pi / 2)
    }
    
    // MARK: mutate
    
    func transformed(by t2: CGAffineTransform) -> CGAffineTransform {
        return t2.concatenating(self)
    }
    
    mutating func invert() {
        self = inverted()
    }
    
    mutating func transform(by t2: CGAffineTransform) {
        self = transformed(by: t2)
    }
    
    mutating func translateBy(x: CGFloat = 0, y: CGFloat = 0) {
        self = translatedBy(x: x, y: y)
    }
    
    mutating func scaleBy(x: CGFloat = 1, y: CGFloat = 1) {
        self = scaledBy(x: x, y: y)
    }
    
    mutating func rotate(by angle: CGFloat) {
        self = rotated(by: angle)
    }
    
    // MARK: operator
    
    static func *(lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform {
        return lhs.concatenating(rhs)
    }
    
    static func *=(lhs: inout CGAffineTransform, rhs: CGAffineTransform) {
        lhs = lhs * rhs
    }
    
    static func /(lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform {
        return lhs.concatenating(rhs.inverted())
    }
    
    static func /=(lhs: inout CGAffineTransform, rhs: CGAffineTransform) {
        lhs = lhs / rhs
    }
}

// MARK: - CATransform3D

extension CATransform3D {
    
    var cameraDistance: CGFloat {
        get {
            return -1 / m34
        }
        set {
            m34 = -1 / newValue
        }
    }
    
    // MAKE: creat
    
    static var identity: CATransform3D {
        return CATransform3DIdentity
    }
    
    init() {
        self = CATransform3DIdentity
    }
    
    static func translation(x tx: CGFloat = 0, y ty: CGFloat = 0, z tz: CGFloat = 0) -> CATransform3D {
        return CATransform3DMakeTranslation(tx, ty, tz)
    }
    
    static func scale(x sx: CGFloat = 1, y sy: CGFloat = 1, z sz: CGFloat = 1) -> CATransform3D {
        return CATransform3DMakeScale(sx, sy, sz)
    }
    
    static func rotation(angle: CGFloat, x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
        return CATransform3DMakeRotation(angle, x, y, z)
    }
    
    // MARK: affine
    
    init(_ affineTransform: CGAffineTransform) {
        self = CATransform3DMakeAffineTransform(affineTransform)
    }
    
    var isAffine: Bool {
        return CATransform3DIsAffine(self)
    }
    
    var affineTransform: CGAffineTransform {
        return CATransform3DGetAffineTransform(self)
    }
    
    // MARK: transform
    
    var inverse: CATransform3D {
        return CATransform3DInvert(self)
    }
    
    func translatedBy(x tx: CGFloat = 0, y ty: CGFloat = 0, z tz: CGFloat = 0) -> CATransform3D {
        return CATransform3DTranslate(self, tx, ty, tz)
    }
    
    func scaledBy(x sx: CGFloat = 1, y sy: CGFloat = 1, z sz: CGFloat = 1) -> CATransform3D {
        return CATransform3DScale(self, sx, sy, sz)
    }
    
    func rotatedBy(angle: CGFloat, x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
        return CATransform3DRotate(self, angle, x, y, z)
    }
    
    func transformed(by t2: CATransform3D) -> CATransform3D {
        return CATransform3DConcat(t2, self)
    }
    
    func concatenating(_ t2: CATransform3D) -> CATransform3D {
        return CATransform3DConcat(self, t2)
    }
    
    // MARK: mutate
    
    mutating func inverte() {
        self = inverse
    }
    
    mutating func scaleBy(x sx: CGFloat = 1, y sy: CGFloat = 1, z sz: CGFloat = 1) {
        self = scaledBy(x: sx, y: sy, z: sz)
    }
    
    mutating func rotateBy(angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) {
        self = rotatedBy(angle: angle, x: x, y: y, z: z)
    }
    
    mutating func transforme(by t2: CATransform3D) {
        self = transformed(by: t2)
    }
    
    mutating func translateBy(x tx: CGFloat = 0, y ty: CGFloat = 0, z tz: CGFloat = 0) {
        self = translatedBy(x: tx, y: ty, z: tz)
    }
    
    mutating func concat(_ t2: CATransform3D) {
        self = concatenating(t2)
    }
    
    // MARK: operator
    
    static func *(lhs: CATransform3D, rhs: CATransform3D) -> CATransform3D {
        return lhs.concatenating(rhs)
    }
    
    static func *=(lhs: inout CATransform3D, rhs: CATransform3D) {
        lhs = lhs * rhs
    }
    
    static func /(lhs: CATransform3D, rhs: CATransform3D) -> CATransform3D {
        return lhs.concatenating(rhs.inverse)
    }
    
    static func /=(lhs: inout CATransform3D, rhs: CATransform3D) {
        lhs = lhs / rhs
    }
}

extension CATransform3D: Equatable {
    
    public static func == (lhs: CATransform3D, rhs: CATransform3D) -> Bool {
        return CATransform3DEqualToTransform(lhs, rhs)
    }
}
