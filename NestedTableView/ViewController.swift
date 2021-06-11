//
//  ViewController.swift
//  NestedTableView
//
//  Created by Rahul Ravi Prakash on 10/06/21.
//

import UIKit

class Role {
    let title: String
    let objective: [Objective]
    var isSelected: Bool = false
    
    init(title: String, objective: [Objective], isSelected: Bool = false) {
        self.title = title
        self.objective = objective
        self.isSelected = isSelected
    }
}

class Objective {
    let title: String
    let keyResult: [String]
    var isSelected: Bool = false
    
    init(title: String, keyResult: [String], isSelected: Bool = false) {
        self.title = title
        self.keyResult = keyResult
        self.isSelected = isSelected
    }
}

class ViewController: UIViewController {
    
    private var role = [Role]()
    
    private let table : UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "roleCell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        table.frame = view.bounds
        view.addSubview(table)
        
        role.append(Role(title: "Role 1",
                         objective: [Objective(title: "Objective 1", keyResult: ["KeyResult 1","KeyResult 2","KeyResult 3"]),
                                     Objective(title: "Objective 2", keyResult: ["KeyResult 4","KeyResult 5","KeyResult 6"])],
                         isSelected: false))
        
        role.append(Role(title: "Role 2",
                         objective: [Objective(title: "Objective 1", keyResult: ["KeyResult 1","KeyResult 2","KeyResult 3"]),
                                     Objective(title: "Objective 2", keyResult: ["KeyResult 4","KeyResult 5","KeyResult 6"])],
                         isSelected: false))
        
        role.append(Role(title: "Role 3",
                         objective: [Objective(title: "Objective 1", keyResult: ["KeyResult 1","KeyResult 2","KeyResult 3"]),
                                     Objective(title: "Objective 2", keyResult: ["KeyResult 4","KeyResult 5","KeyResult 6"])],
                         isSelected: false))
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return role.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let r = role[section]
        
        if r.isSelected {
            return r.objective.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.row == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: "roleCell", for: indexPath)
            cell.textLabel?.text = role[indexPath.section].title
            cell.backgroundColor = .cyan
            return cell
        } else {
            cell.textLabel?.text = role[indexPath.section].objective[indexPath.row - 1].title
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            role[indexPath.section].isSelected = !role[indexPath.section].isSelected
            table.reloadSections([indexPath.section], with: .none)
        }
    }
}
