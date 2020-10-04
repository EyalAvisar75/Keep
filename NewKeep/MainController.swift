//
//  MainController.swift
//  NewKeep
//
//  Created by eyal avisar on 04/10/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func writeNote(_ sender: UIButton) {
        guard let noteMaker = storyboard?.instantiateViewController(withIdentifier: "WriteNote") as? NoteController else { return } 
        
        navigationController?.pushViewController(noteMaker, animated: true)
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
