//
//  ViewController.swift
//  OSSwiftDemo
//
//  Created by 胡慧杰 on 2024/12/31.
//

import UIKit
import WebKit
import AppTrackingTransparency
import AdSupport

import Contacts
import Toaster


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{    
    let dataList=NSMutableArray();

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let item:NSDictionary = dataList[section] as! NSDictionary
        let count=(item["data"] as! NSMutableArray).count;
        
        return count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataList.count;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        let sdkList=NSMutableArray();
        sdkList.add("ReactiveCocoa");
        sdkList.add("SDWebImage");
        sdkList.add("SnapKit");
        sdkList.add("RxSwift");
        sdkList.add("Alamofire");
        sdkList.add("AVFoundation");
        sdkList.add("Permission");
        dataList.add(["title": "SDK", "data": sdkList])
        
        
        createTableView();
        getUserAgent();
        let userAgent = getUserAgentNew();
        print("当前 iOS User-Agent: \(userAgent)");
        
        
//        requestIDFA();
    }
    
    
    
    
    
     func createTableView(){
         let tableview=UITableView(frame:self.view.bounds, style: UITableView.Style.plain);
         tableview.delegate=self;
         tableview.dataSource=self;
         self.view.addSubview(tableview)
    }
    
        
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ceel");
         let item:NSDictionary = dataList[indexPath.section] as! NSDictionary
         let data:NSMutableArray = (item["data"] as! NSMutableArray)
         
         let text=data[indexPath.row]
         
//         let text=rowDic["title"];
         cell.textLabel?.text="\(String(describing: text))";
        return cell;
    }
    
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let item:NSDictionary = dataList[section] as! NSDictionary
        let title=item["title"] as! String;
        return title;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item:NSDictionary = dataList[indexPath.section] as! NSDictionary
        let data:NSMutableArray = (item["data"] as! NSMutableArray)
        
        let _result:String=data[indexPath.row] as! String
        
        print("=======didSelectRowAt===11======\(_result)======");
        switch _result{
            case "Permission":
                onPermission();
                break
        default:
            break
        }
        
//        let text=dataList[indexPath.row];
//        let  add="\(text)";
//        NSLog(add);
//        var vc=UIViewController()
//        if("AVFoundation" == add){
//            vc=AVFoundController();
//        }
//        self.navigationController?.pushViewController(vc, animated: true);
//        let  sectionList:NSMutableArray=dataList[indexPath.section] as! NSMutableArray;
//        let _result = sectionList[indexPath.row] as! ;
        
////
//        switch _result{
//            case "ReactiveCocoa":
//                    print("============1======== \(_result)==");
//                break
//        default:
//            break
//            
//        }
//        
//        switch dataList[indexPath.section]{
//            case "ReactiveCocoa":
//                break
//            default:
//                print("=======default====001===========");
//                break
//        }
//            case "ReactiveCocoa":
//        requestIDFA()
//        onReqestContract()
//        onRequestPhoto()
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)  {
//        String reuseIdentifier="cell"
//        
//        var cell =UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
//        return cell;
//    }
    
    
    
    func  getUserAgent(){
        print("=======getUserAgent===============");
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        self.view .addSubview(webView);
        webView.evaluateJavaScript("navigator.userAgent") { result, error in
            if let agent = result as? String {
                print("User Agent:WKWebView--- \(agent)")
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    func onPermission(){
        print("------onPermission---------")
        let vc=PermissionController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
     func requestIDFA() {
          if #available(iOS 14, *) {
              ATTrackingManager.requestTrackingAuthorization { status in
                  switch status {
                  case .authorized:
                      // 用户已授权访问 IDFA，可以在此处获取 IDFA
                      let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                      print("IDFA: \(idfa)")
                  case .denied, .restricted, .notDetermined:
                      // 用户拒绝或限制了访问 IDFA，或者授权状态尚未确定
                      print("用户未授权访问 IDFA")
                  @unknown default:
                      break
                  }
              }
          } else {
              // 处理 iOS 14 以下的版本
              let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
              print("IDFA: \(idfa)")
          }
      }
    
    
    func onRequestPhoto(){
        let manager = PhotoPermissionManager()
        manager.checkPhotoPermission { granted in
            if granted {
                // 有权限，执行相册操作
                print("已获得相册权限")
            } else {
                // 无权限，提示用户去设置开启
                print("未获得相册权限，请在设置中开启")
                // 可以调用 openSettings() 跳转到设置页面
            }
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
    
    func onReqestContract() {
        
//        let store = CNContactStore()
//        store.requestAccess(for:.contacts) { (granted, error) in
//            if granted {
//                // 在这里读取通讯录数据
//                print("在这里读取通讯录数据");
//            } else {
//                print("用户未授权访问通讯录，错误：\(error?.localizedDescription ?? "无错误描述")")
//            }
//        }
        
        
        let manager = ContactManager()
        manager.fetchContacts { contacts, error in
            if let error = error {
                print("获取失败：\(error.localizedDescription)")
                Toast(text: "获取失败：\(error.localizedDescription)").show()

                self.openSettings();
                return
            }
            

            
            print("-----已经有了Contact权限-----")
            guard let contacts = contacts else { return }
            print("有联系人数据 \(contacts.count)")
            
            Toast(text: "有联系人数据 \(contacts.count)").show()

            // 遍历联系人信息
            for contact in contacts {
                let fullName = "\(contact.familyName)\(contact.givenName)"
                print("姓名：\(fullName)")
                
                // 电话号码
                for phone in contact.phoneNumbers {
                    let number = phone.value.stringValue
//                    let label = CNLabeledValue.localizedString(forLabel: phone.label)
                    print("  \(number)")
                }
                
                // 邮箱
                for email in contact.emailAddresses {
                    let address = email.value as String
//                    let label = CNLabeledValue.localizedString(forLabel: email.label)
//                    print("  \(label)：\(address)")
                }
            }
        }
    }
    
    
    
    
    
//    import UIKit
//    class ViewController: UIViewController {
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            
//            // 调用获取 User-Agent 的方法
//            let userAgent = getUserAgent()
//            
//            // 打印 User-Agent 到控制台
//            print("当前 iOS User-Agent: \(userAgent)")
//        }
//    }
    
    func getUserAgentNew() -> String {
        // 获取 iOS 系统的 User-Agent 字符串
        // 这是一个内置方法，用于获取默认的 User-Agent
        let userAgent = UIWebView().stringByEvaluatingJavaScript(from: "navigator.userAgent") ?? ""
        return userAgent
    }
    
}

