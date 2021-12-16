//
//  File.swift
//  
//
//  Created by Dardo Mansilla on 01/12/2021.
//

import UIKit
import SafariServices

public class TestLoginViewController: UIViewController {
    
    @IBOutlet weak var myLabel: LNTappableLabel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupTermsAndContitionsLabel()
    }
    
    public static func instantiate() -> TestLoginViewController {
        let storyboard = UIStoryboard(name: "TestLoginViewController", bundle: Bundle.module)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "TestLoginViewController") as? TestLoginViewController {
            return viewController
        } else {
            return TestLoginViewController()
        }
    }
    
    private func setupTermsAndContitionsLabel() {
        let text = "Please agree for Terms & Conditions."
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Terms & Conditions.")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range1)
        myLabel?.attributedText = underlineAttriString
        myLabel?.setupTappableLabel(textToTap: "Terms & Conditions.", handleTap: {
            self.present(SFSafariViewController(url: URL(string: "https://google.com") ?? URL(fileURLWithPath: "")), animated: true, completion: nil)
        })
        
    }
    
}
//MARK: - Extensions
extension UIStoryboard {
    
    static func instantiate(viewController viewControllerName: String) -> UIViewController {
        return UIStoryboard(name: viewControllerName, bundle: Bundle.module).instantiateViewController(withIdentifier: viewControllerName)
    }

}

extension UIViewController {
    
    static func instantiateFromStoryboard() -> Self {
        return UIStoryboard.instantiate(viewController: String(describing: self)) as! Self
    }
}
