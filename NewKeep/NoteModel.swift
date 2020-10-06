//
//  NoteModel.swift
//  NewKeep
//
//  Created by eyal avisar on 04/10/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import Foundation

struct Note {
    var title:String?
    var content:String?
}

var notes = [Note]()

func addNote(note:Note?) {
    guard let note = note else { return }
    
    notes.append(note)
}

func printNotes() {
    for (index, note) in notes.enumerated() {
        print("\(index), \(note.title), \(note.content)")
    }
    print(notes.count)
}

func writeNote(title:String?, content:String?, noteToEdit:Int = -1) {
    let title = title ?? ""
    let content = content ?? ""
    
    if title == "" && content == "" {
        if noteToEdit != -1 {
            notes.remove(at: noteToEdit)
        }
        return
    }
    
    let note = Note(title: title, content: content)
    
    if noteToEdit != -1 {
        notes[noteToEdit] = note
    }
    else {
        addNote(note: note)
    }
    
    printNotes()
}


