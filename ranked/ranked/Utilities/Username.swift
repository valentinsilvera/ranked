//
//  Username.swift
//  ranked
//
//  Created by Valentin Silvera on 17/10/22.
//

//import UIKit
//
//extension UIDevice {
//    
//    func username() -> String {
//        
//        let deviceName = self.name
//        let expression = "^(?:iPhone|phone|iPad|iPod)\\s+(?:de\\s+)?(?:[1-9]?S?\\s+)?|(\\S+?)(?:['']?s)?(?:\\s+(?:iPhone|phone|iPad|iPod)\\s+(?:[1-9]?S?\\s+)?)?$|(\\S+?)(?:['']?的)?(?:\\s*(?:iPhone|phone|iPad|iPod))?$|(\\S+)\\s+"
//        
//        var username = deviceName
//        
//        do {
//            let regex = try NSRegularExpression(pattern: expression, options: .caseInsensitive)
//            let matches = regex.matches(in: deviceName as String,
//                                        options: NSRegularExpression.MatchingOptions.init(rawValue: 0),
//                                        range: NSMakeRange(0, deviceName.count))
//            let rangeNotFound = NSMakeRange(NSNotFound, 0)
//            
//            var nameParts = [String]()
//            for result in matches {
//                for i in 1..<result.numberOfRanges {
//                    if !NSEqualRanges(result.range(at: i), rangeNotFound) {
//                        nameParts.append((deviceName as NSString).substring(with: result.range(at: i)).capitalized)
//                    }
//                }
//            }
//            
//            if nameParts.count > 0 {
//                username = nameParts.joined(separator: " ")
//            }
//        }
//        catch { NSLog("[Error] While searching for username from device name") }
//        print("DEBUG: \(username)")
//        return username
//    }
//}
