//
//  AddItemViewContoller.swift
//  MovieBoard
//
//  Created by Naryu on 2019/11/15.
//  Copyright © 2019 Naryu. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    weak var delegate: AddItemViewControllerDelegate?
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textfield.becomeFirstResponder()
    }
    
    @IBAction func done(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        let item = ChecklistItem()
        if let textFieldText = textfield.text {
            item.text = textFieldText
        }
        item.checked = false
        delegate?.addItemViewController(self, didFinishAdding: item)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}

    
extension AddItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textfield.text, let stringRange = Range(range, in: oldText) else {
            return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        addBarButton.isEnabled = !newText.isEmpty
        
        return true
    }
    
}

protocol AddItemViewControllerDelegate: class {
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
}


extension ChecklistViewController: AddItemViewControllerDelegate {
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
        print("Added \(item.text)")
    }
    
    
}
