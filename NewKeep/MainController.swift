//
//  MainController.swift
//  NewKeep
//
//  Created by eyal avisar on 04/10/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

class MainController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var createNoteButton: UIButton!
    @IBOutlet weak var notesCollection: UICollectionView!
    var noteToEdit = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesCollection.delegate = self
        notesCollection.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        notesCollection.reloadData()
    }
    
    //MARK: collectionView datasource + delegate + flowlayout
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCollectionCell
                
        var text = "\(notes[indexPath.row].title!)\n"
        text += "\(notes[indexPath.row].content!)"
        print("text: \(text)")
        cell.noteLabel.text = text
        cell.noteLabel.textAlignment = .left
        cell.backgroundColor = .yellow
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        noteToEdit = indexPath.row
        writeNote(createNoteButton)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var text = "\(notes[indexPath.row].title!)\n"
        text += "\(notes[indexPath.row].content!)"
        
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        var height = max(label.intrinsicContentSize.height * 2, 70)
        height = min(height, view.frame.height / 2.0)
    
        return CGSize(width: view.frame.width / 2 - 5 , height: height + 5)
    }
    
    //MARK: IBAction
    @IBAction func writeNote(_ sender: UIButton) {
        guard let noteMaker = storyboard?.instantiateViewController(withIdentifier: "WriteNote") as? NoteController else { return } 
        
        noteMaker.noteToEdit = noteToEdit
        noteToEdit = -1
        navigationController?.pushViewController(noteMaker, animated: true)
    }
    
}
