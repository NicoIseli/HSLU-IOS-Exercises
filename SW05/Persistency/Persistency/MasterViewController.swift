//
//  MasterViewController.swift
//  Persistency
//
//  Created by nico on 13.10.20.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(insertNewObject(_ :)))
        
        self.navigationItem.rightBarButtonItem = addButton
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @objc func insertNewObject(_ sender: AnyObject){
        let context = self.fetchedResultsController.managedObjectContext
        
        let person = Person(context: context)
        person.name = "?"
        
        //SAVE CONTEXT
        do{
            try context.save()
        } catch {
            abort()
        }
        
        let editViewController = self.storyboard?.instantiateViewController(identifier: "EditViewController") as! EditViewController
        editViewController.managedContext = context;
        editViewController.person = person
        self.navigationController?.present(editViewController, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: - Seque
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let person = self.fetchedResultsController.object(at: indexPath) as! Person
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.person = person
                controller.managedContext = self.managedObjectContext
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    
    //MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        self.configureCell(_cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func configureCell(_cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        let object = self.fetchedResultsController.object(at: indexPath) as! NSObject
        _cell.textLabel!.text = (object.value(forKey: "name")! as! NSObject).description
    }
    
    
    
    
    
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<Person>!
     
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<Person>(entityName: "Person")
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [nameSort]
        
        let moc = self.managedObjectContext
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc!, sectionNameKeyPath: nil, cacheName: nil)
        //fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }

}
