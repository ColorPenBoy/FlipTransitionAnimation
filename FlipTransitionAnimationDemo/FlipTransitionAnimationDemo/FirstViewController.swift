//
//  FirstViewController.swift
//  FlipTransitionAnimationDemo
//
//  Created by 张强 on 2016/11/18.
//  Copyright © 2016年 ColorPen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
        
        // Button
        let button = UIButton.init(type: .custom)
        button.bounds = CGRect(x: 0, y: 0, width: 200, height: 40)
        button.center = self.view.center
        button.setTitle("Push To Second VC", for: .normal)
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(FirstViewController.didPressButton(button:)), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    func didPressButton(button: UIButton) {
        let secVC = SecondViewController()
        secVC.transitioningDelegate = self
        self.present(secVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FirstViewController : UIViewControllerTransitioningDelegate {
    // view controller transition delegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // 使用自定义转场动画
        return HXHFlipTransition.present.animation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HXHFlipTransition.dismiss.animation()
    }
}
