//
//  TransferViewController.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/27.
//

import UIKit
import DropDown

class TransferViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var fromAccLabel: UILabel!
    @IBOutlet weak var toAccLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var remarksTextView: UITextView!
    @IBOutlet weak var toAccTextField: UITextField!
    @IBOutlet weak var accTypeTextField: UITextField!
    @IBOutlet weak var fromAccTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    var accountDetailsArray = [AnyObject]()
    var filteresDetailsArray = [String]()
    var beneficiariesArray : [BeneficiariesData] = []
    
    var currentAccountId = ""
    
    var viewModel = TransferViewModel()
    
    let menu: DropDown = {
        let menu = DropDown()
        return menu
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpRemarksTextView()
        viewModel.fetchAccountsData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getBeneficiariesData { beneficiarie, status in
            self.beneficiariesArray = beneficiarie ?? []
        }
        //print(self.beneficiariesArray[0])
    }
      
    
       
    // MARK: - Remarks TextView UI Setup
    func setUpRemarksTextView() {
        remarksTextView.text = "Enter Remarks"
        remarksTextView.textColor = UIColor.lightGray
        remarksTextView.backgroundColor = UIColor.white
        remarksTextView.layer.cornerRadius = 8.0
        remarksTextView.layer.borderWidth = 1.0
        remarksTextView.layer.masksToBounds = true
    }
    
    // MARK: -  TextView Delegate Methods
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter Remarks"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == fromAccTextField {
            configureFromAccountDropdown(textField: textField)
        }else if textField == accTypeTextField{
            configureAcTypeDropdown(textField: textField)
        }else if textField == toAccTextField {
            configureBeneficiaries(textField: textField)
        }
        DropDown.startListeningToKeyboard()
        return false
    }
    
    func configureFromAccountDropdown(textField: UITextField){
        filteresDetailsArray = []
        menu.anchorView = fromAccTextField
        menu.bottomOffset = CGPoint(x: 0, y:(menu.anchorView?.plainView.bounds.height)!)
        if filteresDetailsArray.count == 0 {
            filteresDetailsArray = accountDetailsArray.compactMap{
                self.currentAccountId !=  $0["accountNo"] as? String ? $0["accountNo"] as? String : nil
            }
        }
        menu.dataSource = filteresDetailsArray
        menu.show()
        // Action triggered on selection
        menu.selectionAction = { (index: Int, item: String) in
            textField.text = item
        }
    }
    
    func configureAcTypeDropdown(textField: UITextField){
        filteresDetailsArray = ["self","SB","CB"]
        menu.anchorView = accTypeTextField
        menu.bottomOffset = CGPoint(x: 0, y:(menu.anchorView?.plainView.bounds.height)!)
        menu.dataSource = filteresDetailsArray
        menu.show()
        // Action triggered on selection
        menu.selectionAction = {  (index: Int, item: String) in
            textField.text = item
        }
    }
    
    func configureBeneficiaries(textField: UITextField){
        filteresDetailsArray = []
        menu.anchorView = toAccTextField
        menu.bottomOffset = CGPoint(x: 0, y:(menu.anchorView?.plainView.bounds.height)!)
        if filteresDetailsArray.count == 0 {
            filteresDetailsArray = beneficiariesArray.compactMap{
                $0.beneficiaryAccountNo
            }
        }
        menu.dataSource = filteresDetailsArray
        menu.show()
        // Action triggered on selection
        menu.selectionAction = { (index: Int, item: String) in
            textField.text = item
        }
    }
    

}




