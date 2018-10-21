//
//  ViewController.swift
//  DynamicTableView
//
//  Created by SHEHAN on 10/21/18.
//  Copyright © 2018 Shehan Gunarathne. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    var data: [Item] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
    }

    func retrieveData() {
        DispatchQueue.global().async { [weak self] in
            APIManager.sharedInstance.getData(onSuccess: { (items) in
                self?.data = items
                self?.tableView.reloadData()
            }) { (error) in
                print(error)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ItemTableViewCell
        let index = indexPath.row
        let item = data[index]
        cell.itemNameLbl.text = item.title
        cell.itemDescriptionLbl.text = item.description
        cell.itemImageView.kf.setImage(with: item.image, completionHandler: {
            (image, error, cacheType, imageUrl) in
            tableView.reloadRows(at: [indexPath], with: .none)
        })

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}
