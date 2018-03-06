//
//  HQSegmentView.swift
//  ZWDX
//
//  Created by gandijun on 2018/3/6.
//  Copyright © 2018年 CNKI. All rights reserved.
//

import UIKit

enum HQSegmentStyle{
    case HQSegmentStyleSlider
    case HQSegmentStyleZoom
    case HQSegmentStyleNone
}

typealias TitleChooseBlock = (Int) -> Void

class HQSegmentView: UIScrollView {
    
    // MARK: - public
    var titleChooseBlock: TitleChooseBlock?
    
    // MARK: - private
    fileprivate var headerH: CGFloat!
    fileprivate var titleArray = [String]()
    fileprivate var titleColor: UIColor!
    fileprivate var titleSelectColor: UIColor!
    fileprivate var segmentStyle: HQSegmentStyle!
    fileprivate var titleFont: CGFloat!
    
    fileprivate var slider: UIView!
    fileprivate var titleWidthArray = [CGFloat]()
    fileprivate var selectedBtn: UIButton!

    convenience init(frame: CGRect, titleArray: [String], titleFont: CGFloat, titleColor: UIColor, titleSelectColor: UIColor, style: HQSegmentStyle, titleChooseBlock: @escaping TitleChooseBlock) {
        self.init(frame: frame)
        
        self.backgroundColor = UIColor.lightGray
        self.bounces = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.headerH = frame.size.height
        self.segmentStyle = style
        self.titleArray = titleArray
        self.titleColor = titleColor
        self.titleSelectColor = titleSelectColor
        self.titleFont = titleFont
        self.titleChooseBlock = titleChooseBlock
        
        setSegment()
    }
    
}

// MARK: - privateMethods
extension HQSegmentView {
    
    fileprivate func setSegment() {
        
        if self.segmentStyle == .HQSegmentStyleSlider {
            
            slider = UIView(frame: CGRect(x: 0, y: headerH-2, width: 0, height: 2))
            slider.backgroundColor = titleSelectColor
            addSubview(slider)
        }
        
        var totalWidth: CGFloat = 15.0
        let btnSpace: CGFloat = 15.0
        titleWidthArray = []
        for i in 0..<titleArray.count {
            
            let titleWidth = getTitleWidth(titleArray[i], font: titleFont)
            titleWidthArray.append(titleWidth)
            
            let btn = UIButton(type: .custom)
            addSubview(btn)
            let btnW = titleWidth + 20
            btn.frame = CGRect(x: totalWidth, y: 0, width: btnW, height: headerH - 2)
            btn.contentMode = .center
            btn.titleLabel?.textAlignment = .center
            btn.tag = i
            btn.setTitle(titleArray[i], for: .normal)
            btn.setTitleColor(titleColor, for: .normal)
            btn.setTitleColor(titleSelectColor, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: titleFont)
            btn.addTarget(self, action: Selector.buttonClick, for: .touchUpInside)
            totalWidth = totalWidth + btnW + btnSpace
            
            if i == 0 {
                btn.isSelected = true
                self.selectedBtn = btn
                if segmentStyle == .HQSegmentStyleSlider {
                    slider.frame.size.width = titleWidth
                    slider.center.x = btn.center.x
                }
                else if segmentStyle == .HQSegmentStyleZoom {
                    selectedBtn.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
                }
            }
        }
        
        self.contentSize = CGSize(width: totalWidth, height: 0)
        
    }
    
    fileprivate func getTitleWidth(_ title: String, font: CGFloat) -> CGFloat {
        
        let size = title.boundingRect(with: CGSize(width: 300, height: headerH-2),
                                      options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                      attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: font)],
                                      context: nil).size
        return size.width
    }
}

// MARK: - ButtonClick
extension HQSegmentView {
    
    @objc fileprivate func buttonClick(_ button: UIButton) {
        
        selectedBtn.isSelected = false
        button.isSelected = true
        if segmentStyle == .HQSegmentStyleSlider {
            
            let sliderW = titleWidthArray[button.tag]
            UIView.animate(withDuration: 0.2, animations: {
                self.slider.frame.size.width = sliderW
                self.slider.center.x = button.center.x
            })
        }
        else if segmentStyle == .HQSegmentStyleZoom {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.selectedBtn.transform = CGAffineTransform.identity
                button.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            })
        }
        
        self.selectedBtn = button
        var offsetX = button.center.x - self.frame.size.width*0.5
        if offsetX < 0 {
            offsetX = 0
        }
        if offsetX > self.contentSize.width - self.frame.size.width {
            offsetX = self.contentSize.width - self.frame.size.width
        }
        self.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
        if let titleChooseBlock = titleChooseBlock {
            titleChooseBlock(button.tag)
        }
    }
}


// MARK: - Selector
private extension Selector {
    static let buttonClick = #selector(HQSegmentView.buttonClick(_:))
}
