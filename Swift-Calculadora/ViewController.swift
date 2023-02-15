//
//  ViewController.swift
//  Swift-Calculadora
//
//  Created by Usuario invitado on 1/2/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let MAX_NBR_SIZE = 10;
    private let DOUBLE_OPERATIONS: [String: (Double, Double) -> Double] = [
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
    private var screenNbr: String = "0";
    private var total: Double? = nil; // Nil needed to handle Error
    private var operationSelected: UIButton? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onBtnClicked(_ sender: UIButton) {
        sender.shine()
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
        // If btn is active selected, set the total to current nbr?
        
        // Appends to the right the given character
        if screenNbr.count >= MAX_NBR_SIZE {
            return
        }
        if c == "," && screenNbr.contains(c) { // Check , already there
            return
        }
        
        if screenNbr == "-0" && c != "," {
            screenNbr = "-" + c;
        }
        else if screenNbr == "0" {
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
        if screenNbr.count == 1 || (screenNbr.count == 2 && screenNbr.starts(with: "-")) {
            screenNbr = "0"
        }
        else {
            screenNbr.removeLast()
        }
        if operationSelected != nil {
            operationSelected?.unselect()
        }
        operationSelected = nil;
        updateUI()
    }
    
    @IBAction func onClearClicked(_ sender: UIButton) {
        total = nil;
        screenNbr = "0";
        if operationSelected != nil {
            operationSelected?.unselect()
        }
        operationSelected = nil;
        updateUI();
    }
    
    func updateUI() {
        if operationSelected != nil {
            operationSelected?.unselect();
        }
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
        
        let operation: String? = operationSelected!.titleLabel?.text; // Not nil
        
        let n1: Double;
        let n2: Double = Double(screenNbr)!;
        if total == nil {
            n1 = n2;
        }
        else {
            n1 = total!;
        }
        
        let r = DOUBLE_OPERATIONS[operation!]!(n1, n2);
        screenNbr = String(format: "%f", r);
        
        updateUI();
    }
    
    @IBAction func onOperationClicked(_ sender: UIButton) {
        /*if operationSelected != nil && prevNbr != nil {
            operate();
        }*/ // TODO restore
        
        if operationSelected != nil {
            operationSelected?.unselect()
        }
        sender.select()

        operationSelected = sender;
    }
}
