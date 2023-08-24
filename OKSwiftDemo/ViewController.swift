//
//  ViewController.swift
//  OKSwiftDemo
//
//  Created by 胡慧杰 on 2023/8/24.
//

import UIKit
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let teachename="添加详情"
        NSLog("okhttp %@",teachename)
        let  button:UIButton=UIButton(frame: CGRectMake(100, 100, 100, 100))
        button.backgroundColor=UIColor.gray
        button.setTitle("催收", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(self.onOpen), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
    }

    @objc  func onOpen(){
        NSLog("onOpen")
        let loginController:LoginController=LoginController()
        self.navigationController?.pushViewController(loginController, animated: true)
        
    }

}

