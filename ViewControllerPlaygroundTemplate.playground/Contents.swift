//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let window = UIWindow(frame: CGRect(x: 0, y: 0, width: screenSize.toWidth(), height: screenSize.toHeight()))


class SampleViewController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame.size = screenSize.toSize()
        view.backgroundColor = .white
        print("loaded")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


let vc = SampleViewController() // replace with your viewcontroller

vc.navigationItem.title = "Sample ViewController"

//let nc = UINavigationController(rootViewController: vc)

//window.rootViewController = nc

window.rootViewController = vc

/*
nc.view.frame

nc.navigationBar.barStyle = .black
nc.navigationBar.barTintColor = style.mainDarkColor
nc.navigationBar.tintColor = .blue

nc.view.setNeedsDisplay()
*/

window.makeKeyAndVisible()
window


PlaygroundPage.current.liveView = window
