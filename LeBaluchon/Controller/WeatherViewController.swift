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
            switch result {
            case .success(let photoInfo):
                self?.cityPicID = photoInfo.randomElement()
                DispatchQueue.main.async {
                    self?.updateUI(cityWeather)
                }
            case .failure(let error):
                self?.showAlert()
                print("error: \(error)")
            }
        }
    }
    
    func fetchLyon() {
//        openWeatherApi.fetchWeatherDataFor(openWeatherApi.lyonID) { [weak self] (result) in
        openWeatherApi.fetchWeatherDataFor(WeatherId.lyon.cityID) { [weak self] (result) in
            switch result {
            case .success(let weatherInfo):
                self?.lyonWeather = weatherInfo
                DispatchQueue.main.async {
//                    guard let lyonAlbumId = self?.unsplashAPI.lyonAlbumId else { return }
                    guard let lyonAlbumId = Album.lyon.cityID else { return }
                    self?.fetchCityPicture(lyonAlbumId, self?.lyonWeather)
                }
            case .failure(let error):
                self?.showAlert()
                print("error: \(error)")
            }
        }
    }
    
    func fetchNy() {
        //        openWeatherApi.fetchWeatherDataFor(openWeatherApi.nyId) { [weak self] (result) in
        openWeatherApi.fetchWeatherDataFor(WeatherId.newYork.cityID) { [weak self] (result) in
            switch result {
            case .success(let weatherInfo):
                self?.nyWeather = weatherInfo
                DispatchQueue.main.async {
                    guard let nyAlbumId = Album.newYork.cityID else { return }
                    //                    guard let nyAlbumId = self?.unsplashAPI.nyAlbumId else { return }
                    self?.fetchCityPicture(nyAlbumId, self?.nyWeather)
                }
            case .failure(let error):
                self?.showAlert()
                print("error: \(error)") // Afficher UIAlert à la place
            }
        }
    }
    
    func updateUI(_ cityWeather: MainWeatherInfo?) {
        guard let new = cityWeather else { return }
        guard let new2 = self.cityPicID else { return }
        print(new2.urls)
        print(new.name)
        guard let first = new.weather.first else { return }
        self.cityNameLabel.text = new.name
        self.tempLabel.text = "\(new.main.temp.editMaxDigitTo(1))°C"
        self.iconImageView.loadIcon(first.icon)
        self.descriptionLabel.text = first.description.capitalizingFirstLetter()
        self.cityPicture.loadCityImage(new2.urls.regular)
        self.feelsLikeLabel.text = "Ressenti : \(new.main.feels_like.editMaxDigitTo(1)) °C"
        self.iconImageView.addShadow()
        self.tempLabel.addShadow()
        self.descriptionLabel.addShadow()
        self.feelsLikeLabel.addShadow()
        self.cityNameLabel.addShadow()
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            fetchLyon()
        } else {
            fetchNy()
        }
    }
    
}
