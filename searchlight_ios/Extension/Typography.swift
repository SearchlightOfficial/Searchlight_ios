//
//  Typography.swift
//  searchlight_ios
//
//  Created by 김성빈 on 6/11/24.
//

import SwiftUI
//import UIKit

struct FontSetting {
    var name: String
    var size: CGFloat
    var lineHeight: CGFloat
}

enum FontType {
    case LargeTitle
    case Title
    case HeadLine
    case Body
    case Caption

    var setting: FontSetting {
        switch self {
        case .LargeTitle:
            return FontSetting(name: "SUIT-SemiBold", size: 24, lineHeight: 24*1.5)
        case .Title:
            return FontSetting(name: "SUIT-Medium", size: 18, lineHeight: 18*1.5)
        case .HeadLine:
            return FontSetting(name: "SUIT-Medium", size: 16, lineHeight: 16*1.5)
        case .Body:
            return FontSetting(name: "SUIT-Regular", size: 16, lineHeight: 16*1.5)
        case .Caption:
            return FontSetting(name: "SUIT-Regular", size: 14, lineHeight: 14*1.5)
        }
    }
}

struct FontModifier: ViewModifier {
    let color: Color
    let fontType: FontType
    
    func body(content: Content) -> some View {
        let fontSetting = fontType.setting
        let font = UIFont(name: fontSetting.name, size: fontSetting.size)!
        
        content
            .font(Font(font))
            .lineSpacing(fontSetting.lineHeight - font.lineHeight)
            .padding(.vertical, (fontSetting.lineHeight - font.lineHeight) / 2)
            .foregroundColor(color)
    }
}

extension View {
    func fontModifier(_ fontType: FontType = .Body, _ color: Color = .Grayscale._10) -> some View {
        modifier(FontModifier(color: color, fontType: fontType))
    }
}

struct Typography: View {
    let text: String
    let color: Color
    let fontType: FontType

    var body: some View {
        Text(text)
            .fontModifier(fontType, color)
    }
}
