//
//  AddItemViewController.swift
//  Kosuke_Appdojo_Part13
//
//  Created by Kosuke Nagao on 2021/03/14.
//

import UIKit

class AddItemViewController: UIViewController {
    @IBOutlet private weak var nameTextField: UITextField!

    enum Mode {
        case add(completion: (FruitsItem?) -> Void)
        case edit(target: FruitsItem, completion: (FruitsItem?) -> Void)
    }

    var mode: Mode?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let mode = mode else {
            fatalError("mode is nil.")
        }

        switch mode {
        case .add:
            break
        case let .edit(target: fruitsItem, completion: _):
            nameTextField.text = fruitsItem.name
        }
    }

    @IBAction private func didTapSaveButton(_ sender: Any) {
        guard let mode = mode else {
            fatalError("mode is nil.")
        }

        switch mode {
        case let .add(completion: completion):
            let name = nameTextField.text ?? ""
            if name.isEmpty {
                completion(nil)
            } else {
                completion(
                    FruitsItem(name: name, isChecked: false)
                )
            }
            performSegue(withIdentifier: "AddSegue", sender: nil)
        case let .edit(target: fruitsItem, completion: completion):
            let name = nameTextField.text ?? ""
            if name.isEmpty {
                completion(nil)
            } else {
                completion(
                    FruitsItem(name: name, isChecked: fruitsItem.isChecked)
                )
            }
            performSegue(withIdentifier: "EditSegue", sender: nil)
        }
    }
}
