

import UIKit

class ManageNoticeBoard: UIViewController {

    private var noticeArray = [Notice]()
    
    private let NoticeTable = UITableView()
    
    
    let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleadd))
    
    @objc func handleadd()
    {
        print("hanldeadd")
        let vc = Add_Notice()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noticeArray = CoreDataHandler1.shared.fetch()
        NoticeTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "NOTICE"
        
        view.addSubview(NoticeTable)
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewEmployee))
        navigationItem.setRightBarButton(addItem, animated: true)
        
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NoticeTable.frame = view.bounds
    }
    
    @objc private func addNewEmployee() {
        print("addemp")
        let vc = Add_Notice()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ManageNoticeBoard: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        NoticeTable.register(UITableViewCell.self, forCellReuseIdentifier: "notice")
        NoticeTable.delegate = self
        NoticeTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notice", for: indexPath)
        let nt = noticeArray[indexPath.row]
        cell.textLabel?.text = "\(nt.nTitle!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = Add_Notice()
        vc.notice = noticeArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let nt = noticeArray[indexPath.row]
        CoreDataHandler1.shared.delete(nt: nt){
            self.noticeArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

        }

    }
}
