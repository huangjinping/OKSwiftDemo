//
//  PhotoPermissionManager.swift
//  OSSwiftDemo
//
//  Created by 胡慧杰 on 2025/8/29.
//

import Foundation
import Photos
import UIKit

class PhotoPermissionManager {
    
    // 检查并请求相册权限
    func checkPhotoPermission(completion: @escaping (Bool) -> Void) {
        // 获取当前权限状态
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        switch status {
        case .authorized:
            print("--------------------authorized");

            // 已授权
            completion(true)
            
        case .denied, .restricted:
            print("--------------------.denied, .restricted");

            // 被拒绝或受限制（如家长控制）
            completion(false)
            
        case .notDetermined:
            print("--------------------notDetermined");
            // 未请求过权限，发起请求
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
                DispatchQueue.main.async {
                    completion(newStatus == .authorized)
                }
            }
        case .limited:
            print("--------------------limited");
            completion(false)
            
        @unknown default:
            print("--------------------default");
            completion(false)
        }
    }
    
    // 跳转到设置页面（当权限被拒绝时调用）
    func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        }
    }
}
