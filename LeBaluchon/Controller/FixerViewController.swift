//
//  FixerViewController.swift
//  LeBaluchon
//
//  Created by Manon Russo on 13/04/2021.
//

import UIKit

class FixerViewController: UIViewController {
    
    @IBOutlet weak var resultToConvert: UITextField! {
        didSet { resultToConvert?.addDoneCancelToolbar() }
    }
    @IBOutlet weak var conversionButton: UIButton!
    @IBOutlet weak var convertedResult: UILabel!
    @IBOutlet weak var exchangeRateLabel: UILabel!
    var exchangeRate: RateInfo?
    var fixerApi = FixerApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrency()
    }
    
    func fetchCurrency() {
        fixerApi.fetchCurrencyData() { [weak self] (result) in
            switch result {
            case .success(let currencyInfo):
                self?.exchangeRate = currencyInfo
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            case .failure(let error):
                print("error: \(error)") // Afficher UIAlert à la plae
            }
        }
    }
    
    func updateUI() {
        guard let new = exchangeRate,
              let resultToConvert = resultToConvert.text,
              let finalResultToConvert = resultToConvert.floatValue,
              let number = Float?(finalResultToConvert),
              let usdRates = new.rates.USD else { return }
        self.exchangeRateLabel.text = "1 € = \(usdRates.editMaxDigitTo(4)) $"
        convertedResult.layer.masksToBounds = true
        convertedResult.layer.cornerRadius = 5
        print(new.rates)
        convertedResult.text = "\((usdRates * number).editMaxDigitTo(2)) $"
    }
    
    @IBAction func didTapConversionButton(_ sender: UIButton) {
        fetchCurrency()
    }
    
}


