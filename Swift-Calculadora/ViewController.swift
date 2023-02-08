//
//  ViewController.swift
//  Swift-Calculadora
//
//  Created by Usuario invitado on 1/2/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelNbr: UITextField!
    var actualNbr: String = "0";
    var prevNbr: String? = nil;
    
    let MAX_NBR_SIZE = 9;

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
    
    func append(_ c: String) {
        // Appends to the right the given character
        if actualNbr.count >= MAX_NBR_SIZE {
            return
        }
        if c == "," && actualNbr.contains(c) { // Check , already there
            return
        }
        
        if actualNbr == "0" {
            if c == "," {
                actualNbr += c
            }
            else {
                actualNbr = c
            }
        }
        else {
            actualNbr += c
        }
    }
    
    @IBAction func onDeleteClicked(_ sender: UIButton) {
        if actualNbr.count == 1 {
            actualNbr = "0"
        }
        else {
            actualNbr.removeLast()
        }
        updateUI()
    }
    
    @IBAction func onClearClicked(_ sender: UIButton) {
        actualNbr = "0";
        updateUI();
    }
    
    func updateUI() {
        // TODO dot format?
        labelNbr.text = actualNbr;
    }
}

