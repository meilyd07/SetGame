//
//  SetViewController.swift
//  SetGame
//
//  Created by Admin on 9/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class SetViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource{
    
    private lazy var game = SetGame()
    
    var timer = Timer()
    var counter:Int = 0 {
        didSet {
            currentTimeLabel.text = NSString(format: "%02d:%02d:%02d", counter/3600,(counter/60)%60,counter%60) as String
        }
    }
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBAction func restart(_ sender: UIButton) {
        
        counter = 0
        game = SetGame()
        countLabel.text = String(game.countOfCardsInDeck)
        
        collectionView?.reloadData()
    }
    
    @objc func updateCounter() {
        counter += 1
    }
    
    
    @IBAction func showSet(_ sender: UIButton) {
        game.unselectAllCards()
        if let indexes = collectionView.indexPathsForSelectedItems {
            indexes.forEach({ collectionView.deselectItem(at: $0, animated: false)})
        }
        
        
        if let setCards = game.indexesOfFirstSet {
            setCards.forEach({
                (collectionView?.cellForItem(at: IndexPath(row: $0, section: 0)) as? CardCollectionViewCell)?.shakeCell()
            })
            counter += 60
        }
        else {
            timer.invalidate()
            let ac = UIAlertController(title: "Result", message: "Set not found.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated:  true)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.cards.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card cell", for: indexPath)
        
        let currentCard = game.cards[indexPath.row]
        
        if let productCardImage = UIImage(named: getImageName(card: currentCard)) {
            if let cell = cell as? CardCollectionViewCell {
                
                switch currentCard.quantity {
                case 1:
                    cell.configure(with: [productCardImage])
                case 2:
                    cell.configure(with: [productCardImage,productCardImage])
                case 3:
                    cell.configure(with: [productCardImage,productCardImage,productCardImage])
                    

                default:
                    fatalError()
                }
            }
            
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let width = (view.frame.size.width - 20) / 3
        let height = width / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
        
        collectionView?.allowsMultipleSelection = true
        countLabel.text = String(game.countOfCardsInDeck)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.updateCounter) , userInfo: nil, repeats: true)

    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cnt = collectionView.indexPathsForSelectedItems?.count
        return (cnt ?? 0) < 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        game.selectCard(index: indexPath.row)
        if game.isSetSelected()
        {
            collectionView.visibleCells.forEach({
                if (($0 as? CardCollectionViewCell)?.isShaking)! {
                    ($0 as? CardCollectionViewCell)?.stopShaking()
                }
            })
            
            //delete from collection view
            if let indexes = collectionView.indexPathsForSelectedItems {
                game.removeSelectedCards()
                collectionView.deleteItems(at: indexes)
            }
            game.loadCardsFromDeck(countCards: 3)
            collectionView.reloadData()
            countLabel.text = String(game.countOfCardsInDeck)
            if game.countOfCardsInDeck < 21 {
                if game.indexesOfFirstSet == nil {
                    timer.invalidate()
                    let ac = UIAlertController(title: "Result", message: "Set not found.", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated:  true)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        game.deselectCard(index: indexPath.row)
    }
    
    private func getImageName(card: Card) -> String {
        var fullName = ""
        switch card.product {
        case Product.apple:
            fullName += "apple"
        case .pepper:
            fullName += "peper"
        case .tomato:
            fullName += "tomato"
        }
        
        switch card.color {
        case ProductColor.green:
            fullName += "Green"
        case .red:
            fullName += "Red"
        case .yellow:
            fullName += "Yellow"
        }
        
        switch card.shading {
        case ProductShading.fill:
            fullName += "Fill"
        case .open:
            fullName += "Open"
        case .striped:
            fullName += "Striped"
        }
        
        return fullName
    }

}
