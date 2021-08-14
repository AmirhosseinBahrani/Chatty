//
//  ProfileViewController.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/23/21.
//

import UIKit



class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var models = [Sections]()

    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.value(forKey: "IsLoggedIn")) as! Bool == false && (UserDefaults.standard.value(forKey: "Status")) as! String == "NotLoggedIn" {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav,animated:  false)
        }
        
        navigationController?.navigationBar.topItem?.title = "Connecting"
//        if UserDefaults.standard.value(forKey: "IsLoggedIn") == nil {
//            Auth.auth.Checklogin(complection: {result in
//                if result {
//                    UserDefaults.standard.setValue(true, forKey: "IsLoggedIn")
//                    let vc = LoginViewController()
//                    let nav = UINavigationController(rootViewController: vc)
//                    nav.modalPresentationStyle = .fullScreen
//                    self.present(nav,animated:  false)
//                }
//            })
//        }else{
//            if UserDefaults.standard.value(forKey: "IsLoggedIn")! as! Bool == false {
//                Auth.auth.Checklogin(complection: {result in
//                    if result {
//                        UserDefaults.standard.setValue(true, forKey: "IsLoggedIn")
//                        let vc = LoginViewController()
//                        let nav = UINavigationController(rootViewController: vc)
//                        nav.modalPresentationStyle = .fullScreen
//                        self.present(nav,animated:  false)
//                    }
//                })
//            }
//        }
        navigationController?.navigationBar.topItem?.title = "Profile"
        
        configure()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.tableHeaderView = createTableHeader()
        // Do any additional setup after loading the view.
    }
    
    func configure(){
        models.append(Sections(title: "Information", options: [
            ProfileOptions(Title: "Username", Icon: UIImage(systemName: "person.crop.circle"), IconBGColor: .systemPink, handler: {
                print(UserDefaults.standard.value(forKey: "Username"))
                
            }),
            ProfileOptions(Title: "Password", Icon: UIImage(systemName: "lock.circle.fill"), IconBGColor: .systemRed, handler: {
                print(UserDefaults.standard.value(forKey: "password"))
            })
        ]))
        models.append(Sections(title: "Status", options: [
            ProfileOptions(Title: "Logout", Icon: UIImage(systemName: "house"), IconBGColor: .systemPink, handler: {}),
            ProfileOptions(Title: "Bluetooth", Icon: UIImage(systemName: ""), IconBGColor: .systemRed, handler: {}),
            ProfileOptions(Title: "Airplane mode", Icon: UIImage(systemName: "airplane"), IconBGColor: .systemGreen, handler: {})
        ]))
    }
    func createTableHeader() -> UIView?{
        
        
        let headerview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 100))
        headerview.backgroundColor = UIColor(red: 0, green: 0.1686, blue: 0.3098, alpha: 1.0)
        let imageview = UIImageView(frame: CGRect(x: (headerview.width-100) / 2, y: 8, width: 90, height: 90))
        imageview.contentMode = .scaleAspectFill
        
        imageview.backgroundColor = .systemBackground
        imageview.layer.borderColor = UIColor.white.cgColor
        imageview.layer.borderWidth = 3
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = imageview.width/2
        headerview.addSubview(imageview)
        
        StorageManager.shared.DownloadFiles(username: UserDefaults.standard.value(forKey: "Username") as! String, complection: {result in
            print(result)
            switch result{
            case .success(let ImageData):
                imageview.image = UIImage(data: ImageData)
            case .failure(let Error):
                print(Error)
            }
        })
        
        return headerview
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = models[section]
        return model.title
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileTableViewCell.identifier,
            for: indexPath
        ) as? ProfileTableViewCell else{
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        if model.Title == "Logout"{
            print("Logout")
            ServerManager.Shared.Logout(com: {re in
                if re{
                    let vc = LoginViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav,animated: true)
                }
            })
        }
    }
    
    
    


}
