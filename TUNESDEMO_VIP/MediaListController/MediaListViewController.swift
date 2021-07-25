//
//  MediaListViewController.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
import UIKit

protocol MediaListViewControllerInput: AnyObject {
    func showMediaList(list: [String])
}

protocol MediaListViewControllerOutput: AnyObject {
    func getMediaList()
}

class MediaListViewController: UIViewController {
    
    var interactor: MediaListInteractor?
    var rounter: MediaListRouter?
    var presnter: MediaListPresenter?
    
    weak var delegate: SearchScreenPresenter?
    @IBOutlet weak var listMediaType: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.getMediaList()
        setupTableView()
        
    }
    
    deinit {
        delegate?.selectedList = presnter?.selectedTypelist ?? []
        delegate?.showMediaList(mediaTypeList: delegate?.selectedList ?? [])
    }
    
    func setupTableView() {
        listMediaType?.dataSource = self
        listMediaType?.delegate = self
    }
}

extension MediaListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CELL") as UITableViewCell? ?? UITableViewCell()
        cell.textLabel?.text = presnter?.getItemAtList(indexPath.row)
    
        if ((presnter?.selectedTypelist.contains(presnter?.getItemAtList(indexPath.row)?.lowercased() ?? "")) ?? false) {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
                // set the text from the data model
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presnter?.getItemsCount() ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        guard let item = presnter?.getItemAtList(indexPath.row)?.lowercased() else {
            return
        }
        
        if !(presnter?.selectedTypelist.contains(item) ?? false) {
            presnter?.selectedTypelist.append(presnter?.getItemAtList(indexPath.row)?.lowercased() ?? "")
            cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
                    } else {
                        presnter?.addItemToList(item)
                        cell?.accessoryType = UITableViewCell.AccessoryType.none
                    }
    }
}

extension MediaListViewController: MediaListViewControllerInput {
    func showMediaList(list: [String]) {
        self.listMediaType?.reloadData()
    }
    
}
