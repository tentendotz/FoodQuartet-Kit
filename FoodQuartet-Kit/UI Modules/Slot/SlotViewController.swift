//
//  SlotViewController.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/01.
//

import UIKit

class SlotViewController: UIViewController {
    
    @IBOutlet private weak var currentFilterButton: UIButton!
    @IBOutlet private weak var springButton: SeasonButton!
    @IBOutlet private weak var summerButton: SeasonButton!
    @IBOutlet private weak var fallButton: SeasonButton!
    @IBOutlet private weak var winterButton: SeasonButton!
    @IBOutlet private weak var monthPickerButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties and Sections
    
    var slotItems = [Food]()
    
}


extension SlotViewController {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.SlotVC.cellNibName, bundle: nil), forCellReuseIdentifier: K.SlotVC.cellIdentifier)
    }
    
    
    // MARK: - User Interaction
    
    @IBAction private func seasonsPressed(_ sender: SeasonButton) {
        let seasonColor: UIColor?
        
        if sender.isSelected {
            sender.isSelected = false
        } else {
            switch sender {
            case springButton:
                seasonColor = UIColor.calculateColor(.springHex)
            case summerButton:
                seasonColor = UIColor.calculateColor(.summerHex)
            case fallButton:
                seasonColor = UIColor.calculateColor(.fallHex)
            case winterButton:
                seasonColor = UIColor.calculateColor(.winterHex)
            default: return
            }
            
            deselectAllSeasonButtons()
            sender.switchState(isSelected: true, backgroundColor: seasonColor)
        }
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


extension SlotViewController {
    
    // MARK: - Additional Helpers
    
    /// Deselect all four season buttons
    private func deselectAllSeasonButtons() {
        springButton.isSelected = false
        summerButton.isSelected = false
        fallButton.isSelected = false
        winterButton.isSelected = false
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate

extension SlotViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slotItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.SlotVC.cellIdentifier, for: indexPath) as? SlotCell else {
            fatalError("Unable to dequeue SlotCell")
        }
        let foodItem = slotItems[indexPath.row]
        
        return cell
    }
    
}


extension SlotViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        slotItems[indexPath.row].isSelected.toggle()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
