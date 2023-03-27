//
//  MainTableViewCell.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    private let taskLbl = UILabel()
    private let titleLbl = UILabel()
    private let descriptionLbl = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleUI()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func styleUI(){
        
        taskLbl.configureStyle(size: 12, weight: .regular, color: .black)

        titleLbl.configureStyle(size: 20, weight: .bold, color: .black)

        descriptionLbl.configureStyle(size: 12, weight: .regular, color: .black)
        descriptionLbl.numberOfLines = 2

        
    }
    
    private func layoutUI(){
        
        contentView.addSubview(taskLbl)
        
        taskLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
        }
        
        contentView.addSubview(titleLbl)
        
        titleLbl.snp.makeConstraints { make in
            make.left.equalTo(taskLbl.snp.left)
            make.right.equalToSuperview()
            make.bottom.equalTo(taskLbl.snp.top).offset(-10)
        }
        
        contentView.addSubview(descriptionLbl)
        
        descriptionLbl.snp.makeConstraints { make in
            make.left.equalTo(taskLbl.snp.left)
            make.right.equalToSuperview()
            make.top.equalTo(taskLbl.snp.bottom).offset(10)
            
        }
    
    }
    
    func setup(task:TaskResponse){
        
        titleLbl.text = task.title
        taskLbl.text = task.task
        descriptionLbl.text = task.description
        backgroundColor = UIColor.init(hexString: task.colorCode)
    }
}
