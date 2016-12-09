//
//  ViewExtentions.swift
//  PkUpCustomer
//
//  Created by PkUp App on 4/11/16.
//  Copyright © 2016 PkUp LLC. All rights reserved.
//

import UIKit

open class TopAlignedLabel: UILabel {
    override open func drawText(in rect: CGRect) {
        if let stringText = text {
            let stringTextAsNSString = stringText as NSString
            let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude),
                                                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                    attributes: [NSFontAttributeName: font],
                                                                    context: nil).size
            super.drawText(in: CGRect(x: 0, y: 0, width: self.frame.width, height: ceil(labelStringSize.height)))
        } else {
            super.drawText(in: rect)
        }
    }
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
}

class BottomAlignedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        if let stringText = text {
            let stringTextAsNSString = stringText as NSString
            let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude),
                                                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                    attributes: [NSFontAttributeName: font],
                                                                    context: nil).size
            super.drawText(in: CGRect(x: 0, y: 0, width: self.frame.width,height: CGFloat.greatestFiniteMagnitude-ceil(labelStringSize.height)))
        } else {
            super.drawText(in: rect)
        }
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
}


extension NSString {
    
    func requiredHeight(_ font: String, size: CGFloat) -> CGFloat{
        let font = UIFont(name: font, size: size)
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self as String
        label.sizeToFit()
        return label.frame.height + 20 //Add some space as a part of bottom and top constraint
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}


public extension UILabel{
    
    convenience init(text:String, width:CGFloat, midX: CGFloat, yPosition:CGFloat, inset: CGFloat, color: UIColor, font: UIFont){
        self.init()
        let attriMessageLabelString = NSAttributedString(string: text, attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: font])
        self.attributedText = attriMessageLabelString
        self.textAlignment = .center
  
        self.sizeToFit()
        let numberOfLines = ceil(self.frame.size.width/width)
        self.numberOfLines = Int(numberOfLines)
        self.frame.size = CGSize(width: width, height: self.frame.height * numberOfLines)
        self.frame.origin = CGPoint(x: midX - self.frame.width/2, y: yPosition)
        self.lineBreakMode = .byWordWrapping
        
    }
    
  public  func setforTitle(){
        self.font = UIFont.systemFont(ofSize: 14)
        self.textColor = UIColor(netHex: 0xffc309)
        self.numberOfLines = 0
        self.baselineAdjustment = .alignCenters
        self.textAlignment  = NSTextAlignment.left
    }
    
    
    func toWrappedText(_ maxWidth: CGFloat){
            
            self.sizeToFit()
            let numberOfLines = ceil(self.frame.size.width/maxWidth)
            self.numberOfLines = Int(numberOfLines)
            self.frame.size = CGSize(width: maxWidth,height: self.frame.height * numberOfLines)
            self.lineBreakMode = .byWordWrapping
            
        }
    
}

extension String{
    
    func getHeight(_ font:UIFont, width: CGFloat) -> CGFloat{
        
        let label = UILabel()
        label.frame.size.width = width
        label.frame.origin = CGPoint(x: 0,y: 0)
        label.numberOfLines = 150
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        
        return label.frame.height
    }
    
}

public extension UITextField {
    
  public  func setForTextEntry(){
        
        self.font = UIFont.systemFont(ofSize: 15)
        self.borderStyle = UITextBorderStyle.none
        self.autocorrectionType = UITextAutocorrectionType.no
        self.keyboardType = UIKeyboardType.default
        self.returnKeyType = UIReturnKeyType.done
        self.clearButtonMode = UITextFieldViewMode.whileEditing;
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.top
    }
    
    
}



public extension UIImage {
    
    func  convertToThumbnail(_ size: CGSize) -> UIImage{// Define thumbnail size
       
        //let size = CGSize(width: 100, height: 100)
        
        // Define rect for thumbnail
        let scale = max(size.width/self.size.width, size.height/self.size.height)
        let width = self.size.width * scale
        let height = self.size.height * scale
        let x = (size.width - width) / CGFloat(2)
        let y = (size.height - height) / CGFloat(2)
        let thumbnailRect = CGRect(x: x, y: y, width: width, height: height)
        
        // Generate thumbnail from image
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: thumbnailRect)
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return thumbnail!
    }
    
}
    

    
    
