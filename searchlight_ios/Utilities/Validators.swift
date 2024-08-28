//
//  RegexValidator.swift
//  searchlight_ios
//
//  Created by 김성빈 on 7/2/24.
//

import Foundation

func validateByRegex(_ input: String, _ regex: String) -> Bool {
    return input.range(of: regex, options: .regularExpression) != nil
}
