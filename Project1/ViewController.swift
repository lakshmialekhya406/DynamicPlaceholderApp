//
//  ViewController.swift
//  Project1
//
//  Created by Batchu Lakshmi Alekhya on 10/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    var searchField: UITextField!
    var index = 0
//    let placeholderText = "Search for offers..."
    let listOfPlaceholders: [String] = [
        "Search for offers...",
        "Search for Brands...",
        "Search for Products...",
        "Search here..."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the text field
        searchField = UITextField()
        searchField.borderStyle = .roundedRect
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.textColor = UIColor.gray.withAlphaComponent(0.5)
        searchField.tintColor = UIColor.gray.withAlphaComponent(0.5)
        searchField.becomeFirstResponder()
        
        // Create the search icon image view
        let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIcon.tintColor = .gray
        searchIcon.contentMode = .scaleAspectFit
        
        // Add padding to the image view
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        searchIcon.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        paddingView.addSubview(searchIcon)
        
        // Set the image view as the left view of the text field
        searchField.leftView = paddingView
        searchField.leftViewMode = .always
        
        view.backgroundColor = .orange
        
        // Add the text field to the view
        view.addSubview(searchField)
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            searchField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add constraints to position the button on top of the text field
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: searchField.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: searchField.topAnchor, constant: -10) // Adjust -10 to change the space between button and text field
        ])
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setupPlaceHolder()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchField.layer.shadowColor = UIColor.black.cgColor
        searchField.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchField.layer.shadowOpacity = 0.5
        searchField.layer.shadowRadius = 4.0
        searchField.layer.masksToBounds = false
    }
    
    func setupPlaceHolder() {
        let placeholderText = listOfPlaceholders[index]
        var currentIndex = 0
        _ = Timer.scheduledTimer(
            withTimeInterval: 0.2,
            repeats: true
        ) { [weak self] timer in
            guard let self = self else {
                return
            }
            if currentIndex < placeholderText.count {
                let index = placeholderText.index(placeholderText.startIndex, offsetBy: currentIndex)
                self.searchField.text?.append(placeholderText[index])
                currentIndex += 1
            } else {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                    if self.index < self.listOfPlaceholders.count - 1 {
                        self.removePlaceholder(placeholderText: placeholderText)
                    }
                }
            }
        }
    }
    
    func removePlaceholder(placeholderText: String) {
        var index = placeholderText.count
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [self] timer in
            if index > 0 {
                self.searchField.text?.removeLast()
                index -= 1
            } else {
                timer.invalidate()
                self.index += 1
                if self.index < listOfPlaceholders.count {
                    setupPlaceHolder()
                }
            }
        }
    }
}

