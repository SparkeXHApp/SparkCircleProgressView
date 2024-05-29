//
//  ViewController.swift
//  SparkCircleProgressView
//
//  Created by SparkeXHApp on 05/29/2024.
//  Copyright (c) 2024 SparkeXHApp. All rights reserved.
//

import UIKit
import SparkCircleProgressView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(circleView)
        self.view.addSubview(pslider)
        
        circleView.playCallBack = { isplay in
            print("当前播放状态: \(isplay ? "正在播放" : "暂停播放")")
        }
    }
    
    //MARK: - valueChange event
    
    @objc func valueChange(_ sender: UISlider) {
        circleView.progress = CGFloat(sender.value)
    }
    
    //MARK: - lazyload
    
    lazy var circleView: SparkCircleProgressView = {
        let v = SparkCircleProgressView()
        v.frame = CGRect(x: (UIScreen.main.bounds.width - 300) / 2, y: 200, width: 300, height: 90)
        v.progress = 0
        v.lineWith = 10
        v.lineColor = .lightGray
        v.proLineWith = 2
        v.proColors = [UIColor.blue.cgColor, UIColor.blue.cgColor]
        v.isPlaying = false
        return v
    }()
    
    lazy var pslider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 20, y: 350, width: UIScreen.main.bounds.width - 40, height: 120))
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(self, action: #selector(valueChange(_ :)), for: .valueChanged)
        return slider
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

