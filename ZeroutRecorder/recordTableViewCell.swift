//
//  recordTableViewCell.swift
//  ZeroutRecorder
//
//  Created by hulin on 2017/6/3.
//  Copyright © 2017年 hulin. All rights reserved.
//

import UIKit

class recordTableViewCell: UITableViewCell {

    @IBOutlet weak var recordFileName: UILabel!
    
    @IBOutlet weak var recordTime: UILabel!

    @IBOutlet weak var recordImage: UIImageView!
    
    @IBOutlet weak var GoToButton: UIButton!
    
    @IBOutlet weak var recordLength: UILabel!
    
    var record : aRecord?{
        didSet{
            updateUI()
        }
    }
    private func updateUI()
    {
        if let tempRecord = record{
            recordFileName.text = tempRecord.getName()
            recordTime.text = tempRecord.getTime()
            recordLength.text = tempRecord.getLength() + " s"
        }
    }
}
