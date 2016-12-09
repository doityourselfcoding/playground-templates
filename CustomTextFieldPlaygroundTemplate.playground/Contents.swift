//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let window = UIWindow(frame: CGRect(x: 0, y: 0, width: screenSize.toWidth(), height: screenSize.toHeight()))

public enum CustomTextFieldType{
    
    case none
    case firstName
    case lastName
    case phone
    case postalCode
    case email
    case dateOfBirth
    case ssn
    case streetAddress
    case locality
    case region
    case legalName
    case dbaName
    case tin
    case mobilePhone
    case accountNumber
    case routingNumber
    case password
    
    
    func toLabel() -> String {
        switch self {
        case .none:
            return ""
        case .firstName:
            return "FIRST NAME"
        case .lastName:
            return "LAST NAME"
        case .phone:
            return "PHONE"
        case .postalCode:
            return "ZIP"
        case .email:
            return "EMAIL"
        case .dateOfBirth:
            return "DATE OF BIRTH"
        case .ssn:
            return "SSN"
        case .streetAddress:
            return "STREET ADDRESS"
        case .locality:
            return "CITY"
        case .region:
            return "STATE"
        case .legalName:
            return "LEGAL NAME"
        case .dbaName:
            return "DBA NAME"
        case .tin:
            return "TIN"
        case .mobilePhone:
            return "MOBILE PHONE"
        case .accountNumber:
            return "ACCOUNT NUMBER"
        case .routingNumber:
            return "ROUTING NUMBER"
        case .password:
            return "PASSWORD"
            
        }
    }
    
    
    
    func toPlaceHolder() -> String {
        
        switch self {
        case .none:
            return ""
        case .firstName:
            return "John"
        case .lastName:
            return "Smith"
        case .phone:
            return "000000000"
        case .postalCode:
            return "111111"
        case .email:
            return "john.smith@domain.com"
        case .dateOfBirth:
            return "00/00/0000"
        case .ssn:
            return "111111111111"
        case .streetAddress:
            return "123 Main Street"
        case .locality:
            return "My Town"
        case .region:
            return "My State"
        case .legalName:
            return "My Business Name"
        case .dbaName:
            return "My Business DBA Name"
        case .tin:
            return "111111111111"
        case .accountNumber:
            return "123456789"
        case .routingNumber:
            return "123456789"
        case .password:
            return "Password"
            
        default:
            return ""
        }
    }
    
}
open class CustomTextFieldView: UIView {
    
    open var textField = UITextField()
    var type:CustomTextFieldType
    lazy var verifyImageView = UIImageView()
    
    required public init(type: CustomTextFieldType, width: CGFloat, point: CGPoint) {
        self.type = type
        
        let frame = CGRect(x: point.x, y: point.y, width: width, height: 60)
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        addCustomView()
        
    }
    
    public required init(coder aDecoder: NSCoder) {
        print("coder")
        type = .none
        super.init(coder: aDecoder)!
        
    }
    
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    func addCustomView(){
        
        let edgeInsert = CGFloat(20)
        let textFieldSize = CGSize(width: self.frame.width - (edgeInsert * 2), height: 25)
        
        let attributedTitle = NSAttributedString(string: type.toLabel(), attributes: [NSFontAttributeName: style.subheadingsFont(), NSForegroundColorAttributeName: style.mainTextColor])
        
       
        let titleLabel = UILabel(frame: CGRect(x: edgeInsert, y: 0, width: self.frame.width, height: attributedTitle.size().height))
        titleLabel.attributedText = attributedTitle
        titleLabel.numberOfLines = 0
        titleLabel.baselineAdjustment = .alignCenters
        titleLabel.textAlignment  = NSTextAlignment.left
        
        self.addSubview(titleLabel)
        
        
        textField = UITextField(frame:CGRect(x: self.frame.width/2 - textFieldSize.width/2,y: titleLabel.frame.maxY + 10, width: textFieldSize.width, height: textFieldSize.height))
      
        textField.placeholder = type.toPlaceHolder()
        textField.setForTextEntry()
        
        
        let bottomLineLayer = CALayer()
        bottomLineLayer.frame = CGRect(x: 0, y: textField.frame.height - 1 , width: textField.frame.width, height: 4.5)
        bottomLineLayer.backgroundColor = style.lightBackGroundColor.cgColor
        textField.layer.addSublayer(bottomLineLayer)
        
        addSubview(textField)
        
        
        verifyImageView.frame = CGRect(x: bounds.maxX - 40, y: bounds.midY, width: 10, height: 10)
        verifyImageView.isHidden = true
        addSubview(verifyImageView)
        
    }
    
    
    func isValid(showValidation show: Bool) -> Bool{
        
        if verifyText(){
            if show {showValidation(true)}
            return true
        }else{
            if show {showValidation(false)}
            return false
        }
        
    }
    
    
    func hideValidation(){
        verifyImageView.isHidden = true
    }
    
    func showValidation(_ valid:Bool){
        print("should show validation")
        verifyImageView.isHidden = false
        
        if valid{
            verifyImageView.image = UIImage(named: "checkGreen.png")!
        }else{
            verifyImageView.image = UIImage(named: "closeX.png")!
        }
        
    }
    
    func verifyText() -> Bool{
        
        print(textField)
        
        guard let text = textField.text else{
            return false
        }
        
        print(text)
        
        switch type {
        case .email:
            return isValidEmail(text)
        case .phone:
            return isValidPhone(text)
        case .dateOfBirth:
            return isValidDOB(text)
        case .region:
            return isValidTextLength(text, minLength: 1, maxLength:2)
        case .postalCode:
            return isValidPostalCode(text)
        case .password:
            return isValidTextLength(text, minLength: 1, maxLength:200)
        default:
            return isValidTextLength(text, minLength: 1, maxLength:200)
        }
        
        
        
    }
    
    
}



extension CustomTextFieldView {
    
    fileprivate func isValidTextLength(_ value:String, minLength: Int, maxLength:Int) -> Bool {
        
        if value.characters.count <= minLength {
            print(minLength)
            print(value.characters.count)
            return false
        }
        else{
            print("is valid")
            return true
        }
        
    }
    
    fileprivate func isValidPostalCode(_ value:String) -> Bool {
        if value.characters.count == 5 {
            if let _ = Int(value){
                return true
            }else{
                return false
            }
        }else{
            return false
        }
        
    }
    
    fileprivate func isValidEmail(_ value:String) -> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: value)
        return result
    }
    
    fileprivate func isValidPhone(_ value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    fileprivate func isValidDOB(_ value: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/DD/YYYY"
        
        
        if let _ = dateFormatter.date(from: value){
            return true
        }else{
            return false
        }
        
        
    }
    fileprivate func isValidPincode(_ value: String) -> Bool {
        if value.characters.count == 6{
            return true
        }
        else{
            return false
        }
    }
    
    
    
    
}





class SampleViewController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame.size = screenSize.toSize()
        view.backgroundColor = .white
        print("loaded")
        addCustomView()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCustomView(){
        
        let customTextField = CustomTextFieldView(type: .firstName, width: view.frame.width, point: CGPoint(x:0,y:50))
        view.addSubview(customTextField)
        
    }
    
    
}


let vc = SampleViewController() // replace with your viewcontroller

vc.navigationItem.title = "Sample ViewController"

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
