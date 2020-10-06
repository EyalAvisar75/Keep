//
//  MainController.swift
//  NewKeep
//
//  Created by eyal avisar on 04/10/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

extension MainController: NotesLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        return calculateLabelSize(indexPath: indexPath)
    }
    
  func collectionView(
      _ collectionView: UICollectionView,
      heightForLabelAtIndexPath indexPath:IndexPath) -> CGFloat {
    return calculateLabelSize(indexPath: indexPath)
  }
}

class MainController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var createNoteButton: UIButton!
    @IBOutlet weak var notesCollection: UICollectionView!
    var noteToEdit = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesCollection.delegate = self
        notesCollection.dataSource = self
        
        if let layout = notesCollection?.collectionViewLayout as? NotesLayout {
          layout.delegate = self
        }

        notesCollection?.backgroundColor = .clear
        notesCollection?.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
    }

    override func viewDidAppear(_ animated: Bool) {
        print("items in collection view")
        print(notesCollection.numberOfItems(inSection: 0))
        notesCollection.reloadData()
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        notesCollection.collectionViewLayout.invalidateLayout()
//    }
    
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        var text = "\(notes[indexPath.row].title!)\n"
//        text += "\(notes[indexPath.row].content!)"
//
//        let label = UILabel()
//        label.text = text
//        label.numberOfLines = 0
//        label.textAlignment = .left
//        label.font = UIFont.systemFont(ofSize: 20)
//        var height = max(label.intrinsicContentSize.height * 2, 70)
//        height = min(height, view.frame.height / 2.0)
//
//        return CGSize(width: view.frame.width / 2 - 5 , height: height + 5)
//        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
//        return CGSize(width: itemSize, height: itemSize)
//    }
    
    //MARK: IBAction
    @IBAction func writeNote(_ sender: UIButton) {
        guard let noteMaker = storyboard?.instantiateViewController(withIdentifier: "WriteNote") as? NoteController else { return } 
        
        noteMaker.noteToEdit = noteToEdit
        noteToEdit = -1
        navigationController?.pushViewController(noteMaker, animated: true)
    }
    
    
    //MARK: helper functions
    
    func calculateLabelSize(indexPath:IndexPath) -> CGFloat {
        var text = "\(notes[indexPath.row].title!)\n"
        text += "\(notes[indexPath.row].content!)"
        
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        var labelHeight = max(label.intrinsicContentSize.height * 2, 70)
        labelHeight = min(labelHeight, view.frame.height / 2.0)
        
        print("height calculated: \(labelHeight)")
        return labelHeight
    }
}
