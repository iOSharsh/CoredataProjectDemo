//
//  SignUpViewController.swift
//  CoredataProjectDemo
//
//  Created by mac on 27/01/21.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var mobileNoTxtField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    var viewController: UIViewController?
    let imagePickerCon = UIImagePickerController()
    
    var imageData:Data?
    
    var coreObj:EmployeDetails?
    var i = Int()
    var isUpdate = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Circle Image and Txt Fields...
        imageView.layer.cornerRadius = imageView.frame.height/2
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = UIColor.lightText.cgColor
        
        circleTxtField(txt: nameTxtField)
        circleTxtField(txt: mobileNoTxtField)
        btnCircle(btn: submitBtn)
        
        //Check .....
        if coreObj != nil{
            self.nameTxtField.text = coreObj!.name
            self.mobileNoTxtField.text = coreObj!.mobilenumber
            self.imageView.image = UIImage(data: self.coreObj!.profile!)
            self.imageData = self.coreObj!.profile!
            isUpdate = true
        }
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.title = "\(coreObj?.name ?? "New User")"
        nameTxtField.delegate = self
        mobileNoTxtField.delegate = self
        self.mobileNoTxtField.addInputAccessoryView(title: "Done", target: self, selector: #selector(tapDone))
    }
    
    @objc func tapDone() {
        self.view.endEditing(true)
    }
    
    @IBAction func pushGallryBtn(_ sender: Any)
    {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default)
        { UIAlertAction in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                self.imagePickerCon.sourceType = UIImagePickerController.SourceType.camera
                self.imagePickerCon.delegate = self
                self.imagePickerCon.allowsEditing = true
                self.imagePickerCon.modalPresentationStyle = .fullScreen
                self.present(self.imagePickerCon, animated: true, completion: nil)
            }else
            {
                self.showAlert(title: "Warning", message: "You don't have camera")
                
            }
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            
            self.imagePickerCon.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.imagePickerCon.allowsEditing = true
            self.imagePickerCon.delegate = self
            self.imagePickerCon.modalPresentationStyle = .fullScreen
            self.present(self.imagePickerCon, animated: true, completion: nil)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        // Add the actions
        imagePickerCon.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func submitBtnAction(_ sender: Any)
    {
        var dict = [String:Any]()
        
        if let message  = validation()
        {
            showAlert(title: "Alert", message: message)
        }else if isUpdate
        {
            dict = ["name":nameTxtField.text!,"mobilenumber":mobileNoTxtField.text!,"profile":imageData!] as [String : Any]
            CoreDataSaveFetchData.sharedInstant.editData(object: dict as [String:Any], i: i)
            self.navigationController?.popViewController(animated: true)
        }else
        {
            dict = ["name":nameTxtField.text!,"mobilenumber":mobileNoTxtField.text!,"profile":imageData!] as [String : Any]
            CoreDataSaveFetchData.sharedInstant.saveInDatabase(object: dict as [String:Any])
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //Txt Field and Button style........
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTxtField.resignFirstResponder()
        mobileNoTxtField.resignFirstResponder()
        
        return true
    }
    
    func circleTxtField(txt:UITextField)  {
        txt.layer.cornerRadius = 18
        txt.layer.borderWidth = 2
        txt.layer.masksToBounds = true
        txt.layer.borderColor = UIColor.lightText.cgColor
        
    }
    func btnCircle(btn:UIButton)
    {
        btn.layer.cornerRadius = 18
        btn.layer.borderWidth = 2
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.lightText.cgColor
    }
    //validation..............
    func validation() -> String?
    {
        if (imageData == nil)
        {
            return "Please Select Profile"
        }else if nameTxtField.text!.isEmpty
        {
            return "Please Enter Name"
        }else if !validateUsername(str: nameTxtField.text!)
        {
            return "Please Enter Valid Name"
        }else if  mobileNoTxtField.text!.isEmpty
        {
            return "Please Enter Mobile Number"
        }else if !isValidPhone(testStr: mobileNoTxtField.text!)
        {
            return "Please Enter Valid Phone Number"
        }else
        {
            return nil
        }
    }
    func isValidPhone(testStr:String) -> Bool {
        let phoneRegEx = "^[1-9]\\d{9}$"
        let phoneNumber = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneNumber.evaluate(with: testStr)
    }
    
    func validateUsername(str: String) -> Bool
    {
        do
        {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z\\_[ ]]{4,30}$", options: .caseInsensitive)
            
            if regex.matches(in: str, options: [], range: NSMakeRange(0, str.count)).count > 0 {return true}
        }
        catch {}
        return false
    }
    
    //alert Function..........
    func showAlert(title:String,message:String) {
        
        let alert = UIAlertController(title: title,message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}


//Gallry Acces........

extension SignUpViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    //protocol method----
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("received..",info)
        picker.dismiss(animated: true, completion: nil)
        //get selected image
        let selectImage:UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        imageView.image=selectImage
        imageData = selectImage.pngData()!
    }
}
extension UITextField {
    
    func addInputAccessoryView(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
