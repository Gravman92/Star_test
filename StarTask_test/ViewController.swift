//
//  ViewController.swift
//  StarTask_test
//
//  Created by Gravman on 10.01.2020.
//  Copyright © 2020 Alexandr_P. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Reloader {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var contact: [ContactRealm] = []
    var worker: DBWorker?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        worker = ContactWorker()
        fetchData()
    }
    
    
    private func fetchData() {
        guard let realmModel = worker?.fetch() else {return}
        self.contact = realmModel
    }
    
    @IBAction func addNewContact(_ sender: UIBarButtonItem) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DetailVCID") as! DetailedViewController
        controller.delegate = self
        controller.state = .add
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func reload() {
        self.contact = []
        self.fetchData()
        self.myTableView.reloadData()
    }
    
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = contact[indexPath.row]
        cell.textLabel?.text = model.firstName
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DetailVCID") as! DetailedViewController
        controller.realmModel = contact[indexPath.row]
        controller.delegate = self
        controller.state = .edit
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
