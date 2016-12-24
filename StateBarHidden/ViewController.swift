//
//  ViewController.swift
//  StateBarHidden
//
//  Created by Xuzixiang on 2016/12/24.
//  Copyright © 2016年 TouchSpring. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    var isStatusBarHidden = false
    @IBAction func toggleStateBar(_ sender: UIButton) {
        isStatusBarHidden = !isStatusBarHidden
        setNeedsStatusBarAppearanceUpdate()
    }

    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
}

class ViewControllerB: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension UINavigationController {

    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    open override var childViewControllerForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
    
    open override var childViewControllerForStatusBarHidden: UIViewController? {
         return visibleViewController
    }
    
}
