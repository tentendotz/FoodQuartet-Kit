//
//  Constants.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/02.
//

import Foundation

/// Constants = K
enum K {
    
    enum SlotVC {
        static let cellNibName = "SlotCell"
        static let cellIdentifier = "SlotReusableCell"
    }
    
    enum MonthPickerVC {
        static let headerIdentifier = "MonthReusableHeader"
        static let cellIdentifier = "MonthReusableCell"
        static let segueIdentifier = "goToMonthPicker"
    }
    
    enum WebSearchVC {
        static let cellIdentifier = "WebSearchReusableCell"
        static let segueIdentifier = "goToWebSearch"
    }
        
    enum Colors {
        /// #FF8A8A
        static let spring = "SpringColor"
        /// #F19900
        static let summer = "SummerColor"
        /// #D94C3D
        static let fall = "FallColor"
        /// #4C80B3
        static let winter = "WinterColor"
        
        /// Off White: #F0F0F3 / Rich Black: #0E1526
        static let primary = "PrimaryColor"
        /// White: #FFFFFF / Oxford Blue: #151D2E
        static let secondary = "SecondaryColor"
        /// Gainsboro: #DFDFDF / Prussian blue: #1E293A
        static let tertiary = "TertiaryColor"
        /// Electric Purple: #A047EA / Blue Violet: #7134F3
        static let accent = "AccentColor"
    }
}


extension K {
    
    /// Localization = L10n
    enum L10n {
        
        // Food Kind
        static let vegetable = L10n.localized("type_vegetable")
        static let seafood = L10n.localized("type_seafood")
        static let mushroom = L10n.localized("type_mushroom")
        static let meat = L10n.localized("type_meat")
        static let fruit = L10n.localized("type_fruit")
        static let others = L10n.localized("type_others")
        
        // Four Seasons Filter
        static let noFilter = L10n.localized("type_no_filter")
        static let spring = L10n.localized("type_spring")
        static let summer = L10n.localized("type_summer")
        static let fall = L10n.localized("type_fall")
        static let winter = L10n.localized("type_winter")
        
        // Action Button
        static let back = L10n.localized("action_back")
        static let delete = L10n.localized("action_delete")
        static let reset = L10n.localized("action_reset")
        static let ok = L10n.localized("action_ok")
        static let cancel = L10n.localized("action_cancel")
        
        // SlotVC
        static let noData = L10n.localized("title_no_data")
        static let tapPlusButton = L10n.localized("message_tap_plusButton")
        static let notFound = L10n.localized("title_not_found")
        static let changeFilter = L10n.localized("message_change_filter")
        static let plusButtonDisabled = L10n.localized("message_plusButton_disabled")
        static let allPinned = L10n.localized("title_all_pinned")
        static let deselectItem = L10n.localized("message_deselect_item")
        static let askReset = L10n.localized("title_ask_reset")
        
        
        // Dynamic String
        static func rateOfSeasons(with numerator: String) -> String {
            return L10n.localized("label_dynamic_rate", numerator)
        }
        
        
        // MARK: - Localization Helper
        
        private static func localized(_ key: String, _ args: CVarArg...) -> String {
            let format = NSLocalizedString(key, comment: "")
            return String(format: format, arguments: args)
        }
    }
}
