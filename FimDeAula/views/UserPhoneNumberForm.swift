//
//  UserPhoneNumberForm.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 27/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

protocol UserPhoneNumberFormDelegate {
    func didTouchAcceptButton(value: String)
}

class UserPhoneNumberForm: UIView {
    var modalView = UIView()
    var textMessageLabel = UILabel()
    var numberBackground = UIView()
    let centerFieldsView = UIView()
    let dddFieldBackground = UIView()
    var dddField = UITextField()
    var numberField = UITextField()
    var imageView = UIImageView()
    var confirmButton = UIButton()
    var declineButton = UIButton()
    var modalViewYconstraint: NSLayoutConstraint!
    var shouldUpdateLayout = true
    var delegate: UserPhoneNumberFormDelegate?
    
    func buildUI(){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.alpha = 0.0
        buildModalView()
        buildTextMessageLabel()
        buildImageview()
        buildNumberBackground()
        buildDDDField()
        buildNumberField()
        buildConfirmButton()
        buildDeclineButton()
        
        UIView.animate(withDuration: 0.7) {
            self.alpha = 1.0
        }
    }
    
    func buildModalView(){
        self.addSubview(modalView)
        modalView.backgroundColor = .white
        modalView.layer.cornerRadius = 10
        modalView.clipsToBounds = true
        modalView.translatesAutoresizingMaskIntoConstraints = false
        modalView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        modalViewYconstraint = modalView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        modalViewYconstraint.isActive = true
        modalView.heightAnchor.constraint(equalToConstant: 408).isActive = true
        modalView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        modalView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
    }
    
