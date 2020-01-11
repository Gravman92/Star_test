//
//  DetailedViewController.swift
//  StarTask_test
//
//  Created by Gravman on 11.01.2020.
//  Copyright © 2020 Alexandr_P. All rights reserved.
//

import UIKit

protocol Reloader {
    func reload()
}
enum State {
    case add
    case edit
}
class DetailedViewController: UIViewController {
    
    @IBOutlet var detailView: DetailView!
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    
    var realmModel: ContactRealm!
    var worker: DBWorker?
    var delegate: Reloader?
    
    var state: State = .add{
        didSet {
            switch state {
            case .add:
                self.deleteBtn.isEnabled = false
            default:
                self.deleteBtn.isEnabled = true
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.setData(realmModel)
        worker = ContactWorker()
    }
    
    
    @IBAction func deleteContact(_ sender: UIBarButtonItem) {
        deleteContact()
    }
    
    @IBAction func save(_ sender: UIButton) {
        switch state {
        case .add:
            addContact()
        case .edit:
            editContact()
        }
        
    }
    
    private func deleteContact() {
        prepareRealmModel { [unowned self] in
            guard let model = self.realmModel else { return }
            self.worker?.delete(model)
            self.operationDone()
        }
    }
    
    private func addContact() {
        prepareRealmModel { [unowned self] in
            self.worker?.save(self.realmModel)
            self.operationDone()
        }
    }
    
    private func editContact() {
        prepareRealmModel { [unowned self] in
            guard let model = self.realmModel else { return }
            self.worker?.update(model)
            self.operationDone()
        }
    }
    
    private func operationDone() {
        self.delegate?.reload()
        self.navigationController?.popViewController(animated: true)
    }
    
   private func prepareRealmModel(_ handler: @escaping () -> ()) {
        let realmModel = ContactRealm()
        guard detailView.phoneNumberTextField.text?.count ?? 0 > 0,
        detailView.nameTextField.text?.count ?? 0 > 0  else {showPopUp(); return}
        realmModel.firstName = detailView.nameTextField.text ?? ""
        realmModel.lastName = detailView.lastNameTextField.text ?? ""
        realmModel.phoneNumber = detailView.phoneNumberTextField.text ?? ""
        realmModel.phoneType = "Home"
        self.realmModel = realmModel
        handler()
    }
}

extension DetailedViewController {
   private func showPopUp() {
        let ac = UIAlertController(title: "Внимание", message: "Проверьте обязательные поля", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "OK", style: .cancel) { (_) in}
        ac.addAction(ok)
        self.present(ac, animated: true, completion: nil)
    }
}
