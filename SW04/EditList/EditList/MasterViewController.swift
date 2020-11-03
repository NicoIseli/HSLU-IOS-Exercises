//
//  MasterViewController.swift
//  EditList
//
//  Created by nico on 06.10.20.
//

import UIKit

class MasterViewController: UITableViewController {
    
    let memberList : [Person] = DataProvider.createDataProvider().memberPersons
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
            super.viewWillAppear(animated)
            // reload the data of the table
            self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memberList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgrammerCell", for: indexPath)
        cell.textLabel?.text = "\(memberList[indexPath.row].firstName) \(memberList[indexPath.row].lastName)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "MasterView"
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let indexPath = self.tableView.indexPathForSelectedRow!
        
        
        if segue.identifier == "detail", let detailViewController = segue.destination as? DetailViewController{
            detailViewController.person = memberList[indexPath.row]
        }
    }
}
