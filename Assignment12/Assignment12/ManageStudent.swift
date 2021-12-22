
import UIKit

class ManageStudent: UIViewController {
    
    private var StudArray = [Student]()
    
    private let StudTableView = UITableView()
    
    
    let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleadd))
    
    @objc func handleadd()
    {
        let vc = Add_Student()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        StudArray = CoreDataHandler.shared.fetch()
        StudTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Students"
        
        view.addSubview(StudTableView)
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewEmployee))
        navigationItem.setRightBarButton(addItem, animated: true)
        
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        StudTableView.frame = view.bounds
    }
    
    @objc private func addNewEmployee() {
        let vc = Add_Student()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ManageStudent: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        StudTableView.register(UITableViewCell.self, forCellReuseIdentifier: "stud")
        StudTableView.delegate = self
        StudTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "stud", for: indexPath)
        let stud = StudArray[indexPath.row]
        cell.textLabel?.text = "\(stud.name!) \t | \t \(stud.gender!) \t | \(stud.spid) \t | \(stud.password!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = Add_Student()
        vc.stud = StudArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let stud = StudArray[indexPath.row]
        CoreDataHandler.shared.delete(stud: stud){
            self.StudArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

        }
        
    }
}
