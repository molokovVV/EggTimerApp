//
//  ViewController.swift
//  EggTimerApp
//
//  Created by Виталик Молоков on 05.02.2024.
//

import UIKit

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
    
    private lazy var softImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "soft_egg")
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var softButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Soft", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.tintColor = .white
        button.addTarget(self, action: #selector(eggsButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var mediumImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "medium_egg")
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var mediumButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Medium", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.tintColor = .white
        button.addTarget(self, action: #selector(eggsButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var hardImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "hard_egg")
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var hardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hard", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.tintColor = .white
        button.addTarget(self, action: #selector(eggsButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var timerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

// MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setupConstraints()
    }
    
    @objc private func eggsButtonTapped(_ sender: UIButton) {
        
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

