//
//  StyleKit.swift
//  PkUpCustomer
//
//  Created by PkUp App on 3/24/16.
//  Copyright © 2016 PkUp LLC. All rights reserved.
//

//
//  StyleKit.swift
//  PkUpCustomer
//
//  Created by PkUp App on 3/24/16.
//  Copyright © 2016 PkUp LLC. All rights reserved.
//

import UIKit


open class StyleKit {
    
    
    //Font Sizes
    
    open var largeTypeOrTitleFontSize:CGFloat
    open var subheadingsFontSize:CGFloat
    open var secondaryTypeOrHeaderFontSize:CGFloat
    open var textLinksFontSize:CGFloat
    open var bodyFontSize:CGSize
    open var anxillaryFontSize:CGFloat
    open var smallTipFontSize:CGFloat
    open var addressTableFontSize:CGFloat
    
    //Colors
    
    open let largeTypeOrTitleFontColor = UIColor(netHex: 0x6e797c)
    open let subheadingsFontColorYellow = UIColor(netHex: 0xffd34b)
    open let subheadingsFontColorGrey = UIColor(netHex: 0xd0d3d4)
    open let secondaryTypeOrHeaderFontColorDark = UIColor(netHex: 0x6e797c)
    open let secondaryTypeOrHeaderFontColorLight = UIColor(netHex: 0xd0d3d4)
    open let textLinksFontColor = UIColor(netHex: 0xd0d3d4)
    open let bodyFontColor = UIColor(netHex: 0x6e797c)
    
    required public init(width: CGFloat){
        
        var scale:Double
        
        if width < 321 {
            scale = 0.60
            
        }else{
            scale = 0.60
            
        }
        
        largeTypeOrTitleFontSize = CGFloat(Int(58 * scale))
        subheadingsFontSize = CGFloat(Int(24 * scale))
        secondaryTypeOrHeaderFontSize = CGFloat(Int(36 * scale))
        textLinksFontSize = CGFloat(Int(24 * scale))
        bodyFontSize = CGSize(width: Int(24 * scale), height: Int(42 * scale))
        anxillaryFontSize = CGFloat(Int(14 * scale))
        smallTipFontSize = CGFloat(Int(28 * scale))
        addressTableFontSize = CGFloat(Int(20 * scale))
        
        
    }
    


    open func largeTypeOrTitleFont() -> UIFont{
        return UIFont.systemFont(ofSize: largeTypeOrTitleFontSize, weight: UIFontWeightLight)
    }
    open func largeTypeOrTitleSubscriptFont() -> UIFont{
        return UIFont.systemFont(ofSize: largeTypeOrTitleFontSize * 0.70, weight: UIFontWeightLight)
    }
    open func subheadingsFont() -> UIFont{
        return UIFont.systemFont(ofSize: subheadingsFontSize, weight: UIFontWeightMedium)
    }
    open func secondaryTypeOrHeaderFont() -> UIFont{
        return UIFont.systemFont(ofSize: secondaryTypeOrHeaderFontSize, weight: UIFontWeightSemibold)
    }
    open func textLinksFont() -> UIFont{
        return UIFont.systemFont(ofSize: textLinksFontSize, weight: UIFontWeightRegular)
    }
    open func bodyFont() -> UIFont{
       return UIFont.systemFont(ofSize: bodyFontSize.width, weight: UIFontWeightLight)
    }
    open func smallTipFont() -> UIFont{
        return UIFont.systemFont(ofSize: smallTipFontSize, weight: UIFontWeightRegular)
    }
    open func anxillaryFont() -> UIFont{
        return UIFont.systemFont(ofSize: anxillaryFontSize, weight: UIFontWeightRegular)
    }
    
    
    
    open let collectionViewSpacer = CGFloat(15)
    open let mainFontSize = CGFloat(42)
    open let sectionHeaderFontSize = CGFloat(12)
    
    open let headerTextSize = CGFloat(42)
    
    //Colors
    open let mainTextColor = UIColor(netHex: 0x6e797c)
    open let secondaryTextColor = UIColor(netHex: 0xbfc3c4)
    open let pkupYellow = UIColor(netHex: 0xffc309)
    open let collectionViewBackgroundColor = UIColor(netHex: 0xf8f9f9)
    open let lightBackGroundColor = UIColor(netHex: 0xf8f9f9)
    open let mainDarkColor = UIColor(netHex: 0x4e5c5f)
    open let menuColor = UIColor(netHex: 0xbfc3c4)
    open let mapBlueColor = UIColor(netHex: 0x007aff)
    open let secureGreenColor = UIColor(netHex: 0xC5E1A5)
    
    //Fonts
    open let bodyText = "SF-UI-Text-Regular"
    
}