    func buildTextMessageLabel() {
        modalView.addSubview(textMessageLabel)
        textMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        textMessageLabel.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 10).isActive = true
        textMessageLabel.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -10).isActive = true
        textMessageLabel.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 10).isActive = true
        textMessageLabel.text = "Precisamos que forneça o seu Numero de Telefone para que sua carona possa se comunicar"
        textMessageLabel.textColor = #colorLiteral(red: 0.3568627451, green: 0.3568627451, blue: 0.3568627451, alpha: 1)
        textMessageLabel.textAlignment = .center
        textMessageLabel.numberOfLines = 0
        textMessageLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
    func buildImageview(){
        modalView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.topAnchor.constraint(equalTo: textMessageLabel.bottomAnchor, constant: 20).isActive = true
        imageView.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        imageView.image = #imageLiteral(resourceName: "whatsaapLogo")
    }
    
    func buildNumberBackground() {
        modalView.addSubview(numberBackground)
        numberBackground.translatesAutoresizingMaskIntoConstraints = false
        numberBackground.leftAnchor.constraint(equalTo: modalView.leftAnchor).isActive = true
        numberBackground.rightAnchor.constraint(equalTo: modalView.rightAnchor).isActive = true
        numberBackground.heightAnchor.constraint(equalToConstant: 55).isActive = true
        numberBackground.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        numberBackground.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
    }
    
    func buildDDDField(){
        modalView.addSubview(centerFieldsView)
        centerFieldsView.translatesAutoresizingMaskIntoConstraints = false
        centerFieldsView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        centerFieldsView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        centerFieldsView.backgroundColor = .clear
        centerFieldsView.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        centerFieldsView.centerYAnchor.constraint(equalTo: numberBackground.centerYAnchor).isActive = true
        
        modalView.addSubview(dddFieldBackground)
        dddFieldBackground.translatesAutoresizingMaskIntoConstraints = false
        dddFieldBackground.widthAnchor.constraint(equalToConstant: 60).isActive = true
        dddFieldBackground.heightAnchor.constraint(equalToConstant: 36).isActive = true
        dddFieldBackground.centerYAnchor.constraint(equalTo: numberBackground.centerYAnchor).isActive = true
        dddFieldBackground.leftAnchor.constraint(equalTo: centerFieldsView.leftAnchor, constant: 0).isActive = true
        dddFieldBackground.backgroundColor = .white
        dddFieldBackground.clipsToBounds = true
        dddFieldBackground.layer.cornerRadius = 6
        
        modalView.addSubview(dddField)
        dddField.translatesAutoresizingMaskIntoConstraints = false
        dddField.widthAnchor.constraint(equalToConstant: 40).isActive = true
        dddField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        dddField.centerYAnchor.constraint(equalTo: dddFieldBackground.centerYAnchor).isActive = true
        dddField.centerXAnchor.constraint(equalTo: dddFieldBackground.centerXAnchor).isActive = true
        dddField.backgroundColor = .white
        dddField.keyboardType = .numberPad
        dddField.delegate = self
        
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(string: "DDD", attributes: [NSAttributedStringKey.paragraphStyle: centeredParagraphStyle])
        dddField.attributedPlaceholder = attributedPlaceholder
        dddField.attributedPlaceholder = attributedPlaceholder
    }
    
    func buildNumberField() {
        let numberFieldBackground = UIView()
        modalView.addSubview(numberFieldBackground)
        numberFieldBackground.translatesAutoresizingMaskIntoConstraints = false
        numberFieldBackground.widthAnchor.constraint(equalToConstant: 130).isActive = true
        numberFieldBackground.heightAnchor.constraint(equalToConstant: 36).isActive = true
        numberFieldBackground.centerYAnchor.constraint(equalTo: numberBackground.centerYAnchor).isActive = true
        numberFieldBackground.rightAnchor.constraint(equalTo: centerFieldsView.rightAnchor, constant: 0).isActive = true
        numberFieldBackground.backgroundColor = .white
        numberFieldBackground.clipsToBounds = true
        numberFieldBackground.layer.cornerRadius = 6
        
        modalView.addSubview(numberField)
        numberField.translatesAutoresizingMaskIntoConstraints = false
        numberField.widthAnchor.constraint(equalToConstant: 110).isActive = true
        numberField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        numberField.centerYAnchor.constraint(equalTo: numberFieldBackground.centerYAnchor).isActive = true
        numberField.centerXAnchor.constraint(equalTo: numberFieldBackground.centerXAnchor).isActive = true
        numberField.backgroundColor = .white
        numberField.keyboardType = .numberPad
        numberField.tag = 1
        
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(string: "Número", attributes: [NSAttributedStringKey.paragraphStyle: centeredParagraphStyle])
        numberField.attributedPlaceholder = attributedPlaceholder
        numberField.attributedPlaceholder = attributedPlaceholder
    }
    
    func buildConfirmButton() {
        modalView.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        confirmButton.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -20).isActive = true
        confirmButton.topAnchor.constraint(equalTo: numberBackground.bottomAnchor, constant: 30).isActive = true
        confirmButton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7215686275, blue: 0.4156862745, alpha: 1)
        confirmButton.setImage(#imageLiteral(resourceName: "nextIcon"), for: .normal)
        confirmButton.clipsToBounds = true
        confirmButton.layer.cornerRadius = 30
        confirmButton.addTarget(self, action: #selector(acceptAction(_ :)), for: .touchUpInside)
    }
    
    func buildDeclineButton() {
        modalView.addSubview(declineButton)
        declineButton.translatesAutoresizingMaskIntoConstraints = false
        declineButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        declineButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        declineButton.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 20).isActive = true
        declineButton.topAnchor.constraint(equalTo: numberBackground.bottomAnchor, constant: 30).isActive = true
        declineButton.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        declineButton.setImage(#imageLiteral(resourceName: "declineButton"), for: .normal)
        declineButton.clipsToBounds = true
        declineButton.layer.cornerRadius = 30
        declineButton.addTarget(self, action: #selector(declineAction(_:)), for: .touchUpInside)
    }
    
    @objc func declineAction(_ sender: Any){
        UIView.animate(withDuration: 0.5, animations: {
        self.alpha = 0.0
        }) { finished in
            self.removeFromSuperview()
        }
    }
    
    @objc func acceptAction(_ sender: Any){
        guard let ddd = dddField.text, let number = numberField.text else { return }
        let fullNumber = ddd+number
        delegate?.didTouchAcceptButton(value: fullNumber)
        self.removeFromSuperview()
    }
}

extension UserPhoneNumberForm: UITextFieldDelegate {
 
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard shouldUpdateLayout == true else { return }
        
        UIView.animate(withDuration: 1.0) {
            if App().isIphoneSE() {
                self.modalViewYconstraint.constant = -140
                self.textMessageLabel.isHidden = true
            } else {
                self.modalViewYconstraint.constant = -100
                self.shouldUpdateLayout = false
            }
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count == 2 {
            let nextTag = textField.tag + 1
            
            if let nextResponder = textField.superview?.viewWithTag(nextTag) {
                nextResponder.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            return true
        }
        
        return true
    }
}
