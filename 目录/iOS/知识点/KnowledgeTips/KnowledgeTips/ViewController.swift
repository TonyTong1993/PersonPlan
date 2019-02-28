//
//  ViewController.swift
//  KnowledgeTips
//
//  Created by ZZHT on 2018/5/3.
//  Copyright © 2018年 ZZHT. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

   
    private var dataSource: [[String:Any]]?
    private let reuseIdentifier = "UITableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(type(of: UITableViewCell()), forCellReuseIdentifier: reuseIdentifier)
        
        var data: Data?
        
        if let url = Bundle.main.url(forResource: "testItem.plist", withExtension: nil){
            do {
                data = try  Data(contentsOf: url)
            }catch(let error) {
                assert(false, error.localizedDescription)
            }
        }
        
        if let data = data {
            do {
               
                dataSource = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [[String:Any]]
            }catch(let error) {
                 assert(false, error.localizedDescription)
            }
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let item = dataSource![indexPath.row]
        let useCase = item["case"] as! String
        
        cell.textLabel?.text = useCase
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "KeyLayout")
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

