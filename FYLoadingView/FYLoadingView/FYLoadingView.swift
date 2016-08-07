//
//  FYLoadingView.swift
//  FYLoadingView
//
//  Created by 武飞跃 on 2016/8/7.
//  Copyright © 2016年 RG. All rights reserved.
//

import UIKit

class FYLoadingView: UIView {

    private var contentView:FYLoadingCellView!
    let color:UIColor
    let cellHeight:CGFloat
    init(view:UIView,cellHeight:CGFloat? = 200,color:UIColor? = UIColor.groupTableViewBackgroundColor()) {
        
        self.color = color!
        self.cellHeight = cellHeight!
        super.init(frame: view.bounds)
        
        self.backgroundColor = UIColor.whiteColor()
        view.addSubview(self)
        self.createView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismiss(){
        UIView.animateWithDuration(0.3, animations: {
            self.layer.opacity = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    private func createView(){
        
        let cellNumber = Int(CGRectGetHeight(frame) / cellHeight) + 1
        for index in 0 ..< cellNumber {
            let cell = FYLoadingCellView(frame: CGRect(x: 0.0, y: cellHeight * CGFloat(index), width: CGRectGetWidth(frame), height: cellHeight), color:color)
            cell.startAnimation()
            addSubview(cell)
        }
    }

}

private class FYLoadingCellView:UIView{
    let color:UIColor
    var height:CGFloat!
    init(frame: CGRect, color:UIColor) {
        
        self.color = color
        self.height = 8
        
        super.init(frame: frame)
        
        createView()
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView(){
        
        let circle = CAShapeLayer()
        let circleSize:CGFloat = 50
        let padding:CGFloat = 15
        circle.path = fetchCirclePath(circleSize)
        circle.position = CGPoint(x: padding, y: padding)
        circle.fillColor = color.CGColor
        layer.addSublayer(circle)
        
        let title = CAShapeLayer()
        title.path = fetchRectPath(70, height: height)
        title.position = CGPoint(x: circleSize + padding + 15, y: (circleSize - height) / 2  + padding)
        title.fillColor = color.CGColor
        layer.addSublayer(title)
        
        
        let line = FYLineLayer(color:color.CGColor,width:CGRectGetWidth(frame),height: height)
        line.position = CGPoint(x: padding, y: circleSize + padding * 2.5)
        line.anchorPoint = CGPoint(x: 0, y: 0)
        line.setNeedsDisplay()
        gradientLayer.mask = line
        
        let lineView = CALayer()
        lineView.backgroundColor = UIColor.groupTableViewBackgroundColor().CGColor
        lineView.frame = CGRect(x: 0, y: CGRectGetHeight(frame) - 10, width: CGRectGetWidth(frame), height: 10)
        layer.addSublayer(lineView)
        
        
    }
    
    func startAnimation(){
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.75, 1.0, 1.0]
        gradientAnimation.duration = 3.0
        gradientAnimation.repeatCount = Float.infinity
        gradientLayer.addAnimation(gradientAnimation, forKey: gradientAnimation.keyPath)
    }
    
    func stopAnmation(){
        gradientLayer.removeAllAnimations()
    }
    
    deinit{
        stopAnmation()
        // print("移除成功")
    }
    
    private func fetchCirclePath(size:CGFloat) -> CGPathRef{
        let head = UIBezierPath.init(ovalInRect: CGRect(x: 0, y: 0, width: size, height: size))
        return head.CGPath
    }
    
    private func fetchRectPath(width:CGFloat, height:CGFloat) -> CGPathRef{
        let line = UIBezierPath.init(rect: CGRect(x: 0, y: 0, width: width, height: height))
        return line.CGPath
    }
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        // 设置开始位置和结束位置
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        // 从左到右依次的这几种颜色,颜色是渐变的
        let colors = [
            self.color.CGColor,
            UIColor.whiteColor().CGColor,
            self.color.CGColor
        ]
        gradientLayer.colors = colors
        
        // 颜色的位置
        let locations = [0.25, 0.5, 0.75]
        gradientLayer.locations = locations
        
        return gradientLayer
    }()
    
}

private class FYLineLayer:CALayer{
    
    let color:CGColor
    let width:CGFloat
    let height:CGFloat
    var offsetY:CGFloat!
    init(color:CGColor, width:CGFloat, height:CGFloat) {
        
        self.color = color
        self.width = width - 100
        self.height = height
        
        super.init()
        
        self.offsetY = 20
        
        self.bounds.size = CGSize(width: width,height: 2 * offsetY + 3 * height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawInContext(ctx: CGContext) {
        
        CGContextSetFillColorWithColor(ctx, color)
        CGContextFillRect(ctx, CGRect(x: 0, y: 0,  width: width, height: height))
        CGContextFillRect(ctx, CGRect(x: 0, y: height + offsetY, width: width + 30, height: height))
        CGContextFillRect(ctx, CGRect(x: 0, y: (height + offsetY) * 2, width: width - 30, height: height))
        CGContextFillPath(ctx)
    }
}
