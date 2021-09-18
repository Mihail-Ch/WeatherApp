//
//  MyCitiesController.swift
//  Weather
//
//  Created by Михаил Чертов on 10.08.2021.
//

import UIKit

class MyCitiesController: UITableViewController {
    
    let cellTypeNib = UINib(nibName: "CityCell", bundle: nil)
    var myCities = [City]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(cellTypeNib, forCellReuseIdentifier: "CityCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myCities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        let city = myCities[indexPath.row]
        cell.configure(city: city.title, emblem: city.emblem)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myCities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
        

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toWeatherScreen", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toWeatherScreen":
            prepareWeatherScreen(segue)
        default:
            break
        }
    }
    
    //MARK: - Method
    
    private func prepareWeatherScreen (_ segue: UIStoryboardSegue) {
        guard let weatherController = segue.destination as? WeatherViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        let items = myCities[indexPath.row]
        weatherController.title = items.title
        weatherController.weathers = items.emblem
       
    }
    
    
    //MARK: - Action
    
    @IBAction func addCity(_ segue: UIStoryboardSegue) {
        guard let allCityController = segue.source as? AllCitiesController,
              let indexPath = allCityController.tableView.indexPathForSelectedRow   else { return }
        let cityForMe = allCityController.cities[indexPath.row]
        if !myCities.contains(cityForMe) {
            myCities.append(cityForMe)
            tableView.reloadData()
        }
    }
}
