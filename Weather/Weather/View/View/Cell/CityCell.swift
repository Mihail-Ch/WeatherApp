//
//  CityCell.swift
//  Weather
//
//  Created by Михаил Чертов on 15.08.2021.
//

import UIKit

class CityCell: UITableViewCell {
    
    

    @IBOutlet weak var cityEmblema: UIImageView! {
        didSet {
            self.cityEmblema.layer.borderColor = UIColor.darkGray.cgColor
            self.cityEmblema.layer.borderWidth = 2
        }
    }
    @IBOutlet weak var cityName: UILabel! {
        didSet {
            self.cityName.textColor = UIColor.darkGray
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        cityEmblema.clipsToBounds = true
        cityEmblema.layer.cornerRadius = cityEmblema.frame.width / 2

    }
    
    func configure(city: String, emblem: String) {
        self.cityName.text = city
        self.cityEmblema.image = UIImage(named: emblem)
    }
    
    /*  override func prepareForReuse() {
        super.prepareForReuse()
        self.cityName.text = nil
        self.cityEmblema.image = nil
    } */
}
