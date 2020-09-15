//
//  ViewController.swift
//  Calculator
//
//  Created by Tomasz Walis-Walisiak on 31/07/2017.
//  Copyright © 2017 Tomasz Walis-Walisiak. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var labelString:String = "0"
    var currentMode:modes = .not_set
    var savedNum:Int = 0
    var lastButtonWasMode:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressPlus(_ sender: Any) {
        changeMode(newMode: .addition)
    }
    
    @IBAction func didPressMinus(_ sender: Any) {
        changeMode(newMode: .substraction)
    }
    
    @IBAction func didPressMultiply(_ sender: Any) {
        changeMode(newMode: .multiplication)
    }
    
    
    @IBAction func didPressEqual(_ sender: Any) {
        
        guard let labelInt:Int = Int(labelString) else{
            return
        }
        if (currentMode == .not_set || lastButtonWasMode) {
            return
        }
        
        if (currentMode == .addition) {
            savedNum += labelInt
        }else if(currentMode == .substraction){
            savedNum -= labelInt
        }else if (currentMode == .multiplication){
            savedNum *= labelInt
        }
        
        currentMode = .not_set
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode =  true
    }
    
    
    @IBAction func didPressClear(_ sender: Any) {
        labelString = "0"
        currentMode = .not_set
        savedNum = 0
        lastButtonWasMode = false
        label.text = "0"
    }
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue:String? = sender.titleLabel?.text
        
        if (lastButtonWasMode){
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString.appending(stringValue!)
        updateText()
        
    }
    
    func updateText() {
        guard let labelInt:Int = Int(labelString) else{
            return
        }
        
        if (currentMode == .not_set){
            savedNum = labelInt
        }
        
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num:NSNumber = NSNumber (value: labelInt)
        label.text = formatter.string(from: num)
        
    
    }
    
    func changeMode(newMode:modes) {
        
        if (savedNum == 0){
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
        
    }


}

