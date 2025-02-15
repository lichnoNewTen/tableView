////
////  ViewController.swift
////  tabBar
////
////  Created by Mikhail on 13.02.2025.
////
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    
    // Функция для отображения всплывающего окна
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    var allPersons: [Person] = [] // Массив для хранения контактов
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPeople() // Загружаем сохраненные контакты при запуске
    }

    @IBAction func addPerson(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
              let surname = surnameTextField.text, !surname.isEmpty,
              let number = numberTextField.text, !number.isEmpty else {
            showAlert(title: "Ошибка", message: "Заполните все поля!")
            return
        }
        
        let newPerson = Person(name: name, surname: surname, number: number)
        
        // Добавляем нового человека в массив
        allPersons.append(newPerson)
        
        // Сохраняем массив в UserDefaults
        savePeople()
        
        print("Человек добавлен: \(newPerson)")
    }
    
    // Загружаем данные из UserDefaults
    private func loadPeople() {
        if let data = UserDefaults.standard.data(forKey: "person") {
            let decoder = JSONDecoder()
            if let decodedPeople = try? decoder.decode([Person].self, from: data) {
                allPersons = decodedPeople
                print("Загруженные данные: \(allPersons)")
            }
        }
    }
    
    // Сохраняем массив в UserDefaults
    private func savePeople() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(allPersons) {
            UserDefaults.standard.set(encodedData, forKey: "person")
            print("Сохранено \(allPersons.count) человек(а)")
        }
    }
}
