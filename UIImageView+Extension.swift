//
//  UIImageView+Extension.swift
//  PLUIImageViewExtension
//
//  Created by 彭磊 on 2020/7/13.
//

import UIKit

public extension UIImageView {
    typealias LoadImageCompletion = () -> Void
    
    /// 加载图片(新)
    ///
    /// - Parameters:
    ///   - url: url地址
    ///   - resizeMode: 缩放模式 动态图不支持缩放、切割
    ///   - placeholder: 占位图
    ///   - watermark: 水印图片地址
    ///   - transition: 动画效果
    ///   - cornerRadius: 圆角
    @discardableResult
    func loadImageURL(_ url: String, resizeMode: DUImageResizeMode = .none, placeholder: UIImage? = UIImage(color: UIColor(hexString: "#EBEBF0")), cornerRadius: CGFloat? = nil, watermark: String? = nil, transition: ImageTransition = .fade(0.5), progress: DownloadProgressBlock? = nil, completion: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask? {
        let completedUrl = url.resizeURL(mode: resizeMode, watermark: watermark)
        if let imageURL = URL(string: completedUrl) {
            var opitons: KingfisherOptionsInfo? = [.transition(transition)]
            if let cornerRadius = cornerRadius {
                opitons?.append(.processor(RoundCornerImageProcessor(cornerRadius: cornerRadius)))
            }
            return self.kf.setImage(with: imageURL, placeholder: placeholder, options: opitons, progressBlock: progress, completionHandler: completion)
        } else {
            let url: URL? = nil
            return self.kf.setImage(with: url, placeholder: placeholder, progressBlock: progress, completionHandler: completion)
        }
    }
}
