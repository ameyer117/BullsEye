//
//  AboutViewController.swift
//  Bullseye
//
//  Created by Alec Meyer on 11/9/21.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    
    var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Background"))
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let aboutWebView: WKWebView = {
        let webView = WKWebView()
        webView.layer.cornerRadius = 5.0
        return webView
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.tintColor = UIColor(red: 0.45, green: 0.17, blue: 0.04, alpha: 1.0)
        button.setBackgroundImage(UIImage(named: "Button-Normal"), for: .normal)
        button.setBackgroundImage(UIImage(named: "Button-Highlighted"), for: .highlighted)
        button.addTarget(self, action: #selector(closedPressed(_:)), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        configureUI()
        configureWebView()
    }
    
    @objc func closedPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func configureWebView() {
        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
            let request = URLRequest(url: url)
            aboutWebView.load(request)
        }
    }
    
    func configureUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(aboutWebView)
        aboutWebView.translatesAutoresizingMaskIntoConstraints = false
        aboutWebView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        aboutWebView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        aboutWebView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        aboutWebView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -16).isActive = true
    }
     

}
