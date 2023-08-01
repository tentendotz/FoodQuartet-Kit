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
        let configuredCell = applyConfiguration(cell, with: foodItem)
        return configuredCell
    }
    
}


extension SlotViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = CGFloat(88)
        return slotItems.isEmpty ? 0 : cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        slotItems[indexPath.row].isSelected.toggle()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            self.slotItems[indexPath.row].isSelected = false
            self.slotItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfig.performsFirstActionWithFullSwipe = true
        return swipeConfig
    }
}


// MARK: - UI Layout & Configuration

extension SlotViewController {
    
    private func applyConfiguration(_ cell: SlotCell, with foodItem: Food) -> SlotCell {
        let itemSeasons = foodItem.retrieveSeasons()
        let format = "%@/4 seasons"
        let countLabel = String(format: format, itemSeasons.count.description)
        
        cell.configureCell(title: foodItem.name, color: foodItem.color, isSelected: foodItem.isSelected)
        cell.configureSeasonIcons(
            caption: countLabel,
            spring: itemSeasons.contains(K.L10n.spring),
            summer: itemSeasons.contains(K.L10n.summer),
            fall: itemSeasons.contains(K.L10n.fall),
            winter: itemSeasons.contains(K.L10n.winter)
        )
        return cell
    }
}
