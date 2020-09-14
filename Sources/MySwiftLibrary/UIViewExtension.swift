//
//  UIViewExtension.swift
//
//  Created by William J. C. Nesbitt.
//  Copyright © 2020 William J. C. Nesbitt. All rights reserved.
//

#if os(iOS)
import UIKit.UIView

@available(iOS 11, *)
extension UIView {
    @inlinable public var safeAreaBounds: CGRect { bounds.inset(by: safeAreaInsets) }
    @inlinable public var safeAreaFrame:  CGRect {  frame.inset(by: safeAreaInsets) }
}
#endif
