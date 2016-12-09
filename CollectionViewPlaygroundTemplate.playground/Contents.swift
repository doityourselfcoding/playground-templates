//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let window = UIWindow(frame: CGRect(x: 0, y: 0, width: screenSize.toWidth(), height: screenSize.toHeight()))


class SampleCollectionViewCell: UICollectionViewCell{
    
    var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        textLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
        
        addSubview(textLabel)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
        layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

let sampleArrayOfStrings = ["One", "Two", "Three", "Four"]

class SampleViewController: UIViewController{
    
    var arrayOfStrings = [String]()
    
    let kCellReuse : String = "YourCell"
    let kCellheaderReuse : String = "YourHeaderCell"
    var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())   // Initialization
    var refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame.size = screenSize.toSize()
        print("loaded")
        
        arrayOfStrings = sampleArrayOfStrings
        
        // Collection
        collectionView.delegate = self     // delegate  :  UICollectionViewDelegate
        collectionView.dataSource = self   // datasource  : UICollectionViewDataSource
        collectionView.backgroundColor = .white
        
        // Register parts(header and cell
        collectionView.register(SampleCollectionViewCell.self, forCellWithReuseIdentifier: kCellReuse) // UICollectionViewCell
        //collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCellheaderReuse)  // UICollectionReusableView
        
        view.addSubview(self.collectionView)
        
        // set up the refresh control
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(SampleViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.addSubview(refreshControl)
        

        
    }
    
    override func viewWillLayoutSubviews() {
         super.viewWillLayoutSubviews()
        let frame = self.view.frame
        self.collectionView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
    }
    
    
    func refresh(_ sender:AnyObject) {
        // refresh datasource
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension SampleViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell : SampleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellReuse, for: indexPath) as! SampleCollectionViewCell
      
        
        cell.textLabel.text = arrayOfStrings[indexPath.row]
        
        return cell    // Create UICollectionViewCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1  // Number of section
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayOfStrings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       let yourString = arrayOfStrings[indexPath.row]
        // do something with your string
        print(yourString)
        
    }
    //For Header
    /*
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView : UICollectionReusableView? = nil
        
        // Create header
        if (kind == UICollectionElementKindSectionHeader) {
            // Create Header
            let headerView : DriverSearchCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCellheaderReuse, for: indexPath) as! DriverSearchCollectionReusableView
            
            headerView.delegate = self
            
            reusableView = headerView
            
            
        }
        return reusableView!
    }
 */
   
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       // let  screenSize = UIScreen.main.bounds
        
        let sizeOfScreen = screenSize.toSize()
        
        if sizeOfScreen.height/3 < 200 {
            let cellHeight = CGFloat(200)
            return CGSize(width: sizeOfScreen.width, height: cellHeight) // The size of one cell
            
        }else{
            let  cellHeight = sizeOfScreen.height/3
            return CGSize(width: sizeOfScreen.width, height: cellHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)  // Header size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 0, 5, 0) // margin between cells
    }
 

}



let vc = SampleViewController()

vc.navigationItem.title = "Sample Collection View"

let nc = UINavigationController(rootViewController: vc)

window.rootViewController = nc

nc.view.frame

nc.navigationBar.barStyle = .black
nc.navigationBar.barTintColor = style.mainDarkColor
nc.navigationBar.tintColor = .blue

nc.view.setNeedsDisplay()

window.makeKeyAndVisible()
window


PlaygroundPage.current.liveView = window
