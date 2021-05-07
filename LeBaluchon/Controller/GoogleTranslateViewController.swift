//
//  GoogleTranslateViewController.swift
//  LeBaluchon
//
//  Created by Manon Russo on 16/04/2021.
//

import UIKit

final class GoogleTranslateViewController: UIViewController {
    
    // MARK: Private properties
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var finalText: UITextView!
    @IBOutlet weak private var translateButton: UIButton!
    @IBOutlet weak private var textToTranslate: UITextView! {
        didSet { textToTranslate?.addDoneToolBar() }
    }
    private var text: TranslationInfo?
    
    // MARK: Override method
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Setting up the view.
        textToTranslate.addCornerRadius()
        translateButton.addCornerRadius()
        finalText.addCornerRadius()
        finalText.isEditable = false
        fetchTranslation()
    }
    
    //MARK: Private methods
    private func fetchTranslation() {
        translateButton.isHidden = true
        activityIndicator.isHidden = false
        GoogleTranslateAPI.shared.fetchTranslationData(textToTranslate.text) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let translationInfo):
                    self?.text = translationInfo
                    self?.updateUI()
                case .failure(let error):
                    print("error fetching translation data (fr to en): \(error)")
                    self?.showAlert()
                }
                self?.translateButton.isHidden = false
                self?.activityIndicator.isHidden = true
            }
        }
    }
    
    private func updateUI() {
        finalText.text = text?.data.translations.first?.translatedText.replacingOccurrences(of: "&#39;", with: "'").capitalizingFirstLetter()
    }
    
    // MARK: IBAction
    @IBAction func didTapTranslateButton(_ sender: UIButton) {
        fetchTranslation()
        textToTranslate.closeKeyboard()
    }
    
}
