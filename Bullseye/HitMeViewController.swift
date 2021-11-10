//
//  ViewController.swift
//  Bullseye
//
//  Created by Alec Meyer on 11/9/21.
//

import UIKit

class HitMeViewController: UIViewController {
    
    var userValue = 50
    var targetValue = 0 {
        didSet {
            targetPointsLabel.text = "\(targetValue)"
        }
    }
    
    var userTotalScore = 0 {
        didSet {
            scoreLabel.text = "Score: \(userTotalScore)"
        }
    }
    
    var currentRound = 0 {
        didSet {
            roundLabel.text = "Round: \(currentRound)"
        }
    }
    
    var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Background"))
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var hitMeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hit Me!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.tintColor = UIColor(red: 0.45, green: 0.17, blue: 0.04, alpha: 1.0)
        button.setBackgroundImage(UIImage(named: "Button-Normal"), for: .normal)
        button.setBackgroundImage(UIImage(named: "Button-Highlighted"), for: .highlighted)
        button.addTarget(self, action: #selector(hitMePressed), for: .touchUpInside)
        
        return button
    }()
    
    var instructionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Put the Bull's Eye as close as you can to: "
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    var targetPointsLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    var startPointsLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    lazy var pointsSlider: UISlider = {
        let slider = UISlider()
        let edgeInsets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        slider.maximumValue = 100.0
        slider.value = Float(userValue)
        slider.minimumValue = 0.0
        slider.addTarget(self, action: #selector(pointsValueChanged), for: .valueChanged)
        slider.setThumbImage(UIImage(named: "SliderThumb-Normal"), for: .normal)
        slider.setThumbImage(UIImage(named: "SliderThumb-Highlighted"), for: .highlighted)
        slider.setMaximumTrackImage(UIImage(named: "SliderTrackRight")?.resizableImage(withCapInsets: edgeInsets), for: .normal)
        slider.setMinimumTrackImage(UIImage(named: "SliderTrackLeft")?.resizableImage(withCapInsets: edgeInsets), for: .normal)
        return slider
    }()
    
    var endPointsLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    var startOverButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gray
        button.setImage(UIImage(named: "StartOverIcon"), for: .normal)
        button.setBackgroundImage(UIImage(named: "SmallButton"), for: .normal)
        button.addTarget(self, action: #selector(startOver(_:)), for: .touchUpInside)
        return button
    }()
        
    var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score: 9999999"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    var roundLabel: UILabel = {
        let label = UILabel()
        label.text = "Round: 999"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gray
        button.setBackgroundImage(UIImage(named: "SmallButton"), for: .normal)
        button.setImage(UIImage(named: "InfoButton"), for: .normal)
        button.addTarget(self, action: #selector(aboutPressed(_:)), for: .touchUpInside)
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        nextRound()
    }
    
    // MARK: - Selectors
    @objc func hitMePressed() {
        let roundScore = 100 - abs(targetValue - userValue)
        
        let alert = UIAlertController(title: scoredTitle(forScore: roundScore), message: "You scored \(roundScore) points", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: { [weak self] in
            self?.nextRound(roundScore: roundScore)
        })
    }
    
    @objc func pointsValueChanged(_ sender: UISlider) {
        userValue = Int(sender.value)
    }
    
    @objc func startOver(_ sender: UIButton) {
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: .easeOut)
        view.layer.add(transition, forKey: nil)
        
        userTotalScore = 0
        currentRound = 0
        nextRound()
    }
    
    @objc func aboutPressed(_ sender: UIButton) {
        let controller = AboutViewController()
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
    }

    // MARK: - Helpers
    func scoredTitle(forScore roundScore: Int) -> String {
        var alertTitle = "Not even close..."
        if roundScore == 100 {
            alertTitle = "Perfect!"
        } else if roundScore >= 95 {
            alertTitle = "Almost!"
        } else if roundScore >= 90 {
            alertTitle = "Pretty Good!"
        }
        return alertTitle
    }
    
    func nextRound(roundScore: Int = 0) {
        userTotalScore += roundScore
        currentRound += 1
        targetValue = Int.random(in: 1...100)
        pointsSlider.setValue(50.0, animated: true)
    }
    
    func configureUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        view.addSubview(instructionsLabel)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        instructionsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        
        view.addSubview(targetPointsLabel)
        targetPointsLabel.translatesAutoresizingMaskIntoConstraints = false
        targetPointsLabel.leadingAnchor.constraint(equalTo: instructionsLabel.trailingAnchor, constant: 8).isActive = true
        targetPointsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        
        view.addSubview(hitMeButton)
        hitMeButton.translatesAutoresizingMaskIntoConstraints = false
        hitMeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hitMeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(pointsSlider)
        pointsSlider.translatesAutoresizingMaskIntoConstraints = false
        pointsSlider.bottomAnchor.constraint(equalTo: hitMeButton.topAnchor, constant: -16).isActive = true
        pointsSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pointsSlider.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.75).isActive = true
        
        view.addSubview(startPointsLabel)
        startPointsLabel.translatesAutoresizingMaskIntoConstraints = false
        startPointsLabel.trailingAnchor.constraint(equalTo: pointsSlider.leadingAnchor, constant: -8).isActive = true
        startPointsLabel.bottomAnchor.constraint(equalTo: hitMeButton.topAnchor, constant: -18).isActive = true
        
        view.addSubview(endPointsLabel)
        endPointsLabel.translatesAutoresizingMaskIntoConstraints = false
        endPointsLabel.leadingAnchor.constraint(equalTo: pointsSlider.trailingAnchor, constant: 8).isActive = true
        endPointsLabel.bottomAnchor.constraint(equalTo: hitMeButton.topAnchor, constant: -18).isActive = true
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [
            startOverButton,
            scoreLabel,
            roundLabel,
            infoButton
        ])
        
        bottomControlsStackView.axis = .horizontal
        bottomControlsStackView.distribution = .equalSpacing
        
        view.addSubview(bottomControlsStackView)
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }

}

