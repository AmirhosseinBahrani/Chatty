//
//  ProfileTableViewCell.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/28/21.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    static let identifier = "ProfileTableViewCell"
    
    private let IconImageView : UIImageView = {
        let imageview = UIImageView()
        
        imageview.tintColor = .white
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    private let IconContainer : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let Label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(Label)
        contentView.addSubview(IconContainer)
        contentView.addSubview(IconImageView)
        
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size : CGFloat = contentView.frame.size.height - 12
        IconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
        //IconImageView.center = IconContainer.center
        let ImgSize = size/1.25
        IconImageView.frame = CGRect(x: IconContainer.frame.width / 2, y: IconContainer.frame.origin.y + (size - ImgSize) - 5, width: ImgSize, height: ImgSize)
        
        Label.frame = CGRect(x: 20 + IconContainer.frame.size.width,
                             y: 0,
                             width: contentView.frame.size.width - 20 - IconContainer.frame.size.width ,
                             height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        IconImageView.image = nil
        Label.text = nil
        IconContainer.backgroundColor = nil
    }
    
    public func configure(with model: ProfileOptions){
        Label.text = model.Title
        IconImageView.image = model.Icon
        IconContainer.backgroundColor = model.IconBGColor
    }
    
}
