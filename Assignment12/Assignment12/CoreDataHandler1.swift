

import UIKit
import CoreData
import Foundation

class CoreDataHandler1
{
    static let shared = CoreDataHandler1()
    
    
    let appDelegate  = UIApplication.shared.delegate as! AppDelegate
    let manageObjectContext : NSManagedObjectContext?
    
    private  init()
    {
        manageObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func save()
    {
        appDelegate.saveContext()
    }
    
    func insert(nTitle : String ,nBody : String ,completion: @escaping () -> Void) {
        let nt = Notice(context: manageObjectContext!)
        nt.nTitle = nTitle
        nt.nBody = nBody
        save()
        completion()
    }
    func update(nt: Notice, nTitle : String ,nBody : String ,completion: @escaping () -> Void)
    {
        nt.nTitle = nTitle
        nt.nBody = nBody
        save()
        completion()
    }
    
    func delete(nt:Notice, completion: @escaping () -> Void)
    {
        manageObjectContext!.delete(nt)
        save()
        completion()
    }
    
    func fetch() -> [Notice]
    {
        let fetchRequest:NSFetchRequest<Notice> = Notice.fetchRequest()
        do{
            let ntarray = try manageObjectContext?.fetch(fetchRequest)
            return ntarray!
        }catch{
            print(error)
            return [Notice]()
        }
    }
    
  
}
