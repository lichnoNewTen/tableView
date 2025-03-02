//
//  SecondViewController.swift
//  timerDate
//
//  Created by Mikhail on 18.02.2025.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    var time = 0.0
    var startTime = 0.0
    var timer = Timer()
    var startDateText: String?
    var endDateText: String?
    var receivedStartDate: Date?
    var receivedEndDate: Date?
    var difference = 0
    var destinationText: String?
    
    var startInSecond: Double?
    var endInSecond: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let start = receivedStartDate, let end = receivedEndDate {
            if start < end {
                difference = Int(end.timeIntervalSince(start)) // Разница в секундах
            } else if start > end {
                difference = Int(start.timeIntervalSince(end)) // Если даты перепутаны
                } else {
                difference = 0 // Если даты одинаковые
            }
        }
       
        
        // Пучаем даты в виде секунд начиная с 1970 года
//        let start = receivedStartDate?.timeIntervalSince1970
//        let end = receivedEndDate?.timeIntervalSince1970
//        
        // Получаем разницу в секундах между датами
//        if let start, let end {
//            if start < end {
//                difference = Int(end - start)
//            }
//            if start > end {
//                difference = Int(start - end)
//            }
//        }
                  // ВЫШЕ ТОЖЕ РАБОЧИЙ СПОСОБ ЧЕРЕЗ ПРЕОБРАЗОВАНИЕ В 1970
        
        
        // Преобразовываем разницу обратно в дату
        if difference >= 0 {
            time = Double(difference)
        }
        
        if let startDateText = startDateText {
               startDateLabel.text = startDateText
           }
        if let endDateText = endDateText {
               endDateLabel.text = endDateText
           }
        label.text = timeString(time: time)
    }
    
    //  Конец ViewDidLoad
    
    
    
    
    var oneTimeStart: Double?
    var oneTimeEnd: Double?
    
    func refDestination() {
        
        if startInSecond == nil {
                    startInSecond = receivedStartDate?.timeIntervalSince1970
            oneTimeStart = startInSecond
                }
                if endInSecond == nil {
                    endInSecond = receivedEndDate?.timeIntervalSince1970
                    oneTimeEnd = endInSecond
                }
        
        
        guard let startInSecond = startInSecond, let endInSecond = endInSecond else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm" // Формат даты
        
        
        if startInSecond < endInSecond {
            let startDate = Date(timeIntervalSince1970: startInSecond)
            destinationText = dateFormatter.string(from: startDate) // Назначение
            self.startInSecond! += 0.01
        }
        if startInSecond > endInSecond {
            let endDate = Date(timeIntervalSince1970: endInSecond)
            destinationText = dateFormatter.string(from: endDate) // Назначение
            self.endInSecond! += 0.01
        }
    }

    
    @objc func counTime() {
        if time <= 0 {
            timer.invalidate()
            return
        }
        time -= 0.01
        label.text = timeString(time: time)
        
        refDestination()
         
        countdownLabel.text = destinationText
        
    }
    
    @IBAction func restartTimer(_ sender: Any) {
        timer.invalidate()
        time = Double(difference)
        startInSecond = oneTimeStart
        endInSecond = oneTimeEnd
        
        refDestination()
        
        countdownLabel.text = destinationText
        label.text = timeString(time: time)
    }
    
    @IBAction func startTimer(_ sender: Any) {
        if timer.isValid {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(counTime), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopTimer(_ sender: Any) {
        timer.invalidate()
    }
    
    func timeString(time: Double) -> String {
        print(time)
        let days = Int(time) / 86400
        let hours = Int(time) / 3600 % 24
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time - Double(Int(time))) * 100)
        return String(format: "%02d Day %02d:%02d:%02d.%02d", days, hours, minutes, seconds, milliseconds)
    }
    
}
