//
//  ViewController.swift
//  StateBarHidden
//
//  Created by Xuzixiang on 2016/12/24.
//  Copyright © 2016年 TouchSpring. All rights reserved.
//

import UIKit
import YLProgressBar

class ViewController: UIViewController {
    
    struct Screen {
        static var width = UIScreen.main.bounds.width
        static var height = UIScreen.main.bounds.height
    }
    
    var progressBar: YLProgressBar =  {
        let progressBar = YLProgressBar(frame: CGRect(x :0, y: 0, width: Screen.width, height: 10))
        progressBar.type = .flat
        progressBar.isHidden = true
        progressBar.progressTintColor = UIColor.yellow
        progressBar.indicatorTextDisplayMode = .progress
        progressBar.behavior = .indeterminate
        progressBar.stripesOrientation = .vertical
        progressBar.setProgress(0.2, animated: true)
        return progressBar
    }()
    
    var timer: DispatchSourceTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.keyWindow?.addSubview(progressBar)
        
        let queue = DispatchQueue(label: "com.touchspring.timer", attributes: .concurrent)
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer.scheduleRepeating(deadline: .now(), interval: .seconds(1), leeway: .seconds(1))
        timer.setEventHandler { [weak self] in
            self?.progressAnimation()
        }
        
        timer.resume()
    }
    
    let values = [0.4, 0.5, 0.7, 1.0]
    func progressAnimation() {
        let diceRoll = Int(arc4random_uniform(4))
        DispatchQueue.main.async {
            self.progressBar.setProgress(CGFloat(self.values[diceRoll]), animated: true)
        }
        
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
        
        progressBar.isHidden = !isStatusBarHidden
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
