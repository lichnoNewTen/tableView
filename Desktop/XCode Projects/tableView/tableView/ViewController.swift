//
//  ViewController.swift
//  tableView
//
//  Created by Mikhail on 11.02.2025.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var surnameLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var person = Person()
    var personInfo = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameLabel.text = person.name
        surnameLabel.text = person.surname
        imageView.image = UIImage(named: person.image)
        infoLabel.text = person.name + " " + person.surname + ". " + personInfo.inf
    
    }


}

