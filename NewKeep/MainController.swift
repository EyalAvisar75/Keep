//
//  MainController.swift
//  NewKeep
//
//  Created by eyal avisar on 04/10/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    var screenY = 150
    var leftHeight = 150
    var rightHeight = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
   }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        
        for v in view.subviews{
           if v is UILabel{
              v.removeFromSuperview()
           }
        }
        
        screenY = 150
        leftHeight = 150
        rightHeight = 150
        
        print("viewWillLayoutSubviews")
        showNotes()

    }
    
    @IBAction func writeNote(_ sender: UIButton) {
        guard let noteMaker = storyboard?.instantiateViewController(withIdentifier: "WriteNote") as? NoteController else { return } 
        
        navigationController?.pushViewController(noteMaker, animated: true)
    }
    
    func showNotes() {
        for note in notes {
            var text = "\(note.title!)\n"
            text += "\(note.content!)"

            
            var left = 0
            if leftHeight > rightHeight {
                left = Int(view.frame.width / 2.0 + 10)
            }
            
            let label = UILabel()
            label.text = text
            label.numberOfLines = 0
            label.textAlignment = .left
            label.font = UIFont.systemFont(ofSize: 20)
            var height = max(label.intrinsicContentSize.height * 2, 70)
            height = min(height, view.frame.height / 2.0)
            label.frame = CGRect(x:CGFloat(left),y:CGFloat(screenY),width: view.frame.width / 2.0 - 10, height: height)

            label.textColor = .white
            label.backgroundColor = .lightGray//If required

            label.widthAnchor.constraint(equalToConstant: view.frame.width / 2.0 - 10).isActive = true

            view.addSubview(label)
            if rightHeight >= leftHeight {
                leftHeight += Int(label.frame.height) + 10
            }
            else {
                rightHeight += Int(label.frame.height) + 10
            }
            screenY = min(rightHeight, leftHeight)
            
//            print("left \(left)")
//            print("leftHeight \(leftHeight)")
//            print("rightHeight \(rightHeight)")
//            print("screenY \(screenY)")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
