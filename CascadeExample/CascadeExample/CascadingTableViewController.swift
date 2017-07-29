//
//  CascadingTableViewController.swift
//  CascadeExample
//
//  Created by Kevin Tulod on 1/7/17.
//  Copyright © 2017 Kevin Tulod. All rights reserved.
//

import UIKit

class CascadingTableViewController: UITableViewController {

    var panelNumber = Int(0)
    
    init(panelNumber: Int, style: UITableViewStyle = .plain) {
        super.init(style: style)
        self.panelNumber = panelNumber
        navigationItem.title = "View Controller \(panelNumber)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "generic-cell")
        clearsSelectionOnViewWillAppear = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "generic-cell", for: indexPath)

        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "Listing \(indexPath.row)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextController = CascadingNavigationController(tableNumber: panelNumber+1)
        cascadeController?.cascade(viewController: nextController, sender: navigationController)
    }
}
