//
//  ViewController.swift
//  Swift-Calculadora
//
//  Created by Usuario invitado on 1/2/23.
//

import UIKit

extension UIButton {
    open override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .lightGray : .white
        }
    }
}

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
    
    @IBAction func onSignClicked(_ sender: UIButton) {
        let actualSign = String(actualNbr.prefix(1));
        if actualSign == "-" {
            actualNbr.removeFirst(1)
        }
        else {
            actualNbr = "-" + actualNbr
        }
        updateUI()
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
        if actualNbr.count == 1 || (actualNbr.count == 2 && actualNbr.starts(with: "-")) {
            actualNbr = "0"
        }
        else {
            actualNbr.removeLast()
        }
        updateUI()
    }
    
    @IBAction func onClearClicked(_ sender: UIButton) {
        prevNbr = nil;
        actualNbr = "0";
        updateUI();
    }
    
    func updateUI() {
        // TODO dot format?
        labelNbr.text = actualNbr;
    }
    
    // Animations
    @IBAction func btnTapped(_ sender: UIButton) {
        let brightness = 50.0;
        
        UIView.animate(withDuration: 0.15, animations: {
            // sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1);
            // sender.alpha = 0.8;
            /*if let bgColorObj = sender.layer.backgroundColor {
                let bgColor = bgColorObj.components!;
                //let lighterColor = UIColor(hue: bgColor[0], saturation: bgColor[1], brightness: bgColor[2] + brightness, alpha: bgColor[3]);
                let lighterColor = UIColor(red: bgColor[0] + brightness, green: bgColor[1] + brightness, blue: bgColor[2] + brightness, alpha: bgColor[3])
                sender.layer.backgroundColor = lighterColor.cgColor;
                sender.transform = CGAffineTransform(scaleX: 0, y: 0)
            }*/
            //sender.backgroundColor = .white
            //sender.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
            
            
        }) { (finished) in
            UIView.animate(withDuration: 0.1, animations: {
                //sender.backgroundColor = .clear
            })
        }
    }
    
}

