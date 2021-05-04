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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var nyWeather: MainWeatherInfo?
    var lyonWeather: MainWeatherInfo?
    var cityPicID: PhotosInfo?
    var openWeatherApi = OpenWeatherAPI()
    var unsplashAPI = UnsplashAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Setting up the selectedSegmentIndex which loads first.
        iconImageView.addShadow()
        tempLabel.addShadow()
        descriptionLabel.addShadow()
        feelsLikeLabel.addShadow()
        cityNameLabel.addShadow()
    }

    //faire viewDidApp
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
//         check le segment selectionné
        if segmentedControl.selectedSegmentIndex == 0 {
            fetchLyon()
        } else {
            fetchNy()
        }
    }
    
    func fetchCityPicture(_ albumId: String) {
        unsplashAPI.fetchPhotoDataFor(albumId) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let photoInfo):
                    self?.cityPicID = photoInfo.randomElement()
                    self?.updatePhoto()
                case .failure(let error):
                    print("error fetching photo data : \(error)")
                    self?.showAlert()
                }
            }
        }
    }
    
    func fetchLyon() {
        activityIndicator.isHidden = false
        openWeatherApi.fetchWeatherDataFor(WeatherId.lyon.cityID) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherInfo):
                    self?.lyonWeather = weatherInfo
                    self?.updateUI(self?.lyonWeather)
                    self?.fetchCityPicture(Album.lyon.cityID)
                case .failure(let error):
                    print("error fetching weather data for Lyon : \(error)")
                    self?.showAlert()
                }
            }
        }
    }
    
    func fetchNy() {
        activityIndicator.isHidden = false
        openWeatherApi.fetchWeatherDataFor(WeatherId.newYork.cityID) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherInfo):
                    self?.nyWeather = weatherInfo
                    self?.updateUI(self?.nyWeather)
                    self?.fetchCityPicture(Album.newYork.cityID)
                case .failure(let error):
                    print("error fetching weather data for NY : \(error)")
                    self?.showAlert()
                }
            }
        }
    }
    
    func updateUI(_ cityWeather: MainWeatherInfo?) {
        guard let new = cityWeather else { return }
        print(new.name)
        guard let cityWeather = new.weather.first else { return }
        cityNameLabel.text = new.name
        tempLabel.text = "\(new.main.temp.editMaxDigitTo(1))°C"
        iconImageView.loadIcon(cityWeather.icon)
        descriptionLabel.text = cityWeather.description.capitalizingFirstLetter()
        feelsLikeLabel.text = "Ressenti : \(new.main.feels_like.editMaxDigitTo(1)) °C"
    }
    
    func updatePhoto() {
        guard let photosInfo = self.cityPicID else { return }
        print(photosInfo.urls)
        cityPicture.loadCityImage(photosInfo.urls.regular)
        activityIndicator.isHidden = true
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            fetchLyon()
        } else {
            fetchNy()
        }
    }
    
}
