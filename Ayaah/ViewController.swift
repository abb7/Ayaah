//
//  ViewController.swift
//  Ayaah
//
//  Created by Abb on 3/28/1438 AH.
//  Copyright © 1438 Abb. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sendNotiButton: UIButton!
    @IBOutlet weak var notiLabel: UILabel!
    
    @IBAction func sendTheNotification() {
        let content = UNMutableNotificationContent()
        content.title = "آية اليوم"
        //content.subtitle = "تبارك الله أحسن الخالقين"
        content.body = "هو الله الذي لا إله إلا هو الحي القيوم"
        content.badge = 1       // it means that the app will put 1 on the Icon badge
        content.categoryIdentifier = "readingCategory"
        
        
        content.sound = UNNotificationSound.default()
        
        //let url = Bundle.main.url(forResource: "Images/1231w", withExtension: "gif")
       // let attachement = UNNotificationAttachment(identifier: "آيات", url: <#T##URL#>, options: nil)
        
        content.attachments = []
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let requestIdent = "آيات"
        let  request = UNNotificationRequest(identifier: requestIdent, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
//            if error != nil {
//                return
//            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate? = self
        // Do any additional setup after loading the view, typically from a nib.
        }


}

//to handle notification in app
extension ViewController : UNUserNotificationCenterDelegate {
    
     func userNotificationCenter(_ : UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //if the notification fired up while the app is open ....
        print("THIS HAS BEEN EXCUTETED!!!!!!")
        completionHandler([.alert,.sound])
    }
    
    
    func userNotificationCenter(_: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "done":
            self.imageView.image = UIImage(named: "Wrong")
            
        case "later":
            self.imageView.image = UIImage(named: "Right")
            self.notiLabel.text = "You chosse later, homie!"
        case "more":
            let alert = UIAlertController(title: "Hint", message: "the ansere is greater than 29", preferredStyle: .alert)
            let action = UIAlertAction(title: "Thanks", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        default:
            break
        }
    }
}

