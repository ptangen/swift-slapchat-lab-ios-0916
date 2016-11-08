//
//  TableViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class TableViewController: UITableViewController {
  

  @IBOutlet weak var tableView3: UITableView!

  
  let store = DataStore.sharedInstance
  var messagesFromCD = [Message]()

  override func viewDidLoad() {
      super.viewDidLoad()
      self.tableView3.delegate = self
      self.tableView3.dataSource = self

        
      // Uncomment the following line to preserve selection between presentations
      //self.clearsSelectionOnViewWillAppear = false

      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      //self.navigationItem.rightBarButtonItem = self.editButtonItem()
      
      print("generateTestData()")
      self.generateTestData()
  }

  
  func generateTestData(){
    let messagesToInsert = ["Here is message 1.","Here is message 2.","Here is message 3."]
    
    let managedContext = store.persistentContainer.viewContext
    let entity =  NSEntityDescription.entity(forEntityName: "Message", in: managedContext)
    
    if let unwrappedEntity = entity {
  
      let messageToSave1 = NSManagedObject(entity: unwrappedEntity, insertInto: managedContext) as! Message
      messageToSave1.content = messagesToInsert[0]
      messageToSave1.createdAt = NSDate()
      print("save: \(messageToSave1.content!)")
      
      let messageToSave2 = NSManagedObject(entity: unwrappedEntity, insertInto: managedContext) as! Message
      messageToSave2.content = messagesToInsert[1]
      messageToSave2.createdAt = NSDate()
      print("save: \(messageToSave2.content!)")
      
      let messageToSave3 = NSManagedObject(entity: unwrappedEntity, insertInto: managedContext) as! Message
      messageToSave3.content = messagesToInsert[2]
      messageToSave3.createdAt = NSDate()
      print("save: \(messageToSave3.content!)")
      
      store.saveContext()
    }
    self.fetchData()
  }
  
  func fetchData() {
    let managedContext = store.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
    do {
      self.messagesFromCD = try managedContext.fetch(fetchRequest)
      dump("self.messagesFromCD: \(self.messagesFromCD)")
      //tableview.reload()
    } catch {
      print("error")
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.messagesFromCD.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
    let itemTitle = self.messagesFromCD[indexPath.row].content
    cell.textLabel?.text = itemTitle // its ok to force unwrap a UI element
    //cell.backgroundColor = UIColor.blue
    return cell
  }


}

