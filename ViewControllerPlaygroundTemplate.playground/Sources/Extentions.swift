//
//  Extentions.swift
//  PkUpCustomer
//
//  Created by PkUp App on 3/22/16.
//  Copyright © 2016 PkUp LLC. All rights reserved.
//

import Foundation
import UIKit
import MapKit
//import QuartzCore

/*
class SegueFromLeft: UIStoryboardSegue {
    
    override func perform() {
        let src: UIViewController = self.sourceViewController 
        let dst: UIViewController = self.destinationViewController 
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.25
        transition.timingFunction = timeFunc
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        src.navigationController?.view.layer.addAnimation(transition, forKey: kCATransition)
        src.navigationController?.pushViewController(dst, animated: false)
    }
    
}
*/

extension String {
    func javaScriptEscapedString() -> String {
        
        //https://gist.github.com/pwightman/64c57076b89c5d7f8e8c
        // Because JSON is not a subset of JavaScript, the LINE_SEPARATOR and PARAGRAPH_SEPARATOR unicode
        // characters embedded in (valid) JSON will cause the webview's JavaScript parser to error. So we
        // must encode them first. See here: http://timelessrepo.com/json-isnt-a-javascript-subset
        // Also here: http://media.giphy.com/media/wloGlwOXKijy8/giphy.gif
            let str = self
            .replacingOccurrences(of: "\u{2028}", with:  "\\u2028")
            .replacingOccurrences(of: "\u{2029}", with:  "\\u2029")
        
          //  self.stringByReplacingOccurrencesOfString("\u{2028}", withString: "\\u2028")
           // self.stringByReplacingOccurrencesOfString("\u{2029}", withString: "\\u2029")
        // Because escaping JavaScript is a non-trivial task (https://github.com/johnezang/JSONKit/blob/master/JSONKit.m#L1423)
        // we proceed to hax instead:
        let data = try! JSONSerialization.data(withJSONObject: [str], options: [])
        let encodedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
        return encodedString.substring(with: NSMakeRange(1, encodedString.length - 2))
    }
}



extension TimeInterval {
    func formatted() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [NSCalendar.Unit.hour, NSCalendar.Unit.minute]
        
        return formatter.string(from: self)!
    }
}

extension Float {
    func format(_ f: String) -> String {
        return NSString(format: "%\(f)f" as NSString, self) as String
    }
}

extension Double {
    
    func roundToPlaces(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        
        return Darwin.round(self * divisor) / divisor
    }
    
    
    func toDollars(_ sign: Bool) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if !sign{
            formatter.currencySymbol = ""
        }
        
        guard let dollarsString = formatter.string(from: self as NSNumber)
            else{ return "" }
        
        return dollarsString
        
    }
    
    mutating func toMiles() -> String{
        
        var milesString:String
        
        if self < 99{
            let roundedMiles = self.roundToPlaces(2)
            milesString = String(roundedMiles)
        }else{
            let roundedMiles = self.roundToPlaces(0)
            milesString = String(Int(roundedMiles))
        }
        
        return milesString
        
    }
 
}


extension Int {
    
    func toBool () ->Bool? {
        
        switch self {
            
        case 0:
            
            return false
            
        case 1:
            
            return true
            
        default:
            
            return nil
            
        }
        
    }
    
}

//https://gist.github.com/natecook1000/b0285b518576b22c4dc8

extension Timer {
    /**
     Creates and schedules a one-time `NSTimer` instance.
     
     - Parameters:
     - delay: The delay before execution.
     - handler: A closure to execute after `delay`.
     
     - Returns: The newly-created `NSTimer` instance.
     */
    /*
    class func schedule(delay: TimeInterval, handler: @escaping (Timer!) -> Void) -> Timer {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer
    }
    */
    /**
     Creates and schedules a repeating `NSTimer` instance.
     
     - Parameters:
     - repeatInterval: The interval (in seconds) between each execution of
     `handler`. Note that individual calls may be delayed; subsequent calls
     to `handler` will be based on the time the timer was created.
     - handler: A closure to execute at each `repeatInterval`.
     
     - Returns: The newly-created `NSTimer` instance.
     */
    /*
    class func schedule(repeatInterval interval: TimeInterval, handler: @escaping (Timer!) -> Void) -> Timer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer
    }
 */
}

extension NSNumber {
    func isBoolNumber() -> Bool
    {
        let boolID = CFBooleanGetTypeID() // the type ID of CFBoolean
        let numID = CFGetTypeID(self) // the type ID of num
        return numID == boolID
    }
}

/*
extension NSData {
    
    func convertToJason() throws -> JSON {
        
        let json = JSON(data: self)
        
        switch json.type{
        case .Dictionary:
            return json
        default:
            throw JsonError.NotDictionary
        }
    }
}
*/

extension MKMapItem {
    
    func getAddress() -> String {
        
        guard let streetNumber = self.placemark.subThoroughfare else{
                return "\(self.placemark.coordinate.latitude),\(self.placemark.coordinate.longitude)"
        }
        guard let streetName = self.placemark.thoroughfare else{
                return "\(self.placemark.coordinate.latitude),\(self.placemark.coordinate.longitude)"
        }
        guard let city = self.placemark.locality else{
                return "\(self.placemark.coordinate.latitude),\(self.placemark.coordinate.longitude)"
        }
        guard let state = self.placemark.administrativeArea else{
                return "\(self.placemark.coordinate.latitude),\(self.placemark.coordinate.longitude)"
        }
        guard let zip = self.placemark.postalCode else{
                return "\(self.placemark.coordinate.latitude),\(self.placemark.coordinate.longitude)"
        }
        
        let streetAddress = "\(streetNumber) \(streetName)"
        
        let address = "\(streetNumber) \(streetName), \(city), \(state) \(zip)"
        
            if streetAddress != self.name{
                if let name = self.name{
                    return "\(name), \(address)"
                }else{
                    return address
                }
            }else{
                return address
            }
        
        }
   
    }

extension CLLocationCoordinate2D {
    
    func toString() -> String{
        
        return "\(self.latitude),\(self.longitude)"
        
        
    }
    
}




extension Date {
    
    func  toFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let dateString = dateFormatter.string(from: self)
        return dateString
    }


}




