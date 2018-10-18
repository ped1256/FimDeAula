//
//  SchedulingCollection.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 14/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import UIKit

protocol SchedulingDaysCollectionDelegate {
    func didSelectScheduling(schedulingSection: SchedulingSection, value: String)
}

class SchedulingCollection: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var daysCollectioView: UICollectionView?
    var cellSelectedIndex: Int = -1
    var section: SchedulingSection = .days {
        didSet {
            daysCollectioView?.reloadData()
        }
    }
    var delegate: SchedulingDaysCollectionDelegate?
    
    static var identifier = "calendarDaysViewIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 96, height: 42)
        layout.headerReferenceSize = layout.itemSize
        
        self.daysCollectioView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        guard let daysCollectioView = daysCollectioView else { return }
        daysCollectioView.delegate = self
        daysCollectioView.dataSource = self
        
        self.addSubview(daysCollectioView)
        
        daysCollectioView.register(DaysCell.self, forCellWithReuseIdentifier: DaysCell.identifier)
        
        daysCollectioView.translatesAutoresizingMaskIntoConstraints = false
        daysCollectioView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -90).isActive = true
        daysCollectioView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        daysCollectioView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        daysCollectioView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        daysCollectioView.backgroundColor = ThemeColor.shared.tableViewBackgroundColor
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.section {
        case .days:
            return 7
        case .hour:
            return 7
        case .space:
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysCell.identifier, for: indexPath) as? DaysCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == cellSelectedIndex {
            cell.contentView.backgroundColor = .white
            cell.titleLabel.textColor = ThemeColor.shared.secondaryTextColor
        }
        
        switch self.section {
        case .days:
            switch indexPath.row {
            case 0:
                cell.titleLabel.text = "Segunda"
            case 1:
                cell.titleLabel.text = "Terça"
            case 2:
                cell.titleLabel.text = "Quarta"
            case 3:
                cell.titleLabel.text = "Quinta"
            case 4:
                cell.titleLabel.text = "Sexta"
            case 5:
                cell.titleLabel.text = "Sabado"
            case 6:
                cell.titleLabel.text = "Domingo"
            default:
                break
            }
        case .hour:
            switch indexPath.row {
            case 0:
                cell.titleLabel.text = "19:00"
            case 1:
                cell.titleLabel.text = "19:30"
            case 2:
                cell.titleLabel.text = "20:00"
            case 3:
                cell.titleLabel.text = "21:30"
            case 4:
                cell.titleLabel.text = "22:00"
            case 5:
                cell.titleLabel.text = "22:30"
            case 6:
                cell.titleLabel.text = "23:00"
            default:
                break
            }
        case .space:
            switch indexPath.row {
            case 0:
                cell.titleLabel.text = "1 vaga"
            case 1:
                cell.titleLabel.text = "2 vagas"
            case 2:
                cell.titleLabel.text = "3 vagas"
            case 3:
                cell.titleLabel.text = "4 vagas"
            default:
                break
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DaysCell else { return }
        cellSelectedIndex = indexPath.row
        
        cell.contentView.backgroundColor = .white
        cell.titleLabel.textColor = ThemeColor.shared.secondaryTextColor
        cellSelectedIndex = indexPath.row
        collectionView.reloadData()
        
        if let value = cell.titleLabel.text {
            delegate?.didSelectScheduling(schedulingSection: self.section, value: value)
        }
    }
}
