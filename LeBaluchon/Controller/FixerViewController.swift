//
//  FixerViewController.swift
//  LeBaluchon
//
//  Created by Manon Russo on 13/04/2021.
//

import UIKit

class FixerViewController: UIViewController {
    
    @IBOutlet weak var resultToConvert: UITextField! {
        didSet { resultToConvert?.addDoneToolBar() }
    }
    @IBOutlet weak var conversionButton: UIButton!
    @IBOutlet weak var convertedResult: UILabel!
    @IBOutlet weak var exchangeRateLabel: UILabel!
    var exchangeRate: RateInfo?
    var fixerApi = FixerApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversionButton.addCornerRadius()
        convertedResult.addCornerRadius()
        fetchCurrency()
        resultToConvert.text = ""
    }
    
    func fetchCurrency() {
        fixerApi.fetchCurrencyData() { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let currencyInfo):
                    self?.exchangeRate = currencyInfo
                    self?.updateExchangeRateLabel()
                    self?.updateUI()
                case .failure(let error):
                    print("error fetching currency data for Dollars $ : \(error)")
                    self?.showAlert()
                }
            }
        }
    }
    
    func updateExchangeRateLabel() {
        guard let ratesInfo = exchangeRate,
              let usdRates = ratesInfo.rates.USD else { return }
        exchangeRateLabel.text = "1 € = \(usdRates.editMaxDigitTo(4)) $"
    }
    
    func updateUI() {
        guard let ratesInfo = exchangeRate,
              let resultToConvert = resultToConvert.text,
              let usdRates = ratesInfo.rates.USD else { return }
//        exchangeRateLabel.text = "1 € = \(usdRates.editMaxDigitTo(4)) $"
        guard let finalResultToConvert = Float(resultToConvert.replace(target: ",", withString: ".")) else { return }
        convertedResult.text = "\((usdRates * finalResultToConvert).editMaxDigitTo(2)) $"
    }
    
    @IBAction func didTapConversionButton(_ sender: UIButton) {
        fetchCurrency()
    }
    
}


