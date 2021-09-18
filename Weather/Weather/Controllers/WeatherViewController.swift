//
//  WeatherViewController.swift
//  Weather
//
//  Created by Михаил Чертов on 13.08.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var weathers = String()
    let weatherService = WeatherService()
    
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        weatherService.loadWeatherData(city: "Moscow")
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

extension WeatherViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
      //  let weathers = weathers[indexPath.row]
        cell.icone.image = UIImage(named: weathers)
        cell.weather.text = "24 C"
        cell.time.text = "14.08.21 15:00"
        return cell
    }
    
    
    
    
}
