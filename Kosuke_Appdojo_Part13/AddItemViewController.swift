//
//  AddItemViewController.swift
//  Kosuke_Appdojo_Part13
//
//  Created by Kosuke Nagao on 2021/03/14.
//

import UIKit

class AddItemViewController: UIViewController {
    @IBOutlet private weak var nameTextField: UITextField!
    private(set) var newFruitsItem: FruitsItem?
    var editFruitsItem: FruitsItem?

    enum Mode {
        case add, edit
    }
    var mode = Mode.add

    override func viewDidLoad() {
        super.viewDidLoad()
        if mode == .edit {
            nameTextField.text = editFruitsItem?.name
        }
    }

    @IBAction private func didTapSaveButton(_ sender: Any) {
        if mode == .edit {
            let name = nameTextField.text ?? ""
            if !name.isEmpty {
                editFruitsItem!.name = name
            }
            performSegue(withIdentifier: "EditSegue", sender: nil)
        } else if mode == .add {
            let name = nameTextField.text ?? ""
            if !name.isEmpty {
                newFruitsItem = FruitsItem(
                    name: name,
                    isChecked: false)
            }
            performSegue(withIdentifier: "AddSegue", sender: nil)
        }
    }
}
