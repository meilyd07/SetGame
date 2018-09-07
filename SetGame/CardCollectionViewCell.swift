//
//  CardCollectionViewCell.swift
//  SetGame
//
//  Created by Admin on 9/2/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    var isShaking = false
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    override var isSelected: Bool {
        didSet
        {
            guard oldValue != isSelected else { return }
            if isSelected
            {
                contentView.layer.borderWidth = 2
                contentView.layer.borderColor = UIColor.red.cgColor
            }
            else
            {
                contentView.layer.borderWidth = 0
             }
        }
    }
    
    // This function shake the collection view cells
    func shakeCell() {
        let shakeAnim = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnim.duration = 0.05
        shakeAnim.repeatCount = 2
        shakeAnim.autoreverses = true
        let startAngle: Float = (-2) * 3.14159/180
        let stopAngle = -startAngle
        shakeAnim.fromValue = NSNumber(value: startAngle)
        shakeAnim.toValue = NSNumber(value: 3 * stopAngle)
        shakeAnim.autoreverses = true
        shakeAnim.duration = 0.2
        shakeAnim.repeatCount = 10000
        shakeAnim.timeOffset = 290 * drand48()
        
        //Create layer, then add animation to the element's layer
        let layer: CALayer = self.layer
        layer.add(shakeAnim, forKey:"shaking")
        isShaking = true
        
    }
    
    func stopShaking() {
        let layer: CALayer = self.layer
        layer.removeAnimation(forKey: "shaking")
        isShaking = false
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        let views = stackView.arrangedSubviews
        views.forEach(stackView.removeArrangedSubview)
        views.forEach { $0.removeFromSuperview() }
        
    }
    
    func configure(with images: [UIImage])
    {
        images
            .map(UIImageView.init(image:))
            .forEach(stackView.addArrangedSubview)
        
        guard let view = stackView.arrangedSubviews.first else { return }
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 27)
        ])
        
        
    }
    
}
