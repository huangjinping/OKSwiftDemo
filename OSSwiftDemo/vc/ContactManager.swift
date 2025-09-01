//
//  ContactManager.swift
//  OSSwiftDemo
//
//  Created by 胡慧杰 on 2025/8/29.
//

import Foundation
import Contacts

class ContactManager {
    private let contactStore = CNContactStore()
    
    // 请求通讯录权限并获取联系人
    func fetchContacts(completion: @escaping ([CNContact]?, Error?) -> Void) {
        // 检查当前权限状态
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
        case .authorized:
            // 已授权，直接获取
            fetchContactsFromStore(completion: completion)
            
        case .notDetermined:
            // 未决定，请求权限
            contactStore.requestAccess(for: .contacts) { [weak self] granted, error in
                guard let self = self else { return }
                if granted {
                    self.fetchContactsFromStore(completion: completion)
                } else {
                    completion(nil, error ?? NSError(domain: "ContactAccess", code: -1, userInfo: [NSLocalizedDescriptionKey: "用户拒绝访问通讯录"]))
                }
            }
            
        case .denied, .restricted:
            // 已拒绝或受限制
            completion(nil, NSError(domain: "ContactAccess", code: -2, userInfo: [NSLocalizedDescriptionKey: "无权限访问通讯录，请在设置中开启"]))
            
        case .limited:
            completion(nil, NSError(domain: "ContactAccess", code: -3, userInfo: [NSLocalizedDescriptionKey: "limited"]))

        @unknown default:
            completion(nil, NSError(domain: "ContactAccess", code: -3, userInfo: [NSLocalizedDescriptionKey: "未知错误"]))
        }
    }
    
    // 从通讯录获取联系人数据
    private func fetchContactsFromStore(completion: @escaping ([CNContact]?, Error?) -> Void) {
        // 指定需要获取的字段（iOS 18 要求明确声明所需字段，避免过度获取）
        let keysToFetch: [CNKeyDescriptor] = [
            CNContactGivenNameKey as CNKeyDescriptor,
            CNContactFamilyNameKey as CNKeyDescriptor,
            CNContactPhoneNumbersKey as CNKeyDescriptor,
            CNContactEmailAddressesKey as CNKeyDescriptor,
            CNContactPostalAddressesKey as CNKeyDescriptor
        ]
        
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        var contacts: [CNContact] = []
        
        do {
            try contactStore.enumerateContacts(with: request) { contact, stop in
                contacts.append(contact)
            }
            completion(contacts, nil)
        } catch {
            completion(nil, error)
        }
    }
}
