//
//  ViewController.swift
//  HQSegment
//
//  Created by gandijun on 2018/3/6.
//  Copyright © 2018年 HeQing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 40)
        let titleArr = ["第一","第二","第一第一","第一第一第一第","第一","第一第一第一","第一第","第一第一"]
        let titleSegmentV = HQSegmentView(frame: frame, titleArray: titleArr, titleFont: 15.0, titleColor: .green, titleSelectColor: .red, style: .HQSegmentStyleSlider) { index in
            print("点击了\(index)")
        }
        view.addSubview(titleSegmentV)
        
        let frame1 = CGRect(x: 0, y: 200, width: view.frame.size.width, height: 40)
        let titleSegmentV1 = HQSegmentView(frame: frame1, titleArray: titleArr, titleFont: 15.0, titleColor: .green, titleSelectColor: .red, style: .HQSegmentStyleZoom) { index in
            print("点击了\(index)")
        }
        view.addSubview(titleSegmentV1)
        
        let frame2 = CGRect(x: 0, y: 300, width: view.frame.size.width, height: 40)
        let titleSegmentV2 = HQSegmentView(frame: frame2, titleArray: titleArr, titleFont: 15.0, titleColor: .green, titleSelectColor: .red, style: .HQSegmentStyleNone) { index in
            print("点击了\(index)")
        }
        view.addSubview(titleSegmentV2)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

