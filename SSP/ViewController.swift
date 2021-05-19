//
//  ViewController.swift
//  SSP
//
//  Created by Itsuki Aoyagi on 2021/05/19.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cpuHandImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    private var cpuHand: Hand? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doStone(_ sender: Any) {
        doJanken(userHand: .Stone)
    }
    
    @IBAction func doScissors(_ sender: Any) {
        doJanken(userHand: .Scissors)
    }
    
    @IBAction func doPaper(_ sender: Any) {
        doJanken(userHand: .Paper)
    }
    
    private func doJanken(userHand: Hand) {
        var cpuNewHand: Hand
        repeat {
            cpuNewHand = Hand.getSample()
        } while cpuNewHand == cpuHand
        cpuHand = cpuNewHand
        
        var result: Result = .Draw
        switch cpuHand {
        case .Stone:
            cpuHandImageView.image = UIImage(named: "Stone")
            
            switch userHand {
            case .Stone: result = .Draw
            case .Scissors: result = .Lose
            case .Paper: result = .Win
            }
        case .Scissors:
            cpuHandImageView.image = UIImage(named: "Scissors")
            
            switch userHand {
            case .Stone: result = .Win
            case .Scissors: result = .Draw
            case .Paper: result = .Lose
            }
        case .Paper:
            cpuHandImageView.image = UIImage(named: "Paper")
            
            switch userHand {
            case .Stone: result = .Lose
            case .Scissors: result = .Win
            case .Paper: result = .Lose
            }
        default: break
        }
        
        resultLabel.text = "あなたは\(userHand.rawValue)を出して\(result.rawValue)でした"
    }
    
    enum Hand: String, CaseIterable, Sampling {
        case Stone = "グー"
        case Scissors = "チョキ"
        case Paper = "パー"
    }
    
    enum Result: String {
        case Win = "勝ち"
        case Lose = "負け"
        case Draw = "あいこ"
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
