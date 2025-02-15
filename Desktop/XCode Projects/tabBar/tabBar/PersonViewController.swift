//
//  PersonViewController.swift
//  tabBar
//
//  Created by Mikhail on 15.02.2025.
//

import UIKit

class PersonViewController: UIViewController {
    
    @IBOutlet weak var nameTextLabel: UITextField!
    
    @IBOutlet weak var surnameTextLabel: UITextField!
    
    @IBOutlet weak var numberTextLabel: UITextField!
    
  
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    var indexOfPath: Int?
    var person = Person(name: "", surname: "", number: "")
    
    
    override func viewDidLoad() {
        nameTextLabel.text = person.name
        surnameTextLabel.text = person.surname
        numberTextLabel.text = person.number
    }

    
    @IBAction func editPerson(_ sender: Any) {
        guard let updatedName = nameTextLabel.text,
              let updatedSurname = surnameTextLabel.text,
              let updatedNumber = numberTextLabel.text,
              let index = indexOfPath else { return }
        
        let editedPerson = Person(name: updatedName, surname: updatedSurname, number: updatedNumber)
        
        // Загружаем текущий массив людей из UserDefaults
        if let savedData = UserDefaults.standard.data(forKey: "person"),
           var peopleArray = try? JSONDecoder().decode([Person].self, from: savedData) {
            
            // Обновляем нужного человека
            peopleArray[index] = editedPerson
            
            // Сохраняем обновленный массив обратно в UserDefaults
            if let encodedData = try? JSONEncoder().encode(peopleArray) {
                UserDefaults.standard.set(encodedData, forKey: "person")
            }
        }
        
        navigationController?.popViewController(animated: true) // Возвращаемся назад
    }
}

    

