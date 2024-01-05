//
//  ChristmasModel.swift
//  regotcha
//
//  Created by Chloe Nguyen on 12/1/23.
//

import Foundation

struct ChristmasModel {
    static let daysAndGifts: [Int: String] = [
        1: "A Partridge in a Pear Tree",
        2: "Two Turtle Doves",
        3: "Three French Hens",
        4: "Four Calling Birds",
        5: "Five Gold Rings",
        6: "Six Geese-a-Laying",
        7: "Seven Swans-a-Swimming",
        8: "Eight Maids-a-Milking",
        9: "Nine Ladies Dancing",
        10: "Ten Lords-a-Leaping",
        11: "Eleven Pipers Piping",
        12: "Twelve Drummers Drumming"
    ]
    
    static func giftForDay(_ day: Int) -> String? {
        return daysAndGifts[day]
    }
}
