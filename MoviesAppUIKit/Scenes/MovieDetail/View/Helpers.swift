//
//  Helpers.swift
//  MoviesAppUIKit
//
//  Created by Anatolii Shumov on 05/10/2023.
//

import Foundation
import UIKit

extension MovieDetailView {
    func formattedYear() -> String {
        guard let inputDate = movie.releaseDate else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: inputDate) else { return "" }
        dateFormatter.dateFormat = "(yyyy)"
        return dateFormatter.string(from: date)
    }
    
    func checkTitleLength() -> UIStackView {
        if (movie.title?.count ?? 0) < 30 {
            let hStack = HStack(arrangedSubviews: [titleLabel, yearLabel])
            return hStack
        } else {
            let vStack = VStack(arrangedSubviews: [titleLabel, yearLabel])
            return vStack
        }
    }
    
    func formattedString(_ vote: Double) -> String {
        return String(format: "%.1f", vote)
    }
}
