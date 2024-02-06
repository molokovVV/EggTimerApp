//
//  ViewController.swift
//  EggTimerApp
//
//  Created by Виталик Молоков on 05.02.2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
// MARK: - UIComponents
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 0
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "How do you like your eggs?"
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var eggsStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let softImageView = UIImageView(imageName: "soft_egg")
    private let mediumImageView = UIImageView(imageName: "medium_egg")
    private let hardImageView = UIImageView(imageName: "hard_egg")
    
    private let softButton = UIButton(text: "Soft")
    private let mediumButton = UIButton(text: "Medium")
    private let hardButton = UIButton(text: "Hard")
    
    private lazy var timerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = .systemYellow
        view.trackTintColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
// MARK: -  Properties
    
    private let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    private var totalTime = 0
    private var secondPassed = 0
    private var timer = Timer()
    private var player: AVAudioPlayer?
    private var nameSoundTimer = "Alarm_sound"
    

// MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setupConstraints()
    }
// MARK: - Buisness Logic
    
    private func playSound(_ soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        player = try! AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    @objc private func eggsButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        progressView.setProgress(0, animated: true)
        secondPassed = 0
        
        let hardness = sender.titleLabel?.text ?? "error"
        
        titleLabel.text = "You should \(hardness)"
        
        totalTime = eggTimes[hardness] ?? 0
        
        timer = Timer.scheduledTimer(timeInterval: 1, 
                                     target: self, 
                                     selector: #selector(updateTimer), 
                                     userInfo: nil, 
                                     repeats: true)
    }
    
    @objc private func updateTimer() {
        if secondPassed < totalTime {
            secondPassed += 1
            
            let percentageProgress = Float(secondPassed) / Float(totalTime)
            
            progressView.setProgress(percentageProgress, animated: true)
        } else {
            playSound(nameSoundTimer)
            timer.invalidate()
            secondPassed = 0
            titleLabel.text = "That's done! Let's go repeat?"
            progressView.setProgress(1, animated: true)
        }
    }
}

// MARK: - Setup Views & Constraints

extension ViewController {
    private func setViews() {
        view.backgroundColor = .systemCyan
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(eggsStackView)
        mainStackView.addArrangedSubview(timerView)
        
        eggsStackView.addArrangedSubview(softImageView)
        eggsStackView.addArrangedSubview(mediumImageView)
        eggsStackView.addArrangedSubview(hardImageView)
        
        softImageView.addSubview(softButton)
        mediumImageView.addSubview(mediumButton)
        hardImageView.addSubview(hardButton)
        
        softButton.addTarget(self, action: #selector(eggsButtonTapped), for: .touchUpInside)
        mediumButton.addTarget(self, action: #selector(eggsButtonTapped), for: .touchUpInside)
        hardButton.addTarget(self, action: #selector(eggsButtonTapped), for: .touchUpInside)
        
        timerView.addSubview(progressView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            progressView.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
            progressView.leadingAnchor.constraint(equalTo: timerView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: timerView.trailingAnchor),
            
            softButton.topAnchor.constraint(equalTo: softImageView.topAnchor),
            softButton.bottomAnchor.constraint(equalTo: softImageView.bottomAnchor),
            softButton.leadingAnchor.constraint(equalTo: softImageView.leadingAnchor),
            softButton.trailingAnchor.constraint(equalTo: softImageView.trailingAnchor),
            
            mediumButton.topAnchor.constraint(equalTo: mediumImageView.topAnchor),
            mediumButton.bottomAnchor.constraint(equalTo: mediumImageView.bottomAnchor),
            mediumButton.leadingAnchor.constraint(equalTo: mediumImageView.leadingAnchor),
            mediumButton.trailingAnchor.constraint(equalTo: mediumImageView.trailingAnchor),
            
            hardButton.topAnchor.constraint(equalTo: hardImageView.topAnchor),
            hardButton.bottomAnchor.constraint(equalTo: hardImageView.bottomAnchor),
            hardButton.leadingAnchor.constraint(equalTo: hardImageView.leadingAnchor),
            hardButton.trailingAnchor.constraint(equalTo: hardImageView.trailingAnchor),
        ])
    }
}

extension UIButton {
    convenience init(text: String) {
        self.init(type: .system)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        self.tintColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIImageView {
    convenience init(imageName: String) {
        self.init()
        self.image = UIImage(named: imageName)
        self.contentMode = .scaleAspectFit
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
