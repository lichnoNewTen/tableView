//
//  ViewController.swift
//  timerDate
//
//  Created by Mikhail on 18.02.2025.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var startDate: UIDatePicker!
    
    @IBOutlet weak var endDate: UIDatePicker!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        startDate.contentHorizontalAlignment = .center
        
        endDate.contentHorizontalAlignment = .center
        
        // Обнуляем секунды в обоих пикерах
            if let startPicker = startDate, let endPicker = endDate {
                startPicker.date = resetSeconds(for: startPicker.date)
                endPicker.date = resetSeconds(for: endPicker.date)
            }
        
    }
    
    /// Функция для сброса секунд у даты
    func resetSeconds(for date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date) // Исключаем секунды
        return calendar.date(from: components) ?? date // Создаём новую дату без секунд
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SecondVC" {
            if let vc = segue.destination as? SecondViewController {
                
                
                    vc.receivedEndDate = endDate.date
                    vc.receivedStartDate = startDate.date
                
                
                vc.time = Double(textField.text!) ?? 0
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy HH:mm" // Формат даты
                let startDateString = dateFormatter.string(from: startDate.date)
                vc.startDateText = startDateString
                let endDateString = dateFormatter.string(from: endDate.date)
                vc.endDateText = endDateString
            }
        }
    }


}

