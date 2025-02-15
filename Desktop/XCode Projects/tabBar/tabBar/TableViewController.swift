//
//  TableViewController.swift
//  tabBar
//
//  Created by Mikhail on 13.02.2025.
//

import UIKit

class TableViewController: UITableViewController {
    
          
    
        var arrayPerson = [Person(name: "О себе", surname: "", number: "87078198899")]
    
        
    // Загружаем данные из UserDefaults
    private func loadPeople() {
        if let data = UserDefaults.standard.data(forKey: "person") {
            let decoder = JSONDecoder()
            if let decodedPeople = try? decoder.decode([Person].self, from: data) {
                arrayPerson = decodedPeople
                print("Загруженные данные: \(arrayPerson.count) человек(а)")
            }
        }
    }
    
    // Сохраняем массив в UserDefaults
    private func savePeople() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(arrayPerson) {
            UserDefaults.standard.set(encodedData, forKey: "person")
            print("Сохранено \(arrayPerson.count) человек(а)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let personListArray = UserDefaults.standard.data(forKey: "person") {
            let decoder = JSONDecoder()
            if let decodedPeople = try? decoder.decode([Person].self, from: personListArray) {
                arrayPerson = decodedPeople
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let personListArray = UserDefaults.standard.data(forKey: "person") {
            let decoder = JSONDecoder()
            if let decodedPeople = try? decoder.decode([Person].self, from: personListArray) {
                arrayPerson = decodedPeople
            }
        }
                tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // Функция определения количества строк
        return arrayPerson.count
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let person = arrayPerson[indexPath.row]
//        cell.textLabel?.
        cell.textLabel?.text = "\(person.name) \(person.surname)"
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18) // Жирный шрифт, размер 18
        cell.textLabel?.textColor = .black // Цвет текста (можно поменять)
        
        cell.detailTextLabel?.text = person.number
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16) // Обычный шрифт, размер 16
        cell.detailTextLabel?.textColor = .darkGray // Серый цвет для номера
        
                // Configure the cell...
        
                return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "EditPeople") as! PersonViewController
        
        vc.person = arrayPerson[indexPath.row]
        vc.indexOfPath = indexPath.row
        
        navigationController?.show(vc, sender: self)
    }
  
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            arrayPerson.remove(at: indexPath.row)
            savePeople()
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
            
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
