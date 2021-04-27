//
//  GoogleTranslateViewController.swift
//  LeBaluchon
//
//  Created by Manon Russo on 16/04/2021.
//

import UIKit

class GoogleTranslateViewController: UIViewController {
    
    @IBOutlet weak var finalText: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var textToTranslate: UITextView! {
        didSet { textToTranslate?.addDoneCancelToolbar() }
    }
    var text: TranslationInfo?
    var googleAPI = GoogleTranslateAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTranslation()
    }
    
    func fetchTranslation() {
        googleAPI.fetchTranslationData(textToTranslate.text) { (result) in
            switch result {
            case .success(let translationInfo):
                self.text = translationInfo
                DispatchQueue.main.async {
                    self.updateUI()
                }
            case .failure(let error):
                self.showAlert()
                print("error: \(error)")
            }
        }
    }
    
    func updateUI() {
        textToTranslate.addCornerRadius()
        translateButton.addCornerRadius()
        finalText.addCornerRadius()
        finalText.isEditable = false
        finalText.text = text?.data.translations.first?.translatedText.replace(target: "&#39;", withString: "'").capitalizingFirstLetter()
    }
    
    @IBAction func didTapTranslateButton(_ sender: UIButton) {
        fetchTranslation()
    }
    
}
