//
//  FixerViewController.swift
//  LeBaluchon
//
//  Created by Manon Russo on 13/04/2021.
//

import UIKit

final class FixerViewController: UIViewController {
    
    // MARK: Private properties
    @IBOutlet weak private var resultToConvert: UITextField! {
        didSet { resultToConvert?.addDoneToolBar() }
    }
    @IBOutlet weak private var conversionButton: UIButton!
    @IBOutlet weak private var convertedResult: UILabel!
    @IBOutlet weak private var exchangeRateLabel: UILabel!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    private var exchangeRate: RateInfo?
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Setting up the view.
        conversionButton.addCornerRadius()
        convertedResult.addCornerRadius()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        fetchCurrency()
    }
    
    // MARK: Private methods
    private func fetchCurrency() {
        activityIndicator.isHidden = false
        conversionButton.isHidden = true
        exchangeRateLabel.isHidden = true
        /// Network call which allowed us to recover the exchange rate from the data.
        FixerApi.shared.fetchCurrencyData() { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let currencyInfo):
                    /// If we get data from the network call, we'll update UI with these recovered data (exchangeRate and currencyInfo has same structure so values can match).
                    self?.exchangeRate = currencyInfo
                    self?.updateUI()
                case .failure(let error):
                    print("error fetching currency data for Dollars $ : \(error)")
                    self?.showAlert()
                }
                /// Once we update the UI with the correct data, we hide the loading icon and unhide elements which has been updated.
                self?.activityIndicator.isHidden = true
                self?.conversionButton.isHidden = false
                self?.exchangeRateLabel.isHidden = false
            }
        }
    }
    
    private func updateUI() {
        /// Recovering the corresponding data.
        guard let ratesInfo = exchangeRate,
              let resultToConvert = resultToConvert.text,
              let usdRates = ratesInfo.rates.USD else { return }
        exchangeRateLabel.text = "1 € = \(usdRates.editMaxDigitTo(4)) $"
        guard let finalResultToConvert = Float(resultToConvert.replacingOccurrences(of: ",", with: ".")) else { return }
        convertedResult.text = "\((usdRates * finalResultToConvert).editMaxDigitTo(2)) $"
    }
    
    // MARK: IBAction
    @IBAction func didTapConversionButton(_ sender: UIButton) {
        /// Fetching and diplaying the value from user input (resultToConvert) in € to convertedResult in $ (thanks to exchange rate we'll get), also closing the keyboard.
        fetchCurrency()
        resultToConvert.closeKeyboard()
    }
    
}


