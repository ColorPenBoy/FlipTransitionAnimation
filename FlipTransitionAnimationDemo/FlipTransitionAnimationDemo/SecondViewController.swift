//
//  SecondViewController.swift
//  FlipTransitionAnimationDemo
//
//  Created by 张强 on 2016/11/18.
//  Copyright © 2016年 ColorPen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.red
    
        // Button
        let button = UIButton.init(type: .custom)
        button.bounds = CGRect(x: 0, y: 0, width: 200, height: 40)
        button.center = self.view.center
        button.setTitle("Pop To First VC", for: .normal)
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(SecondViewController.didPressButton(button:)), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    func didPressButton(button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
