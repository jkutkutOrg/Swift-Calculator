//
//  ViewController.swift
//  Swift-Calculadora
//
//  Created by Usuario invitado on 1/2/23.
//

import UIKit

class ViewController: UIViewController {
    
    let DOUBLE_OPERATIONS: [String: (Double, Double) -> Double] = [
        "%": { (_ a, _ b) in
            return a.truncatingRemainder(dividingBy: b);
        },
        "÷": { (_ a, _ b) in
            return a / b;
        },
        "+": { (_ a, _ b) in
            return a + b;
        },
        "-": { (_ a, _ b) in
            return a - b;
        },
        "x": { (_ a, _ b) in
            return a * b;
        }
    ]
    
    @IBOutlet weak var labelNbr: UITextField!
    var screenNbr: String = "0";
    var total: Double? = nil; // Nil needed to handle Error
    
    // var isOperationSelected: Bool = false; // On screen
    var operationSelected: String? = nil;
    
    let MAX_NBR_SIZE = 10;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func onNumberClicked(_ sender: UIButton) {
        let nbr: String? = sender.titleLabel?.text; // Not nil
        append(nbr!)
        updateUI();
    }
    
    @IBAction func onCommaClicked(_ sender: UIButton) {
        let nbr: String? = sender.titleLabel?.text; // Not nil
        append(nbr!)
        updateUI();
    }
    
    @IBAction func onSignClicked(_ sender: UIButton) {
        let actualSign = String(screenNbr.prefix(1));
        if actualSign == "-" {
            screenNbr.removeFirst(1)
        }
        else {
            screenNbr = "-" + screenNbr
        }
        updateUI()
    }
    
    func append(_ c: String) {
        // Appends to the right the given character
        if screenNbr.count >= MAX_NBR_SIZE {
            return
        }
        if c == "," && screenNbr.contains(c) { // Check , already there
            return
        }
        
        if screenNbr == "0" {
            if c == "," {
                screenNbr += c
            }
            else {
                screenNbr = c
            }
        }
        else {
            screenNbr += c
        }
    }
    
    @IBAction func onDeleteClicked(_ sender: UIButton) {
        // TODO check select operation and then delete
        if screenNbr.count == 1 || (screenNbr.count == 2 && screenNbr.starts(with: "-")) {
            screenNbr = "0"
        }
        else {
            screenNbr.removeLast()
        }
        updateUI()
    }
    
    @IBAction func onClearClicked(_ sender: UIButton) {
        total = nil;
        screenNbr = "0";
        
        operationSelected = nil;
        //isOperationSelected = false; // TODO remove highlight of btn
        updateUI();
    }
    
    func updateUI() {
        // TODO remove selected operation (it will be the valid one)
        labelNbr.text = screenNbr; // TODO dot format?
    }
    
    // Operations
    @IBAction func onEqClicked(_ sender: Any) {
        operate()
    }

    func operate() {
        /*
         Cases
         - Prev is nil, operation is nil -> Do nothing
         - Prev is nil, operation is not nil -> Do the operation with actual twice
         - Prev is not nil, operation is nil -> ! not possible
         - Prev is not nil, operation is not nil -> Operate normally
         */
        if operationSelected == nil {
            return;
        }
        
        /*if prevNbr == nil {
            prevNbr = actualNbr;
        }
        else {
            // TODO
        }
        
        let n1: Double = Double(actualNbr)!;
        let n2: Double = Double(prevNbr!)!;
        
        let r = DOUBLE_OPERATIONS[operationSelected!]!(n1, n2);
        actualNbr = String(format: "%f", r);*/
        
        updateUI();
    }
    
    @IBAction func onOperationClicked(_ sender: UIButton) {
        let op: String? = sender.titleLabel?.text; // Not nil
        
        /*if operationSelected != nil && prevNbr != nil {
            operate();
        }*/ // TODO restore
        
        /*if isOperationSelected {
            // TODO hide the selected
            // TODO select the button
        }
        else {
            // TODO select the button
            isOperationSelected = true;
        }*/
        
        operationSelected = op;
    }
}
