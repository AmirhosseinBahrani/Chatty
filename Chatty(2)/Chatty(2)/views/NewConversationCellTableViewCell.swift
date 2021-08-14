//
//  NewConversationCellTableViewCell.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/28/21.
//

import UIKit

class NewConversationCellTableViewCell: UITableViewCell {
    static let identifier = "NewConversationCell"
    private let userImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = 35
        imageview.layer.borderWidth = 2
    
        imageview.layer.masksToBounds = true
        return imageview
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        return label
    }()
    


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(userImageView)
        contentView.addSubview(usernameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageView.frame = CGRect(x: 10,
                                     y: 10,
                                     width: 70,
                                     height: 70)
        usernameLabel.frame = CGRect(x: userImageView.right + 10,
                                     y: 20,
                                     width: contentView.width - 20 - userImageView.width,
                                     height: 50)
        
        
    }
//    public func configure(with model: SearchResult){
//        self.usernameLabel.text = model.name
//        let path = "images/\(model.email)_profilepictureFilename.png"
//        StorageManager.shared.downloadurl(for: path, complection: {[weak self]result in
//            switch result{
//            case .success(let url):
//
//                self?.userImageView.sd_setImage(with: url, completed: nil)
//
//
//
//                
//            case .failure(let error):
//                print(path)
//                print("failed to get image url:\(error)")
//            }
//        })
//    }
    

}
