//
//  ViewController.swift
//  LeBaluchon
//
//  Created by Manon Russo on 09/04/2021.
//

import UIKit

final class WeatherViewController: UIViewController {
    // MARK: Private properties
    @IBOutlet weak private var tempLabel: UILabel!
    @IBOutlet weak private var cityNameLabel: UILabel!
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var cityPicture: UIImageView!
    @IBOutlet weak private var feelsLikeLabel: UILabel!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    
    private var nyWeather: MainWeatherInfo?
    private var lyonWeather: MainWeatherInfo?
    private var cityPicUrls: PhotosInfo?
    
    // MARK: Override methods
    
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
        /// Fetching the city weather matching the selected segment index.
        if segmentedControl.selectedSegmentIndex == 0 {
            fetchLyon()
        } else {
            fetchNy()
        }
    }
    
    // MARK: Private methods
    private func fetchLyon() {
        activityIndicator.isHidden = false
        /// Network call of the weather data for the city indicated in parameter.
        OpenWeatherAPI.shared.fetchWeatherDataFor(WeatherId.lyon.cityID) { [weak self] (result) in
            DispatchQueue.main.async { /// About to modifiy the view in both cases.
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
                /// Once the picture is loaded and displayed, we hide the loading icon.
                self?.activityIndicator.isHidden = true
            }
        }
    }
    
    private func fetchNy() {
        activityIndicator.isHidden = false
        /// Network call of the weather data for the city indicated in parameter.
        OpenWeatherAPI.shared.fetchWeatherDataFor(WeatherId.newYork.cityID) { [weak self] (result) in
            DispatchQueue.main.async { /// About to modifiy the view in both cases.
                switch result {
                case .success(let weatherInfo):
                    /// If we get data from the network call, we'll call updateUI() with parameters define from the data we previously get (matching our MainWeatherInfo struct),
                    self?.nyWeather = weatherInfo
                    self?.updateUI(self?.nyWeather)
                    /// and then we'll fetch the city picture for the corresponding city.
                    self?.fetchCityPicture(Album.newYork.cityID)
                case .failure(let error):
                    /// Displaying an errror for the user with the UIAlert and for the developper in the console with the print.
                    print("error fetching weather data for NY : \(error)")
                    self?.showAlert()
                }
                /// Once the picture is loaded and displayed, we hide the loading icon in background.
                self?.activityIndicator.isHidden = true
            }
        }
    }
    
    private func fetchCityPicture(_ albumId: String) {
        /// Network call of the photo data for the city indicated in parameter (albumId is defined above when fetchCityPicture is called in each fetchLyon() and fetchNy().
        UnsplashAPI.shared.fetchPhotoDataFor(albumId) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let photoInfo):
                    /// If we get data from the network call, we'll define a randomElement from it (which is a photo collection), and then, we'll call the method updatePhoto().
                    self?.cityPicUrls = photoInfo.randomElement()
                    self?.updatePhoto()
                case .failure(let error):
                    print("error fetching photo data : \(error)")
                    self?.showAlert()
                }
            }
        }
    }
    
    private func updateUI(_ cityWeather: MainWeatherInfo?) {
        /// First we're checking we've got data
        guard let recoveredData = cityWeather,
              let cityWeather = recoveredData.weather.first else { return }
        print("fetching the weather for : \(recoveredData.name)")
        ///Then, we're filling the differents label and the icon ImageView with these datas.
        cityNameLabel.text = recoveredData.name
        tempLabel.text = "\(recoveredData.main.temp.editMaxDigitTo(1))??C"
        iconImageView.loadIcon(cityWeather.icon)
        descriptionLabel.text = cityWeather.description.capitalizingFirstLetter()
        feelsLikeLabel.text = "Ressenti : \(recoveredData.main.feels_like.editMaxDigitTo(1)) ??C"
    }
    
    private func updatePhoto() {
        /// Updating the background image according to the city selectionned thanks to the method loadCityImage().
        guard let photosInfo = self.cityPicUrls else { return }
        print("picture's URL : \(photosInfo.urls.regular)")
        /// Updating the cityPicture with the loadCityImage() method taking as parameter the url from the random photo we get by calling fetchPhotoData() in fetchCityPicture().
        cityPicture.loadCityImage(photosInfo.urls.regular)
    }
    
    // MARK: IBAction
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        /// Updating the view according to the selected segment index.
        if sender.selectedSegmentIndex == 0 {
            fetchLyon()
        } else {
            fetchNy()
        }
    }
    
}
