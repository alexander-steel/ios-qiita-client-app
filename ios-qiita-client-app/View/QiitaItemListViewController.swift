//
//  QiitaItemListViewController.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/07.
//

import UIKit

class QiitaItemListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var itemCell: UITableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return itemCell
    }
}
