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
//    var openWeatherApi = OpenWeatherAPI()
//    var unsplashAPI = UnsplashAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Setting up the view.
        iconImageView.addShadow()
        tempLabel.addShadow()
        descriptionLabel.addShadow()
        feelsLikeLabel.addShadow()
        cityNameLabel.addShadow()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        /// Fetching the city weather matching the selected segment index
        if segmentedControl.selectedSegmentIndex == 0 {
            fetchLyon()
        } else {
            fetchNy()
        }
    }
    
    func fetchLyon() {
        activityIndicator.isHidden = false
        /// Network call of the weather data for the city indicated in parameter
        OpenWeatherAPI.shared.fetchWeatherDataFor(WeatherId.lyon.cityID) { [weak self] (result) in
            DispatchQueue.main.async { /// About to modifiy the view in both case
                switch result {
                case .success(let weatherInfo):
                    /// If we got data from the network call, we'll call updateUI() with parameters define from the data we previously get (matching our MainWeatherInfo struct).
                    self?.lyonWeather = weatherInfo
                    self?.updateUI(self?.lyonWeather)
                    /// and then we'll fetch the city picture for the corresponding city
                    self?.fetchCityPicture(Album.lyon.cityID)
                case .failure(let error):
                    /// Displaying an errror for the user with the UIAlert and in the console with the print.
                    print("error fetching weather data for Lyon : \(error)")
                    self?.showAlert()
                }
            }
        }
    }
    
    func fetchNy() {
        activityIndicator.isHidden = false
        /// Network call of the weather data for the city indicated in parameter
        OpenWeatherAPI.shared.fetchWeatherDataFor(WeatherId.newYork.cityID) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherInfo):
                    /// If we get data from the network call, we'll call updateUI() with parameters define from the data we previously get (matching our MainWeatherInfo struct).
                    self?.nyWeather = weatherInfo
                    self?.updateUI(self?.nyWeather)
                    /// and then we'll fetch the city picture for the corresponding city
                    self?.fetchCityPicture(Album.newYork.cityID)
                case .failure(let error):
                    /// Displaying an errror for the user with the UIAlert and for the developper in the console with the print.
                    print("error fetching weather data for NY : \(error)")
                    self?.showAlert()
                }
            }
        }
    }
    
    func fetchCityPicture(_ albumId: String) {
        /// Network call of the photo data for the city indicated in parameter (albumId is defined above when fetchCityPicture is called in each fetchLyon() and fetchNy().
        UnsplashAPI.shared.fetchPhotoDataFor(albumId) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let photoInfo):
                    /// If we get data from the network call, we'll define a randomElement from it (which is a photo collection), and then, we'll call the method updatePhoto().
                    self?.cityPicID = photoInfo.randomElement()
                    self?.updatePhoto()
                case .failure(let error):
                    print("error fetching photo data : \(error)")
                    self?.showAlert()
                }
            }
        }
    }
    
    func updateUI(_ cityWeather: MainWeatherInfo?) {
        /// First we're checking we've got data
        guard let new = cityWeather,
              let cityWeather = new.weather.first else { return }
        print("fetching the weather for : \(new.name)")

        ///Then, we're filling the differents label and the icon ImageView with these datas.
        cityNameLabel.text = new.name
        tempLabel.text = "\(new.main.temp.editMaxDigitTo(1))°C"
        iconImageView.loadIcon(cityWeather.icon)
        descriptionLabel.text = cityWeather.description.capitalizingFirstLetter()
        feelsLikeLabel.text = "Ressenti : \(new.main.feels_like.editMaxDigitTo(1)) °C"
    }
    
    func updatePhoto() {
        /// Updating the background image according to the city selectionned thanks to the method loadCityImage().
        guard let photosInfo = self.cityPicID else { return }
        print("picture's URL : \(photosInfo.urls.regular)")
        /// Updating the cityPicture with the loadCityImage() method taking as parameter the url from the random photo we get by calling fetchPhotoData() in fetchCityPicture().
        cityPicture.loadCityImage(photosInfo.urls.regular)
        /// Once the picture is loaded and displayed, we hide the loading icon in background.
        activityIndicator.isHidden = true
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        /// Updating the view according to the selected segment index.
        if sender.selectedSegmentIndex == 0 {
            fetchLyon()
        } else {
            fetchNy()
        }
    }
    
}
