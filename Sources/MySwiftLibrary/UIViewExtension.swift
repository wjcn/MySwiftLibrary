//
//  UIViewExtension.swift
//
//  Created by William J. C. Nesbitt.
//

#if os(iOS)
import UIKit.UIView

@available(iOS 11, *)
public extension UIView {
    var safeAreaBounds: CGRect { bounds.inset(by: safeAreaInsets) }
    var safeAreaFrame:  CGRect {  frame.inset(by: safeAreaInsets) }
}
#endif
