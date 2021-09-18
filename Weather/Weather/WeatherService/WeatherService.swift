//
//  WeatherService.swift
//  Weather
//
//  Created by Михаил Чертов on 18.09.2021.
//


import Alamofire

class WeatherService  {
    
    // base url
    let baseUrl = "http://api.openweathermap.org"
    // key for service
    let apiKey = "e10a0d3ef402ef7af7c161a47d9bf253"
    
    // method for loading data, take get city
    func loadWeatherData(city: String) {
        // path for get weather for 5 days
        let path = "/data/2.5/forecast"
        // parameters, city, number graduse, key for service
        let parameters: Parameters = [
            "q": city,
            "units": "metric",
            "appid": apiKey
        ]
        
        // we make up URL as baseUrl and specific path
        let url = baseUrl + path
        
        // get request
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.value as Any)
        }
    }
}
