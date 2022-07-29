//
//  ViewController.swift
//  Fur Eternity
//
//  Created by Saif on 06/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    var viewControllers = NSMutableArray()
    @IBOutlet weak var topBarHeightCon: NSLayoutConstraint!
    @IBOutlet weak var tabBar: TabBarView!
    @IBOutlet weak var tabBarHeight: NSLayoutConstraint!
    @IBOutlet weak var topbarHeightCon: NSLayoutConstraint!
    var currentNavigation = UINavigationController()
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var topBar: TopBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewControllers=NSMutableArray.init()
        setUpTop()
        setUpTab()
        prepareForTab()
        didSelectTabAtIndex(_index: 0)
       
        
    }
    
    
    
    // MARK: - API Methods
    
 
    
    
    
 
    
    private func setUpTab(){
        
        tabBarHeight.constant = 65 + self.bottomPadding
        
        var img = #imageLiteral(resourceName: "Home")
        
        tabBar.addTabBtn(btnImage:img , btnText: "Home", btnIndex: 0)
        img = #imageLiteral(resourceName: "Market")
        tabBar.addTabBtn(btnImage:img , btnText: "Market", btnIndex: 1)
        img = #imageLiteral(resourceName: "Profile")
        //        tabBar.addTabBtn(btnImage:img , btnText: "Community", btnIndex: 2)
        //        img = #imageLiteral(resourceName: "Person")
        tabBar.addTabBtn(btnImage:img , btnText: "Profile", btnIndex: 2)
        
        for item in tabBar.tabBtnArray {
            
            let tabBtnView = item as! ButtonWithBadge
            
            tabBtnView.optionBtn.addTarget(self, action: #selector(tabBtnAction( _ :)), for: .touchUpInside)
        }
        
        
    }
    
    
    
    private func prepareForTab() {
        
        let homeViewController:HomeViewController = UIStoryboard(name: STORYBOARD_NAME, bundle: nil).instantiateViewController(withIdentifier: HOME) as! HomeViewController
        let homeBoardNavigationController = UINavigationController(rootViewController: homeViewController)
        viewControllers.insert(homeBoardNavigationController, at: viewControllers.count)
        
        let patternViewController:MarketViewController = UIStoryboard(name: STORYBOARD_NAME, bundle: nil).instantiateViewController(withIdentifier: MARKET) as! MarketViewController
        let patternNavigationController = UINavigationController(rootViewController: patternViewController)
        viewControllers.insert(patternNavigationController, at: viewControllers.count)
        
        let settingViewController: ProfileViewController = UIStoryboard(name: STORYBOARD_NAME, bundle: nil).instantiateViewController(withIdentifier: PROFILE) as! ProfileViewController
        let settingNavigationController = UINavigationController(rootViewController: settingViewController)
        viewControllers.insert(settingNavigationController, at: viewControllers.count)
        
    }
    
    private func setUpTop(){
        topbarHeightCon.constant = 55 + self.topPadding
        if UserSession.session.token != nil {
            topBar.userName.text = UserSession.session.username
            topBar.money.text =  UserSession.session.money! + "$"
            topBar.token.text = UserSession.session.gametoken
            //topbarHeightCon.constant = 0
        }
        
        topBar.walletBtn.addAction({
           // OpenScreenScript.openWallet()
        })
        
    }
    
    
    
    @objc func tabBtnAction(_ sender: Any){
        
        didSelectTabAtIndex(_index:(sender as! UIButton).tag )
        
    }
    
    
    private  func didSelectTabAtIndex(_index: Int) {

        
        for item in tabBar.tabBtnArray {
            
            let tabBtnView = item as! ButtonWithBadge
            
            if tabBtnView.optionBtn.tag == _index{
                tabBtnView.select()
            }
        }
        
        
        
        
        if (viewControllers[_index] as AnyObject) is UINavigationController  {
            for object  in viewControllers {
                if object is UINavigationController {
                    let navi =  object as! UINavigationController
                    navi.view.removeFromSuperview()
                }
                
            }
            topbarHeightCon.constant = 55 + self.topPadding
            let navigationController = viewControllers[_index] as! UINavigationController
            var temp = navigationController.view.frame
            temp.size.width=self.mainView.bounds.size.width
            temp.size.height=self.mainView.bounds.size.height
            navigationController.view.frame=temp
            if _index == 2 {
                self.mainView.insertSubview(navigationController.view, belowSubview: self.tabBar)
               // topbarHeightCon.constant = 0
                
            }
            else{
                self.mainView.insertSubview(navigationController.view, belowSubview: self.tabBar)
            }
            currentNavigation = navigationController
            
            return
        }
        
        
        
        switch _index {
        case 0:
            let dashViewController:HomeViewController = UIStoryboard(name: STORYBOARD_NAME, bundle: nil).instantiateViewController(withIdentifier: HOME) as! HomeViewController
            
            let dashBoardNavigationController = UINavigationController(rootViewController: dashViewController)
            
            self.mainView.insertSubview(dashBoardNavigationController.view, belowSubview: self.tabBar)
            self.addChild(dashBoardNavigationController)
            viewControllers.insert(dashBoardNavigationController, at: _index)
            currentNavigation = dashBoardNavigationController
            break
        case 1:
            let patternViewController:MarketViewController = UIStoryboard(name: STORYBOARD_NAME, bundle: nil).instantiateViewController(withIdentifier: MARKET) as! MarketViewController
            
            let patterdNavigationController = UINavigationController(rootViewController: patternViewController)
            
            self.mainView.insertSubview(patterdNavigationController.view, belowSubview: self.tabBar)
            self.addChild(patterdNavigationController)
            viewControllers.insert(patterdNavigationController, at: _index)
            currentNavigation = patterdNavigationController
            break
            
            
            
            
        default:
            
            let patternViewController:ProfileViewController = UIStoryboard(name: STORYBOARD_NAME, bundle: nil).instantiateViewController(withIdentifier: PROFILE) as! ProfileViewController
            
            let patterdNavigationController = UINavigationController(rootViewController: patternViewController)
            
            self.mainView.insertSubview(patterdNavigationController.view, belowSubview: self.tabBar)
            self.addChild(patterdNavigationController)
            viewControllers.insert(patterdNavigationController, at: _index)
            currentNavigation = patterdNavigationController
            break
            
            
            
        }
        
    }
    
    
}

