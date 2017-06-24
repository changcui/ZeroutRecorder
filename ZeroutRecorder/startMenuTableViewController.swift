//
//  startMenuTableViewCell.swift
//  ZeroutRecorder
//
//  Created by hulin on 2017/6/3.
//  Copyright © 2017年 hulin. All rights reserved.
//

import UIKit

class startMenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      //  tableView.estimatedRowHeight = tableView.rowHeight
      //  tableView.rowHeight = UITableViewAutomaticDimension
        records.removeAll()
        tableView.reloadData()
   /*     for rec in RecFileTable.fileTable
        {
            insertRecord([rec])
        }*/
    }
   // public var RecFileTable = recordFileTable()
    
    private var records = [Array<aRecord>]()
    
    public var recordArrays : NSMutableArray = NSMutableArray.init()
    
    
    func insertRecord ( _ newRecords: [aRecord])
    {
        self.records.insert(newRecords, at: 0)
        self.tableView.insertSections([0], with: .fade)
       // tableView.reloadData()
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        print ("\(recordArrays.count)")
        if recordArrays.count != 0{
            for rec in recordArrays
            {
                insertRecord([rec as! aRecord])
            }
 
        }
        recordArrays.removeAllObjects()
        self.refreshControl?.endRefreshing()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return records.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records[section].count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath)
        let record : aRecord = records[indexPath.section][indexPath.row]
        if let recordCell = cell as? recordTableViewCell {
            recordCell.record = record
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "\(records.count-section)"
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let rVC = segue.destination as? recordViewController
        {
          //  rVC.recFileTable = RecFileTable
            if segue.identifier == "newRecordSegue" {
                rVC.playMode = false
                recordArrays.removeAllObjects()
                rVC.recordArrays = recordArrays
            }
            else if segue.identifier == "playRecordSegue"{
                rVC.playMode = true
                recordArrays.removeAllObjects()
                rVC.recordArrays = recordArrays
                if let button = sender as? UIButton{
                    if let curCell = button.superview?.superview as? recordTableViewCell{
                        rVC.curRecord = curCell.record;
                        print ("record send success")
                    }
                }
            }
        }
    }

}
