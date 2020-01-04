//
//  MZTextField.swift
//  kiddo
//
//  Created by Mac on 12/30/19.
//  Copyright © 2019 spark-cloud. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 9.0, *)
public class ZValidTextField : UITextField {
  
    lazy var underlineView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = underlineColor
        return view
    }()
    
    lazy var errorLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.9305381179, green: 0.08601342887, blue: 0.2919492424, alpha: 1)
        label.lineBreakMode = .byWordWrapping
        label.text = ErrorMessage
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        if #available(iOS 10.0, *) {
            label.adjustsFontForContentSizeCategory = true
        } else {
            // Fallback on earlier versions
        }
        return label
    }()
    
    
    lazy var errorImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = errorImage
        return imageView
    }()
    
    
    public var errorImage : UIImage = #imageLiteral(resourceName: "danger")
    
    public var underlineColor : UIColor = #colorLiteral(red: 0.2929727733, green: 0.5950986743, blue: 0.7945949435, alpha: 1)
    public var ErrorMessage : String = "Default Error "
    
    public var isValid  : Bool = true {
        didSet{
            if isValid{
                textColor = UIColor.black
                errorLabel.removeFromSuperview()
                errorImageView.removeFromSuperview()
            }else{
                textColor = #colorLiteral(red: 0.9305381179, green: 0.08601342887, blue: 0.2919492424, alpha: 1)
                underlineView.backgroundColor = #colorLiteral(red: 0.9305381179, green: 0.08601342887, blue: 0.2919492424, alpha: 1)
                addErrorView()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
 
    public override func awakeFromNib(){
        super.awakeFromNib()
        addUnderLine()
    }
    

    @available(iOS 9.0, *)
    fileprivate func addErrorView(){
        addSubview(errorImageView)
        setConstraintsForErrorImageView()
        addSubview(errorLabel)
        setConstraintsForErrorLabel()
        // remove Error after 2 seconds
        setToInitialState()
    }
    
    
    fileprivate func setToInitialState(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[unowned self] in
              self.errorImageView.removeFromSuperview()
              self.errorLabel.removeFromSuperview()
              self.textColor = UIColor.black
              self.underlineView.backgroundColor = self.underlineColor
          }
    }

    @available(iOS 9.0, *)
    fileprivate func addUnderLine(){
        addSubview(underlineView)
        setConstraintsForUnderlineView()
    
    }
    
    @available(iOS 9.0, *)
    fileprivate func setConstraintsForUnderlineView(){
        NSLayoutConstraint.activate([
            underlineView.heightAnchor.constraint(equalToConstant: 0.7),
            underlineView.topAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            underlineView.widthAnchor.constraint(equalTo: widthAnchor),
            underlineView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    @available(iOS 9.0, *)
    fileprivate func  setConstraintsForErrorImageView(){
        NSLayoutConstraint.activate([
            errorImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            errorImageView.widthAnchor.constraint(equalToConstant: 25),
            errorImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    @available(iOS 9.0, *)
    fileprivate func setConstraintsForErrorLabel(){
        NSLayoutConstraint.activate([
            errorLabel.trailingAnchor.constraint(equalTo: errorImageView.leadingAnchor, constant: 5),
            errorLabel.widthAnchor.constraint(equalToConstant: 100),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorLabel.heightAnchor.constraint(equalToConstant: 50)
              ])
    }
}
