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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func onNumberClicked(_ sender: UIButton) {
        let nbr: String? = sender.titleLabel?.text; // Not nil
        
        if actualNbr == "0" {
            actualNbr = nbr!;
        }
        else {
            actualNbr = actualNbr + nbr!;
        }
        
        labelNbr.text = actualNbr;
    }
    
    @IBAction func onClearClicked(_ sender: UIButton) {
        actualNbr = "0";
        
        labelNbr.text = actualNbr;
    }
    
}

