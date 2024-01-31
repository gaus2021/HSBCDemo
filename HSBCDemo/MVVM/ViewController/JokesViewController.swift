//
//  JokesViewController.swift
//  HSBCDemo
//
//  Created by Ghous Ansari on 31/01/24.
//

import UIKit

class JokesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: JokesViewModel = JokesViewModel(repository: JokesRepository())
    
    var items: [JokesResponse]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        viewModel.fetchItems()
        
        viewModel.onErrorHandling = { error in
            print(error.localizedDescription)
        }
        
        viewModel.items = { itemsArray in
            self.items = itemsArray
        }
    }
}

//MARK: - Table View Delegate and Datasource
extension JokesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell") 
        cell.textLabel?.text = items?[indexPath.row].joke
        cell.textLabel?.numberOfLines = 0
        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
