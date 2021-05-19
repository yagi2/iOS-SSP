//
//  ViewController.swift
//  SSP
//
//  Created by Itsuki Aoyagi on 2021/05/19.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    private var resultHand: Hand? = .Paper
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func shuffleAction(_ sender: Any) {
        var newHand: Hand
        repeat {
            newHand = Hand.getSample()
        } while newHand == resultHand
        resultHand = newHand
        
        switch resultHand {
        case .Stone:
            resultLabel.text = "グー"
            resultImageView.image = UIImage(named: "Stone")
        case .Scissors:
            resultLabel.text = "チョキ"
            resultImageView.image = UIImage(named: "Scissors")
        case .Paper:
            resultLabel.text = "パー"
            resultImageView.image = UIImage(named: "Paper")
        default: break
        }
    }
    
    enum Hand: CaseIterable, Sampling {
        case Stone
        case Scissors
        case Paper
    }
}

protocol Sampling {}
extension Sampling where Self: CaseIterable {
    static func getSample() -> Self {
        let all = self.allCases as! [Self]
        let index = Int.random(in: 0...all.count - 1)
        return all[index]
    }
}
