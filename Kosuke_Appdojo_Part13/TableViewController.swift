//
//  TableViewController.swift
//  Kosuke_Appdojo_Part13
//
//  Created by Kosuke Nagao on 2021/03/12.
//

import UIKit

class TableViewController: UITableViewController {
    private var indexForEditing: Int?

    private var fruitsItems = [
        FruitsItem(name: "りんご", isChecked: false),
        FruitsItem(name: "みかん", isChecked: true),
        FruitsItem(name: "バナナ", isChecked: false),
        FruitsItem(name: "パイナップル", isChecked: true)
    ]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fruitsItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        cell.configure(fruitsItem: fruitsItems[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fruitsItems[indexPath.row].isChecked.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    @IBAction private func exitCancel(segue: UIStoryboardSegue) {
    }

    @IBAction private func exitAdd(segue: UIStoryboardSegue) {
        guard let addItemViewController = segue.source as? AddItemViewController else { return }
        guard let newItem = addItemViewController.newFruitsItem else { return }
        fruitsItems.append(newItem)
        tableView.reloadData()
    }

    @IBAction private func exitEdit(segue: UIStoryboardSegue) {
        guard let addItemViewController = segue.source as? AddItemViewController else { return }
        guard let editItem = addItemViewController.editFruitsItem else { return }
        guard let indexForEditing = indexForEditing else { return }
        fruitsItems[indexForEditing].name = editItem.name
        tableView.reloadRows(at: [IndexPath(row: editItem.index, section: 0)], with: .automatic)
        self.indexForEditing = nil
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let editFruitsItem = EditFruitsItem(
            name: fruitsItems[indexPath.row].name,
            index: indexPath.row)
        indexForEditing = indexPath.row
        performSegue(withIdentifier: "Edit", sender: editFruitsItem)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController else { return }
        guard let addItemViewController =
                navigationController.topViewController as? AddItemViewController else { return }

        switch segue.identifier ?? "" {
        case "Edit":
            guard let editFruitsItem = sender as? EditFruitsItem else { return }
            addItemViewController.editFruitsItem = editFruitsItem
            addItemViewController.mode = .edit
        case "Add":
            addItemViewController.mode = .add
        default:
            break
        }
    }
}

struct FruitsItem {
    var name: String
    var isChecked: Bool
}

struct EditFruitsItem {
    var name: String
    let index: Int
}
