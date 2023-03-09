//
//  ViewController.swift
//  Scrolll
//
//  Created by Dmitiy Myachin on 07.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var rec: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemCyan
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var slider: UISlider = {
        let view = UISlider()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.minimumValue = 0
        view.maximumValue = 1
        view.isContinuous = true
        view.tintColor = .systemCyan
        view.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        view.addTarget(self, action: #selector(self.setSliderFull(_:)), for: [.touchUpInside, .touchUpOutside])
        return view
    }()
    
    lazy var holder: UIView = {
        let view = UIView()
        view.backgroundColor = .systemMint.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.2, curve: .linear)
    }()
    private var initialFrame: CGRect?
    
    var sliderState: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        view.backgroundColor = .white
        
        view.layoutMargins = UIEdgeInsets(top: self.view.layoutMargins.top,
                                              left: 20,
                                              bottom: self.view.layoutMargins.bottom,
                                              right: 20)
        
//        slider.layoutMargins = UIEdgeInsets(top: self.view.layoutMargins.top,
//                                              left: 20,
//                                              bottom: self.view.layoutMargins.bottom,
//                                              right: 20)
        
        holder.addSubview(rec)
        
        view.addSubview(holder)
        view.addSubview(slider)
        
        NSLayoutConstraint.activate([
            holder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            holder.heightAnchor.constraint(equalToConstant: 150),
            holder.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            holder.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            rec.centerYAnchor.constraint(equalTo: holder.centerYAnchor),
            rec.leadingAnchor.constraint(equalTo: holder.leadingAnchor),
            rec.widthAnchor.constraint(equalToConstant: 100),
            rec.heightAnchor.constraint(equalToConstant: 100),
            
            slider.topAnchor.constraint(equalTo: holder.bottomAnchor, constant: 10),
            slider.heightAnchor.constraint(equalToConstant: 20),
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        rec.transform = CGAffineTransform(rotationAngle: .pi/2 * CGFloat(slider.value)).scaledBy(x: 1 + 0.5 * CGFloat(slider.value), y: 1 + 0.5 * CGFloat(slider.value))
//        rec.center.x = (self.holder.frame.size.width  - (self.rec.frame.width)) * CGFloat(slider.value) + self.rec.frame.width / 2
//    }
    
    @objc func setSliderFull(_ sender: UISlider!){
        self.slider.setValue(1.0, animated: true)
        self.sliderValueDidChange(self.slider)
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider!){
        animator.addAnimations { [unowned self, rec] in
            rec.transform = CGAffineTransform(rotationAngle: .pi/2 * CGFloat(sender.value)).scaledBy(x: 1 + 0.5 * CGFloat(sender.value), y: 1 + 0.5 * CGFloat(sender.value))
            rec.center.x = (self.holder.frame.size.width  - (self.rec.frame.width)) * CGFloat(sender.value) + self.rec.frame.width / 2
        }
        
        animator.startAnimation()
    }
}

