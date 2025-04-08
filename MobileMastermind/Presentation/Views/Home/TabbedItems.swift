//
//  TabbedItem.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 7/4/25.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable {
    case home = 0
    case ranking
    case profile
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .ranking:
            return "Ranking"
        case .profile:
            return "Perfil"
        }
    }
    
    var iconName: ImageResource {
        switch self {
        case .home:
            return .BottomBarIcons.home
        case .ranking:
            return .BottomBarIcons.ranking
        case .profile:
            return .BottomBarIcons.profile
        }
    }
}
