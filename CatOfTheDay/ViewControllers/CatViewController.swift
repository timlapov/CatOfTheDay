//
//  ViewController.swift
//  CatOfTheDay
//
//  Created by Artem Lapov on 05.11.2022.
//

import UIKit

class CatViewController: UIViewController {

    @IBOutlet var catImageView: UIImageView!
    @IBOutlet var catFactTextView: UITextView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catImageView.image = UIImage(named: "defaultCat.jpg")
        activityIndicator.isHidden = true
    }

    @IBAction func catGeneratorButton() {
        catImageView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        catFactTextView.isHidden = true
        fetchCatFact()
        fetchCatImage()
    }

    private func fetchCatImage() {
        NetworkManager.shared.fetchCatImage(from: Link.imageURL.rawValue) { result in
            switch result {
            case .success(let imageData):
                self.catImageView.image = UIImage(data: imageData)
                self.catImageView.isHidden = false
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchCatFact() {
        NetworkManager.shared.fetchCatFact(from: Link.factURL.rawValue) { result in
            switch result {
            case .success(let fact):
                self.catFactTextView.text = fact.data[0]
                self.catFactTextView.isHidden = false
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }

}


