//
//  SlotViewController.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/01.
//

import UIKit

class SlotViewController: UIViewController {
    
    @IBOutlet private weak var currentFilterButton: UIButton!
    @IBOutlet private weak var springButton: UIButton!
    @IBOutlet private weak var summerButton: UIButton!
    @IBOutlet private weak var fallButton: UIButton!
    @IBOutlet private weak var winterButton: UIButton!
    @IBOutlet private weak var monthPickerButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - User Interaction
    
    @IBAction private func seasonsPressed(_ sender: UIButton) {
    }
    
    @IBAction private func currentFilterPressed(_ sender: UIButton) {
    }
    
    @IBAction private func changeItemsPressed(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
