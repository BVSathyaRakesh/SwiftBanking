//
//  LoginViewController.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/14.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var loadingView = LoadingView()

    var viewModel = LoginViewModel()
    let reachability = try! Reachability()

    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    var userNameString = NSMutableAttributedString()
    var passwordString = NSMutableAttributedString()
    var custIDString = NSMutableAttributedString()
    var custIDInpuString = NSMutableAttributedString()
    
    var isLoginEnabled : Bool = true

    
   private let headerView: UIView = {
       let view = UIView()
       return view
    }()
    
  
    //Mark: LoginScreen
    private let loginView: UIView = {
        let view = UIView()
        return view
     }()
    
    private let loginHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "If you are new to bank,"
        label.textColor = .black
        label.font = label.font.withSize(15)
        return label
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("RESITER NOW", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.contentHorizontalAlignment = .left
       // button.backgroundColor = UIColor.blue
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return button
    }()
    
    private let registerSubView: UIView = {
        let view = UIView()
        return view
     }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "VERSION: CLOUD V4.0.11,"
        label.textColor = .lightGray
        label.font = label.font.withSize(12)
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "UserName *"
        label.textColor = .black
        label.font = label.font.withSize(15)
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password *"
        label.textColor = .black
        label.font = label.font.withSize(15)
        return label
    }()
    
    private let userEmailField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .next
        field.textColor = .black
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
       // field.doneAccessory = true
        field.backgroundColor = .white
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.black.cgColor
        field.attributedPlaceholder = NSAttributedString(
            string: "Please type here...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.textColor = .black
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        //field.doneAccessory = true
        field.backgroundColor = .white
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.black.cgColor
        field.attributedPlaceholder = NSAttributedString(
            string: "Please type here...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    //Mark: RegisterScreen
    private let registerView: UIView = {
        let view = UIView()
        return view
     }()
    
    private let signUpHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    private let signUpLoginLabel: UILabel = {
        let label = UILabel()
        label.text = "If you are an existing user"
        label.textColor = .black
        label.font = label.font.withSize(15)
        return label
    }()
    
    private let signUpLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.contentHorizontalAlignment = .left
       // button.backgroundColor = UIColor.blue
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return button
    }()
    
    private let custIDLabel: UILabel = {
        let label = UILabel()
        label.text = "Customer ID *"
        label.textColor = .black
        label.font = label.font.withSize(15)
        return label
    }()
    
    private let custIDInputField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.textColor = .black
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .white
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.black.cgColor
        field.attributedPlaceholder = NSAttributedString(
            string: "Please type here...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        return field
    }()
    
    private let mobileNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Mobile Number *"
        label.textColor = .black
        label.font = label.font.withSize(15)
        return label
    }()
    
    private let mobileNumberField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.textColor = .black
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .white
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.black.cgColor
        field.attributedPlaceholder = NSAttributedString(
            string: "Please type here...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        return field
    }()
    
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    deinit {
        print("OS reclaiming memory for LoginViewController - No Retain Cycles/Leak")
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        spinner.center = view.center
                
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.width,
                                  height: view.height / 3.0);
        
        //Mark: LoginScreen Frames
        loginView.frame = CGRect(x: 0, y: headerView.bottom , width: view.width, height: view.height * 0.7 - 30)
        loginHeaderLabel.frame = CGRect(x: 25,
                                      y: 20,
                                      width: 200,
                                      height: 52.0);
        
        versionLabel.frame = CGRect(x: 25,
                                    y: loginHeaderLabel.bottom ,
                                   width: 200,
                                    height: 22.0);
        
        // set width to Constraint outlet
        var rect: CGRect = registerLabel.frame //get frame of label
        rect.size = (self.registerLabel.text?.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: registerLabel.font.fontName , size: registerLabel.font.pointSize)!]))! //Calculate as per label font
        registerLabel.frame = CGRect(x: 25,
                                      y: versionLabel.bottom ,
                                     width: rect.width + 20,
                                      height: 42.0);
       
        registerButton.frame = CGRect(x: registerLabel.right ,
                                      y: versionLabel .bottom ,
                                      width: 100,
                                      height: 42.0);
        
        userNameLabel.frame = CGRect(x: 25,
                                     y: registerLabel .bottom + 10,
                                     width: view.width-50,
                                     height: 32.0);
        
        userEmailField.frame = CGRect(x: 25,
                                      y: userNameLabel.bottom,
                                      width: view.width-50,
                                      height: 42.0);
        
        passwordLabel.frame = CGRect(x: 25,
                                     y: userEmailField .bottom + 10,
                                     width: view.width-50,
                                     height: 32.0);
        
        passwordField.frame = CGRect(x: 25,
                                     y: passwordLabel.bottom,
                                     width: view.width-50,
                                     height: 42.0);
        
        loginButton.frame = CGRect(x: 25,
                                   y: passwordField.bottom+10,
                                   width: view.width-50,
                                   height: 52.0);
        
        registerView.frame = CGRect(x: 0, y: headerView.bottom , width: view.width, height: view.height * 0.7 - 30)
        
        signUpHeaderLabel.frame = CGRect(x: 25,
                                   y: 20,
                                   width: view.width-50,
                                   height: 52.0);
        
        // set width to Constraint outlet
        var loginRect: CGRect = signUpLoginLabel.frame //get frame of label
        loginRect.size = (self.signUpLoginLabel.text?.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: signUpLoginLabel.font.fontName , size: signUpLoginLabel.font.pointSize)!]))!
        
        signUpLoginLabel.frame = CGRect(x: 25,
                                   y: signUpHeaderLabel.bottom+5,
                                        width: loginRect.width + 20,
                                   height: 32.0);
        signUpLoginButton.frame = CGRect(x: signUpLoginLabel.right,
                                   y: signUpHeaderLabel.bottom+5,
                                   width: view.width-50,
                                   height: 32.0);
        
        custIDLabel.frame = CGRect(x: 25,
                                   y: signUpLoginLabel.bottom,
                                   width: view.width-50,
                                   height: 42.0);
        
        custIDInputField.frame = CGRect(x: 25,
                                   y: custIDLabel.bottom+5,
                                   width: view.width-50,
                                   height: 42.0);
        mobileNumberLabel.frame = CGRect(x: 25,
                                   y: custIDInputField.bottom+5,
                                   width: view.width-50,
                                   height: 42.0);
        
        mobileNumberField.frame = CGRect(x: 25,
                                   y: mobileNumberLabel.bottom+5,
                                   width: view.width-50,
                                   height: 42.0);
        
        signUpButton.frame = CGRect(x: 25,
                                   y: mobileNumberField.bottom+15,
                                   width: view.width-50,
                                   height: 52.0);
                
        
        //Mark: RegisterScreen Frames
        configureHeaderView()
        configureLoginView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            print("Wifi Connection")
            //presentPopUpScreen(errorText: "Wifi Connection")
        case .cellular:
            print("Cellular Connection")
            //presentPopUpScreen(errorText: "Cellular Connection")
        case .unavailable:
            print("No Connection")
            presentPopUpScreen(errorText: "No Internet Connection")
        case .none:
            print("No Connection")
            presentPopUpScreen(errorText: "No Internet Connection")
           // self.internetStatusLabel.text = "No Connection"
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

    //Mark: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
                
        navigationController?.navigationBar.tintColor = .white
        
        loadingView.initilize(viewController: self)

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        
        signUpLoginButton.addTarget(self,
                              action: #selector(loginTapped) ,
                              for: .touchUpInside)
        
        registerButton.addTarget(self,
                              action: #selector(registerTapped) ,
                              for: .touchUpInside)
        
        loginButton.addTarget(self,
                              action: #selector(didLoginTapped) ,
                              for: .touchUpInside)
                
        
        //for mandatory symbol *
        userNameString = NSMutableAttributedString(string: self.userNameLabel.text!, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 15.0)!])
        userNameString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:9,length:1))
        
        passwordString = NSMutableAttributedString(string: self.passwordLabel.text!, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 15.0)!])
        passwordString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:9,length:1))
        
        custIDString = NSMutableAttributedString(string: self.custIDLabel.text!, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 15.0)!])
        custIDString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:12,length:1))
        
        custIDInpuString = NSMutableAttributedString(string: self.mobileNumberLabel.text!, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 15.0)!])
        custIDInpuString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:14,length:1))
        
        userNameLabel.attributedText = userNameString
        passwordLabel.attributedText = passwordString
        custIDLabel.attributedText = custIDString
        mobileNumberLabel.attributedText = custIDInpuString

        setupScrollView()
        addSubViews()
        addLoginSubViews()
        addRegisterSubViews()
    }
    
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    
    func addSubViews(){
        
        contentView.addSubview(headerView)
        contentView.addSubview(loginView)
        contentView.addSubview(registerView)
        
        registerView.layer.cornerRadius = Constants.cornerRadius
        loginView.layer.cornerRadius = Constants.cornerRadius

        headerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0).isActive = true

        loginView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        loginView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 25).isActive = true
        loginView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0).isActive = true
        loginView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        registerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        registerView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 25).isActive = true
        registerView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0).isActive = true
        registerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
       
        if isLoginEnabled {
            isLoginEnabled = true
            loginView.isHidden = false
            registerView.isHidden = true
        }else {
            isLoginEnabled = false
            registerView.isHidden = true
            loginView.isHidden = false
        }
    }
    
    func addLoginSubViews(){
        loginView.addSubview(versionLabel)
        loginView.addSubview(userNameLabel)
        loginView.addSubview(registerLabel)
        loginView.addSubview(userEmailField)
        loginView.addSubview(passwordLabel)
        loginView.addSubview(passwordField)
        loginView.addSubview(loginHeaderLabel)
        loginView.addSubview(registerButton)
        loginView.addSubview(loginButton)
    }
    
    func addRegisterSubViews() {
        registerView.addSubview(signUpHeaderLabel)
        registerView.addSubview(signUpLoginLabel)
        registerView.addSubview(signUpLoginButton)
        registerView.addSubview(custIDLabel)
        registerView.addSubview(custIDInputField)
        registerView.addSubview(mobileNumberLabel)
        registerView.addSubview(mobileNumberField)
        registerView.addSubview(signUpButton)
    }
    
    func configureHeaderView(){
        
        headerView.backgroundColor =  UIColor(red:255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.3)
        
        guard headerView.subviews.count == 0 else {
            return
        }
        
        //Add Appzillon Logo
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width / 4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.frame.width / 2.0,
                                 height: headerView.frame.height - view.safeAreaInsets.top)
    }
    
    func configureLoginView(){
        loginView.backgroundColor = .white
        registerView.backgroundColor = .white
    }
    
    
    @objc func loginTapped(){
        isLoginEnabled = true
        loginView.isHidden = false
        registerView.isHidden = true
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.width,
                                  height: view.height / 3.0 );
    }

    @objc func registerTapped(){
        isLoginEnabled = false
        loginView.isHidden = true
        registerView.isHidden = false
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.width,
                                  height: view.height / 2.0);
    }
    
    @objc func didLoginTapped(){
        
        if reachability.connection != .unavailable {
            AuthManager.shared.authToken = ""
            loadingView.start()
            viewModel.fetchAuthToken { [weak self]  status, error in
                if status == true {
                    if !AuthManager.shared.authToken.isEmpty {
                        DispatchQueue.main.async {
                            self?.loadingView.stop()
                            let vc = DashBoardViewController()
                            vc.title = "Home"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self?.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    }
                }else{
                    print("failed")
                    self?.loadingView.stop()
                    self?.presentPopUpScreen(errorText: error ?? "Server Error")
                }
            }
        }else{
            presentPopUpScreen(errorText: "No Internet Connection")
        }
     
    }
    
    func presentPopUpScreen(errorText:String){
        var popUpWindow: PopUpWindow!
        popUpWindow = PopUpWindow(title: "Information", text: errorText, buttontext: "OK")
        self.present(popUpWindow, animated: true, completion: nil)
    }
}


extension UITextField{
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }

    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
