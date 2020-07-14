//
//  UIImageView+CornerRadius.swift
//  Kingfisher
//
//  Created by 彭磊 on 2020/7/14.
//

import UIKit

private struct AssociatedKeys {
    static var duFinishedCorner = "DUFinishedCornerKey"
    static var duImageObserver = "DUImageObserverKey"
    static var duCornerRadius = "DUCornerRadiusKey"
}

class DUImageObserver: NSObject {
    
    @objc dynamic private var originImageView: UIImageView!
    private var originImage: UIImage!
    var cornerRadius: CGFloat = 0 {
        didSet {
            guard cornerRadius != oldValue,
                cornerRadius > 0
                else { return }
            updateImageView()
        }
    }
    
    convenience init(imageView: UIImageView) {
        self.init()
        self.originImageView = imageView
        originImageView.addObserver(self,
                                    forKeyPath: "image",
                                    options: .new,
                                    context: nil)
        originImageView.addObserver(self,
                                    forKeyPath: "contentMode",
                                    options: .new,
                                    context: nil)
    }
    
    deinit {
        originImageView.removeObserver(self, forKeyPath: "image")
        originImageView.removeObserver(self, forKeyPath: "contentMode")
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        guard let change = change else { return }
        switch keyPath {
        case "image" :
            if let newImage = change[.newKey] as? UIImage,
                !newImage.duFinishedCorner {
                updateImageView()
            }
            
        case "contentMode" :
            originImageView.image = originImage
            
        default: break
        }
        
    }
    
    private func updateImageView() {
        guard originImageView != nil,
            let image = originImageView.image
            else { return }
        originImage = image
        var finalImage: UIImage?
        autoreleasepool {
            UIGraphicsBeginImageContextWithOptions(originImageView.bounds.size,
                                                   false,
                                                   UIScreen.main.scale)
            if let currnetContext = UIGraphicsGetCurrentContext() {
                currnetContext.addPath(UIBezierPath(roundedRect: originImageView.bounds,
                                                    cornerRadius: cornerRadius).cgPath)
                currnetContext.clip()
                originImageView.layer.render(in: currnetContext)
                finalImage = UIGraphicsGetImageFromCurrentImageContext()
                originImageView.layer.contents = nil
                UIGraphicsEndImageContext()
            }
        }
        
        
        if finalImage != nil {
            finalImage?.duFinishedCorner = true
            originImageView.image = finalImage
        } else {
            DispatchQueue.main.async {
                self.updateImageView()
            }
        }
    }
}

extension UIImage {
    @objc dynamic var duFinishedCorner: Bool {
        get {
            if let value = objc_getAssociatedObject(self, &AssociatedKeys.duFinishedCorner) as? Bool {
                return value
            }
            return false
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.duFinishedCorner,
                                     newValue,
                                     .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

public extension UIImageView {
    var du_cornerRadius: CGFloat {
        get {
            return imageObserver.cornerRadius
        }
        set {
            imageObserver.cornerRadius = newValue
        }
    }
    
    @objc dynamic private var imageObserver: DUImageObserver {
        get {
            if let observer = objc_getAssociatedObject(self, &AssociatedKeys.duImageObserver) as? DUImageObserver {
                return observer
            }
            let observer = DUImageObserver(imageView: self)
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.duImageObserver,
                                     observer,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return observer
        }
    }
}
