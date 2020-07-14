//
//  PLImageResizeMode.swift
//  PLImageResizeMode
//
//  Created by 彭磊 on 2020/7/13.
//

import UIKit

public enum PLImageResizeMode {
    /// 不作处理
    case none
    /// 图片如超出按长边缩略
    case fit(CGSize)
    /// 图片如超出按居中裁剪
    case center(CGSize)
    /// 强制指定大小，可能会变形
    case fixed(CGSize)
    
    public var heightOfInt: Int {
        let scale: CGFloat = UIScreen.main.scale
        switch self {
        case .none:
            return 0
        case .fit(let size), .center(let size), .fixed(let size):
            let tmp: CGFloat = size.height * scale
            return Int(tmp)
        }
    }
    
    public var widthOfInt: Int {
        let scale: CGFloat = UIScreen.main.scale
        switch self {
        case .none:
            return 0
        case .fit(let size), .center(let size), .fixed(let size):
            let tmp: CGFloat = size.width * scale
            return Int(tmp)
        }
    }
}
