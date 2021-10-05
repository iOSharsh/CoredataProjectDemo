//
//  ViewController.swift
//  CoredataProjectDemo
//
//  Created by mac on 27/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableViewShowData: UITableView!
    var arrEmploye = [EmployeDetails]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        arrEmploye = CoreDataSaveFetchData.sharedInstant.fetchData()
        tableViewShowData.reloadData()
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        
       
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(signUp, animated: true)
        
        
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrEmploye.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataShowFileTableViewCell", for: indexPath) as! UserDataShowFileTableViewCell
        
        cell.nameLbl.text = arrEmploye[indexPath.row].name
        cell.mobileNoLabl.text = arrEmploye[indexPath.row].mobilenumber
        cell.imageVieww.image = UIImage(data: arrEmploye[indexPath.row].profile!)
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // let cell = tableview.cellForRow(at: indexPath)
        return 140
    }
   
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            // create the alert
                   let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete data?", preferredStyle: UIAlertController.Style.alert)

                   // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler:
                                            {_ in ()
                    
                self.arrEmploye = CoreDataSaveFetchData.sharedInstant.deleteData(index: indexPath.row)
                self.tableViewShowData.deleteRows(at: [indexPath], with: .automatic)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

                   // show the alert
                   self.present(alert, animated: true, completion: nil)
            
            success(true)
    })
        deleteAction.backgroundColor = .red
        
    let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeAction.performsFirstActionWithFullSwipe = false // This is the line which disables full swipe
   return swipeAction
  
  }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
            
            
            let signUpVc = self.storyboard!.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            signUpVc.coreObj = self.arrEmploye[indexPath.row]
            signUpVc.i = indexPath.row
           
            self.navigationController?.pushViewController(signUpVc, animated: true)
        })
        editAction.backgroundColor = .blue
        let swipeAction = UISwipeActionsConfiguration(actions: [editAction])
            swipeAction.performsFirstActionWithFullSwipe = false // This is the line which disables full swipe
            return swipeAction
        
    }
    
    
}

