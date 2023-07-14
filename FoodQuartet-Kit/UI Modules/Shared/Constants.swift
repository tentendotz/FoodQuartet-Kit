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
                
        // Four Seasons Filter
        static var spring = "Spring (MAR. APR. MAY)"
        static let summer = "Summer (JUN. JUL. AUG.)"
        static let fall = "Fall (SEP. OCT. NOV.)"
        static let winter = "Winter (DEC. JAN. FEB.)"
    }
}
