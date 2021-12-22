

import UIKit

class Add_Student: UIViewController {

    var stud:Student?
    
    private let lblspid : UILabel = {
        let lbl = UILabel()
        lbl.text = "SPID"
        return lbl
    }()
    
    private let txtspid : UITextField = {
        let txt = UITextField()
        txt.placeholder = ""
        txt.borderStyle = UITextField.BorderStyle.roundedRect
        return txt
    }()
    
    private let lblsname : UILabel = {
        let lbl = UILabel()
        lbl.text = "Student Name"
        return lbl
    }()
    
    private let txtsname : UITextField = {
        let txt = UITextField()
        txt.placeholder = ""
        txt.borderStyle = UITextField.BorderStyle.roundedRect
        return txt
    }()
    
    private let lbldob : UILabel = {
        let lbl = UILabel()
        lbl.text = "Date Of Birth"
        return lbl
    }()
    private let dob : UIDatePicker = {
        let db = UIDatePicker()
        db.timeZone = NSTimeZone.local
        db.backgroundColor = UIColor.white
        db.datePickerMode = UIDatePicker.Mode.date
        //db.addTarget(self, action: #selector(), for: .valueChanged)
        return db
    }()
    
    
    
    private let mysegment : UISegmentedControl = {
        let sg = UISegmentedControl()
        sg.insertSegment(withTitle: "MALE", at: 1, animated: false)
        sg.insertSegment(withTitle: "FEMALE", at: 2, animated: false)
        sg.insertSegment(withTitle: "OTHER", at: 3, animated: false)
        sg.selectedSegmentIndex = 1
        return sg
    }()
    
    
    private let lblclass : UILabel = {
        let lbl = UILabel()
        lbl.text = "Class Name"
        return lbl
    }()
    
    private let txtclass : UITextField = {
        let txt = UITextField()
        txt.placeholder = ""
        txt.borderStyle = UITextField.BorderStyle.roundedRect
        return txt
    }()
    
    
    private let btnadd:UIButton={
        let btn1 = UIButton()
        btn1.setTitle("Add Student", for: .normal)
        btn1.backgroundColor = #colorLiteral(red: 0.4392156899, green:
            0.01176470611, blue: 0.1921568662, alpha: 1)
        btn1.layer.cornerRadius = 10
        btn1.addTarget(self, action: #selector(AddStud), for: .touchUpInside)
        return btn1
    }()
    private let lblmsg : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .green
        lbl.font = UIFont(name:"ArialRoundedMTBold", size: 18.0)
        //        lbl.textColor = .white
        return lbl
    }()
    
    
    @objc func AddStud()
    {
        
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day,.month,.year], from: self.dob.date)
        let dates = "\(components.day!)-\(components.month!)-\(components.year!)"
        //print(dates)
        
        var gender: String?
        if mysegment.selectedSegmentIndex == 0
        {
            gender = "MALE"
        }
        if mysegment.selectedSegmentIndex == 1
        {
            gender = "FEMALE"
        }
        if mysegment.selectedSegmentIndex == 2
        {
            gender = "OTHER"
        }
        
        print(gender!)
        
        let spid = Int(txtspid.text!)!
        let sname = txtsname.text!
        let classn = txtclass.text!
        
        if let stud = stud {
            CoreDataHandler.shared.update(stud: stud, spid: spid, name: sname, dob: dates, gender: gender!, class_name: classn, password: String(spid))
            {
                    print("Updated")
            }
        }
        else
        {
            CoreDataHandler.shared.insert(spid: spid, name: sname, dob: dates, gender: gender!, class_name: classn, password: String(spid)) {
                print("Inserted")
            }
        }
       
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(lblspid)
        view.addSubview(txtspid)
        view.addSubview(lblsname)
        view.addSubview(txtsname)
        
        view.addSubview(lbldob)
        view.addSubview(dob)
        view.addSubview(mysegment)
        view.addSubview(lblclass)
        view.addSubview(txtclass)
        view.addSubview(btnadd)
        view.addSubview(lblmsg)
        
        if let studs = stud {
            txtspid.text = String(studs.spid)
            txtsname.text = studs.name
            txtclass.text = studs.class_name
            
            
            if(studs.gender == "MALE"){
                mysegment.selectedSegmentIndex = 0
            }
            if(studs.gender == "FEMALE"){
                mysegment.selectedSegmentIndex = 1
            }
            if(studs.gender == "OTHER"){
                mysegment.selectedSegmentIndex = 2
            }
            
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lblspid.frame = CGRect(x: 20, y: 70, width: view.frame.size.width-40, height: 30)
        txtspid.frame = CGRect(x: 20, y: 110, width: view.frame.size.width-40, height: 30)
        
        lblsname.frame = CGRect(x: 20, y: 150, width: view.frame.size.width-40, height: 30)
        txtsname.frame = CGRect(x: 20, y: 190, width: view.frame.size.width-40, height: 30)
        
        lbldob.frame = CGRect(x: 20, y: 230, width: view.frame.size.width-40, height: 30)
        dob.frame = CGRect(x: 20, y: 270, width: view.frame.size.width-40, height: 50)
        
        mysegment.frame = CGRect(x: 20, y: 330, width: view.frame.size.width-40, height: 40)
        
        lblclass.frame = CGRect(x: 20, y: 380, width: view.frame.size.width-40, height: 30)
        txtclass.frame = CGRect(x: 20, y: 420, width: view.frame.size.width-40, height: 30)
        
        btnadd.frame = CGRect(x: 20, y: 470, width: view.frame.size.width-40, height: 40)
        lblmsg.frame = CGRect(x: 40, y: 520, width: view.frame.size.width-40, height: 40)
        
    }

}
