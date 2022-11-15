//
//  Extentions.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-11-07.
//

import Foundation

extension Int {
    var timeDifference : String{
        
        let timestampDate = NSDate(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let time = dateFormatter.string(from: timestampDate as Date)
        
        return time
    }
}
