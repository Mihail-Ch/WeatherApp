//
//  TestViewController.swift
//  Weather
//
//  Created by Михаил Чертов on 06.09.2021.
//

import UIKit

class TestViewController: UIViewController {
    
    let firstLayer = CAShapeLayer()
    let secondLayer = CAShapeLayer()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        create()
        animate()
    }
    
    private func create() {
        firstLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 4, height: 4)).cgPath
        secondLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 4, height: 4)).cgPath
        
        firstLayer.backgroundColor = UIColor.black.cgColor
        secondLayer.backgroundColor = UIColor.black.cgColor
        
        firstLayer.frame = CGRect(x: 100, y: 100, width: 4, height: 4)
        secondLayer.frame = CGRect(x: 100, y: 100, width: 4, height: 4)
        
        firstLayer.masksToBounds = true
        secondLayer.masksToBounds = true
        firstLayer.cornerRadius = 2
        secondLayer.cornerRadius = 2
        
        self.view.layer.addSublayer(firstLayer)
        self.view.layer.addSublayer(secondLayer)
    }
    
    private func animate() {
        let scale = CABasicAnimation(keyPath: "bounds.size.width")
        scale.byValue = 16
        scale.duration = 1
        scale.fillMode = CAMediaTimingFillMode.forwards
        scale.isRemovedOnCompletion = false
        
        let rotationLeft = CABasicAnimation(keyPath: "transform.rotation")
        rotationLeft.byValue = CGFloat.pi / 4
        rotationLeft.duration = 1
        rotationLeft.beginTime = CACurrentMediaTime() + 1
        rotationLeft.fillMode = CAMediaTimingFillMode.both
        rotationLeft.isRemovedOnCompletion = false
        
        let rotationRight = CABasicAnimation(keyPath: "transform.rotation")
        rotationRight.byValue = -CGFloat.pi / 4
        rotationRight.duration = 1
        rotationRight.beginTime = CACurrentMediaTime() + 1
        rotationRight.fillMode = CAMediaTimingFillMode.both
        rotationRight.isRemovedOnCompletion = false
        
        firstLayer.add(scale, forKey: nil)
        firstLayer.add(rotationLeft, forKey: nil)
        secondLayer.add(scale, forKey: nil)
        secondLayer.add(rotationRight, forKey: nil)
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
