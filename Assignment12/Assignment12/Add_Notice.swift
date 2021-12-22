
import UIKit

class Add_Notice: UIViewController {

    var notice:Notice?
    
    private let lbltitle : UILabel = {
        let lbl = UILabel()
        lbl.text = "ADD NOTICE"
        lbl.textAlignment = .center
        lbl.font = UIFont(name:"ArialRoundedMTBold", size: 20.0)
        // lbl.textColor = .white
        return lbl
    }()
    private let txttitle : UITextField = {
        let lbl = UITextField()
        //.text = "Notice Title"
        lbl.placeholder = "Notice Title"
        lbl.textAlignment = .center
        lbl.borderStyle = UITextField.BorderStyle.roundedRect
        lbl.font = UIFont(name:"ArialRoundedMTBold", size: 15.0)
        //lbl.textColor = .white
        return lbl
    }()
    
    private let txtbody : UITextView = {
        let txt = UITextView()
        txt.layer.cornerRadius = 20
        //txt.layer.backgroundColor = UIColor.gray.cgColor
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.gray.cgColor
        return txt
    }()
    
    
    
    private let btnsave:UIButton={
        let btn1 = UIButton()
        btn1.setTitle("SAVE", for: .normal)
        btn1.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        btn1.layer.cornerRadius = 10
        btn1.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        return btn1
        
    }()
    
    @objc public func saveNote()
    {
        let  title = txttitle.text!
        let body = txtbody.text!
        
        if let nt = notice {
            CoreDataHandler1.shared.update(nt: nt, nTitle: title, nBody: body) {
                print("updated")
            }

        }
        else
        {
            CoreDataHandler1.shared.insert(nTitle: title, nBody: body)
            {
                print("Inserted")
            }
        }
        
    }
    
    
    private let lblmsg : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .green
        lbl.font = UIFont(name:"ArialRoundedMTBold", size: 18.0)
        //        lbl.textColor = .white
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(lbltitle)
        view.addSubview(txttitle)
        view.addSubview(txtbody)
        view.addSubview(btnsave)
        view.addSubview(lblmsg)
        if let nt = notice {
            txttitle.text = nt.nTitle
            txtbody.text = nt.nBody
            
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lbltitle.frame=CGRect(x: 20, y: 80, width:view.frame.size.width-40, height: 30)
        txttitle.frame = CGRect(x: 20, y: 120, width: view.frame.size.width-40 , height: 30)
        txtbody.frame=CGRect(x: 20, y: 160, width:view.frame.size.width-40, height: 200)
        btnsave.frame = CGRect(x: 120, y: 380, width: 130, height: 40)
        lblmsg.frame = CGRect(x: 120, y: 430, width: view.frame.size.width, height: 40)
    }
    
}
