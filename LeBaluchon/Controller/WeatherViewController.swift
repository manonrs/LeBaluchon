//
//  ViewController.swift
//  LeBaluchon
//
//  Created by Manon Russo on 09/04/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityPicture: UIImageView!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    var nyWeather: MainWeatherInfo?
    var lyonWeather: MainWeatherInfo?
    var cityPicID: PhotosInfo?
    var openWeatherApi = OpenWeatherAPI()
    var unsplashAPI = UnsplashAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLyon()
    }
    
    func fetchCityPicture(_ albumId: String, _ cityWeather: MainWeatherInfo?) {
        unsplashAPI.fetchPhotoDataFor(albumId) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let photoInfo):
                    self?.cityPicID = photoInfo.randomElement()
                    self?.updateUI(cityWeather)
                case .failure(let error):
                    print("error fetching photo data : \(error)")
                    self?.showAlert()
                }
            }
        }
    }
    
    func fetchLyon() {
        openWeatherApi.fetchWeatherDataFor(WeatherId.lyon.cityID!) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherInfo):
                    self?.lyonWeather = weatherInfo
                    // guard let lyonAlbumId = self?.unsplashAPI.lyonAlbumId else { return }
                    // remplacé par :
                    guard let lyonAlbumId = Album.lyon.cityID else { return }
                    self?.fetchCityPicture(lyonAlbumId, self?.lyonWeather)
                    
                case .failure(let error):
                    print("error fetching weather data for Lyon : \(error)")
                    self?.showAlert()
                }
            }
        }
    }
    
    func fetchNy() {
        openWeatherApi.fetchWeatherDataFor(WeatherId.newYork.cityID!) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherInfo):
                    self?.nyWeather = weatherInfo
                    guard let nyAlbumId = Album.newYork.cityID else { return }
                    self?.fetchCityPicture(nyAlbumId, self?.nyWeather)
                case .failure(let error):
                    print("error fetching weather data for NY : \(error)")
                    self?.showAlert()
                }
            }
            
        }
    }
    
    func updateUI(_ cityWeather: MainWeatherInfo?) {
        guard let new = cityWeather else { return }
        guard let new2 = self.cityPicID else { return }
        print(new2.urls)
        print(new.name)
        // enlever les selfs
        guard let first = new.weather.first else { return }
        cityNameLabel.text = new.name
        tempLabel.text = "\(new.main.temp.editMaxDigitTo(1))°C"
        iconImageView.loadIcon(first.icon)
        descriptionLabel.text = first.description.capitalizingFirstLetter()
        cityPicture.loadCityImage(new2.urls.regular)
        feelsLikeLabel.text = "Ressenti : \(new.main.feels_like.editMaxDigitTo(1)) °C"
        iconImageView.addShadow()
        tempLabel.addShadow()
        descriptionLabel.addShadow()
        feelsLikeLabel.addShadow()
        cityNameLabel.addShadow()
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            fetchLyon()
        } else {
            fetchNy()
        }
    }
    
}
