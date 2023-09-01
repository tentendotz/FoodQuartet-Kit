//
//  SlotViewController.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/01.
//

import UIKit

class SlotViewController: UIViewController {
    
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var springButton: SeasonButton!
    @IBOutlet private weak var summerButton: SeasonButton!
    @IBOutlet private weak var fallButton: SeasonButton!
    @IBOutlet private weak var winterButton: SeasonButton!
    @IBOutlet private weak var monthPickerButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var plusButtonCell: PlusButtonCell = {
        let cell = PlusButtonCell()
        let action = UIAction { [weak self] _ in
            // Just 1 item append to slotItems array.
            self?.performQuery(addition: 1)
        }
        cell.button.addAction(action, for: .touchUpInside)
        return cell
    }()
    
    
    // MARK: - Properties and Section Handling
    
    private var foodBrain = FoodBrain()
    
    var slotItems = [Food]() {
        didSet {
            guard slotItems.count != oldValue.count else { return }
            evaluatePlusButtonState()
        }
    }

    
    private var userRules = [String]() {
        didSet {
            let newLabel = userRules.isEmpty ? K.L10n.noFilter : userRules.joined(separator: " & ")
            filterButton.configuration?.title = newLabel
            
            deselectAllSeasonButtons()
            evaluatePlusButtonState()
        }
    }
    
    private enum Section: Int, CaseIterable {
        case slots = 0, bottom
        func countItems(of items: [Food]) -> Int {
            switch self {
            case .slots: return items.count
            case .bottom: return 1
            }
        }
    }
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
        let seasonName: String
        let seasonColor: UIColor?
        
        if sender.isSelected {
            // Retain the buffer capacity for refilling the collection
            userRules.removeAll(keepingCapacity: true)
        } else {
            switch sender {
            case springButton:
                seasonName = K.L10n.spring
                seasonColor = UIColor.calculateColor(.springHex)
            case summerButton:
                seasonName = K.L10n.summer
                seasonColor = UIColor.calculateColor(.summerHex)
            case fallButton:
                seasonName = K.L10n.fall
                seasonColor = UIColor.calculateColor(.fallHex)
            case winterButton:
                seasonName = K.L10n.winter
                seasonColor = UIColor.calculateColor(.winterHex)
            default: return
            }
            userRules = [seasonName]
            sender.switchState(isSelected: true, backgroundColor: seasonColor)
        }
    }
    
    @IBAction private func filterPressed(_ sender: UIButton) {
    }
    
    @IBAction private func changeItemsPressed(_ sender: UIButton) {
        if slotItems.isEmpty { return }
        performQuery()
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
    
    private func evaluatePlusButtonState() {
        let maximumLimit = 5
        let totalFoodCount = foodBrain.filteredFoods(with: userRules).count
        
        if slotItems.count < maximumLimit && slotItems.count < totalFoodCount {
            plusButtonCell.isEnabled = true
        } else {
            plusButtonCell.isEnabled = false
        }
    }
    
    private func performQuery(addition: Int? = nil) {
        if let numberOfAddition = addition {
            let newItems = foodBrain.filteredFoods(with: userRules, except: slotItems, limit: numberOfAddition)
            slotItems.append(contentsOf: newItems)
            
            let newRange = slotItems.count - numberOfAddition ..< slotItems.count
            let indexPaths = newRange.map { IndexPath(row: $0, section: Section.slots.rawValue) }
            tableView.insertRows(at: indexPaths, with: .fade)
            
        } else {
            let selected = slotItems.filter { $0.isSelected }
            let filtered = foodBrain.filteredFoods(with: userRules, except: selected, limit: slotItems.count - selected.count)
            slotItems = selected + filtered
            
            tableView.reloadData()
        }
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate

extension SlotViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if slotItems.isEmpty {
            // TODO: - Implement localization...
            tableView.createEmptyState(title: "No Food Data", message: "Tap the plus button to add item.")
        } else {
            tableView.restore()
        }
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKind = Section(rawValue: section)
        return sectionKind?.countItems(of: slotItems) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionKind = Section(rawValue: indexPath.section) else { return .init() }
        
        switch sectionKind {
        case .slots:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: K.SlotVC.cellIdentifier, for: indexPath) as? SlotCell else {
                fatalError("Unable to dequeue SlotCell")
            }
            let foodItem = slotItems[indexPath.row]
            let configuredCell = applyConfiguration(cell, with: foodItem)
            return configuredCell
        case .bottom:
            return plusButtonCell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return Section(rawValue: indexPath.section) == .slots ? true : false
    }
}


extension SlotViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = CGFloat(88)
        let sectionKind = Section(rawValue: indexPath.section)
        
        switch sectionKind {
        case .slots:
            return slotItems.isEmpty ? 0 : cellHeight
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionKind = Section(rawValue: indexPath.section)
        switch sectionKind {
        case .slots:
            slotItems[indexPath.row].isSelected.toggle()
            tableView.reloadRows(at: [indexPath], with: .none)
        default: return
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let sectionKind = Section(rawValue: indexPath.section) else { return .init() }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            switch sectionKind {
            case .slots:
                self.slotItems[indexPath.row].isSelected = false
                self.slotItems.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true)
            default: completionHandler(false)
            }
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
