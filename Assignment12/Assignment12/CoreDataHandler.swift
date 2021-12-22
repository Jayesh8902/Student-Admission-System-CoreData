
import UIKit
import CoreData
import Foundation

class CoreDataHandler
{
    static let shared = CoreDataHandler()

    
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
    
    func insert(spid : Int, name:String , dob : String, gender : String,class_name : String,password : String ,completion: @escaping () -> Void) {
        let stud = Student(context: manageObjectContext!)
        stud.spid = Int64(spid)
        stud.name = name
        stud.dob = dob
        stud.gender = gender
        stud.class_name = class_name
        stud.password = password
        save()
        completion()
    }
    func update(stud: Student,spid : Int, name:String , dob : String, gender : String,class_name : String,password : String ,completion: @escaping () -> Void)
    {
        stud.spid = Int64(spid)
        stud.name = name
        stud.dob = dob
        stud.gender = gender
        stud.class_name = class_name
        stud.password = password
        save()
        completion()
    }
    
    func delete(stud:Student, completion: @escaping () -> Void)
    {
        manageObjectContext!.delete(stud)
        save()
        completion()
    }
    
    func fetch() -> [Student]
    {
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        do{
            //fetchRequest.predicate = NSPredicate(format: "class_name == %@","IOS")
            let studarray = try manageObjectContext?.fetch(fetchRequest)
            return studarray!
        }catch{
            print(error)
            return [Student]()
        }
    }
    
    func fetchbyclass(classname : String) -> [Student]
    {
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        do{
            fetchRequest.predicate = NSPredicate(format: "class_name == %@",classname)
            
            
            let studarray = try manageObjectContext?.fetch(fetchRequest)
            return studarray!
        }catch{
            print(error)
            return [Student]()
        }
    }
    
    
    func checkLogin(uname : String,password : String) -> [Student]
    {
        
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        do{
            //fetchRequest.predicate = NSPredicate(format: "spid == %@",uname)
            
            let p1 = NSPredicate(format: "spid == %@",uname)
            let p2 = NSPredicate(format: "password == %@",password)
            
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p1,p2])
            
            let studarray = try manageObjectContext?.fetch(fetchRequest)
            return studarray!
        }catch{
            print(error)
            return [Student]()
        }
    }
    
    
    func fetchprofile(spid : String) -> [Student]
    {
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        do{
            fetchRequest.predicate = NSPredicate(format: "spid == %@",spid)
           
            let studarray = try manageObjectContext?.fetch(fetchRequest)
            return studarray!
        }catch{
            print(error)
            return [Student]()
        }
    }    //multiple predict
    //    let predicate1:NSPredicate = NSPredicate(format: "X == 1")
    //    let predicate2:NSPredicate = NSPredicate(format: "Y == 2")
    //    let predicate:NSPredicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1,predicate2] )
    //

    func changepassword(stud: Student,password : String ,completion: @escaping () -> Void)
    {
        stud.password = password
        save()
        completion()
    }

}
