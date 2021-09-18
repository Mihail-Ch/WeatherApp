//
//  WeatherCollectionViewCell.swift
//  Weather
//
//  Created by Михаил Чертов on 10.08.2021.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var icone: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var shadowView: UIView! {
        didSet {
            self.shadowView.layer.shadowOffset = .zero
            self.shadowView.layer.shadowOpacity = 0.75
            self.shadowView.layer.shadowRadius = 4
            self.shadowView.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.clipsToBounds = true
          //  self.containerView.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.shadowView.layer.shadowPath = UIBezierPath(ovalIn: self.shadowView.bounds).cgPath
        self.shadowView.layer.cornerRadius = shadowView.frame.width / 2
        self.containerView.layer.cornerRadius = containerView.frame.width / 2
    }
    
}
