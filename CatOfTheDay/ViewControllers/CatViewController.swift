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

    override func viewDidLoad() {
        super.viewDidLoad()
        catImageView.image = UIImage(named: "defaultCat.jpg")
    }

    @IBAction func catGeneratorButton() {
        fetchCatFact()
        fetchCatImage()

    }

}

extension CatViewController {
    func fetchCatImage() {
        guard let url = URL(string: Link.imageURL.rawValue) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }

            guard let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self.catImageView.image = image
            }
        }.resume()
    }

    func fetchCatFact() {
        guard let url = URL(string: Link.factURL.rawValue) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let decoder = JSONDecoder()
            do {
                let fact = try decoder.decode(Fact.self, from: data)
                DispatchQueue.main.async {
                    self.catFactTextView.text = fact.data[0]
                }
                print(fact)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()

    }
}

