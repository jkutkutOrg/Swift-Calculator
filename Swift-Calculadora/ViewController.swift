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
    ];
    private func strToDouble(_ str: String) -> Double {
        /*let f = NumberFormatter();
        f.groupingSeparator = ""
        f.decimalSeparator = Locale.current.decimalSeparator;
        f.numberStyle = .decimal
        f.maximumIntegerDigits = 15;
        f.minimumFractionDigits = 0
        f.maximumFractionDigits = 15;
        return f;
    }();*/
        let nbr = str.replacingOccurrences(of: ",", with: ".");
        if let d: Double = Double(nbr) {
            return d;
        }
        return Double.infinity;
    }
    private let doubleToStr: NumberFormatter = {
        let f = NumberFormatter();
        f.groupingSeparator = Locale.current.groupingSeparator;
        f.decimalSeparator = ",";
        f.numberStyle = .decimal;
        f.maximumIntegerDigits = 10;
        f.minimumFractionDigits = 0;
        f.maximumFractionDigits = 9;
        return f;
    }();
    private let doubleToScinetificStr: NumberFormatter = {
        let f = NumberFormatter();
        f.numberStyle = .scientific;
        f.maximumFractionDigits = 3;
        f.exponentSymbol = "e";
        return f;
    }();
        
    
    @IBOutlet weak var labelNbr: UITextField!;
    private var screenNbr: String = "0";
    private var total: Double? = nil; // Nil needed to handle Error
    private var operationSelected: UIButton? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    @IBAction func onBtnClicked(_ sender: UIButton) {
        sender.shine();
    }

    @IBAction func onNumberClicked(_ sender: UIButton) {
        let nbr: String? = sender.titleLabel?.text; // Not nil
        append(nbr!);
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
        if operationSelected != nil && operationSelected!.isSelected() {
            // If btn is active selected, set the total to current nbr?
            total = strToDouble(screenNbr);
            screenNbr = "0";
        }
        
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
        if screenNbr == "inf" {
            screenNbr = "1";
        }
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
        if ["Error", "-inf", "inf", "NaN", "+∞", "-∞"].contains(screenNbr) {
            labelNbr.text = "Error"
            screenNbr = "inf"
        }
        else {
            labelNbr.text = screenNbr;
        }
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
        let n2: Double = strToDouble(screenNbr);
        if total == nil {
            n1 = n2;
        }
        else {
            n1 = total!;
        }
        
        let r = DOUBLE_OPERATIONS[operation!]!(n1, n2);
        let nbrObj = NSNumber(value: r);
        var nbr: String = doubleToStr.string(from: nbrObj)!;
        if nbr.count > MAX_NBR_SIZE {
            nbr = doubleToScinetificStr.string(from: nbrObj)!;
        }
        
        screenNbr = nbr;
        if operationSelected!.isSelected() {
            operationSelected?.unselect();
        }
        operationSelected = nil;
        updateUI();
    }
    
    @IBAction func onOperationClicked(_ sender: UIButton) {
        if operationSelected != nil && total != nil {
            operate();
        }
        
        if operationSelected != nil {
            operationSelected?.unselect()
        }
        sender.select()

        operationSelected = sender;
    }
}
