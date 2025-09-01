//
//  PermissionController.swift
//  OSSwiftDemo
//
//  Created by 胡慧杰 on 2025/9/1.
//

import UIKit

class PermissionController:UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let  button:UIButton=UIButton(type: UIButton.ButtonType.roundedRect)
//        UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.frame=CGRect(x: 100, y: 100, width: 100, height: 50)
        button.setTitle("联系人权限", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor=UIColor.blue
        button.addTarget(self, action:#selector(onContrct), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
    }
    
    
    @objc private func onContrct(){
        print("----onContrct------")
    }
}
