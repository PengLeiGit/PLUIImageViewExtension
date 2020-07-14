//
//  PLUIImageView+Extension.swift
//  Kingfisher
//
//  Created by 彭磊 on 2020/7/13.
//

import UIKit
import PLImageResizeMode
import Kingfisher

//public extension UIImageView {
//    typealias LoadImageCompletion = () -> Void
//
//    /// 加载图片(新)
//    ///
//    /// - Parameters:
//    ///   - url: url地址
//    ///   - resizeMode: 缩放模式 动态图不支持缩放、切割
//    ///   - placeholder: 占位图
//    ///   - watermark: 水印图片地址
//    ///   - transition: 动画效果
//    ///   - cornerRadius: 圆角
//    @discardableResult
////    func loadImageURL(_ url: String, resizeMode: PLImageResizeMode = .none, placeholder: UIImage? = UIImage(color: UIColor.gray), cornerRadius: CGFloat? = nil, watermark: String? = nil, transition: ImageTransition = .fade(0.5), progress: DownloadProgressBlock? = nil, completion: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask? {
//////        let completedUrl = url.resizeURL(mode: resizeMode, watermark: watermark) // 可以处理一些水印之类的
////        if let imageURL = URL(string: url) {
////            var opitons: KingfisherOptionsInfo? = [.transition(transition)]
////            if let cornerRadius = cornerRadius {
////                opitons?.append(.processor(RoundCornerImageProcessor(cornerRadius: cornerRadius)))
////            }
////            return self.kf.setImage(with: imageURL, placeholder: placeholder, options: opitons, progressBlock: progress, completionHandler: completion)
////        } else {
////            let url: URL? = nil
////            return self.kf.setImage(with: url, placeholder: placeholder, progressBlock: progress, completionHandler: completion)
////        }
////    }
//}
