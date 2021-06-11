//
//  FileHelper.swift
//  Nine Algorithms That Changed the Future
//
//  Created by 윤태민 on 6/9/21.
//

import Foundation

// https://medium.com/@CoreyWDavis/reading-writing-and-deleting-files-in-swift-197e886416b0
func readFileFromDesktop(fileName: String) -> String? {
    let directoryURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)[0]
    let fileURL = URL(fileURLWithPath: fileName, relativeTo: directoryURL).appendingPathExtension("txt")
    
    var res: String?
    
    do {
        let data = try Data(contentsOf: fileURL)
        if let str = String(data: data, encoding: .utf8) {
            res = str
        }
    } catch {
        print("Unable to read the file")
    }
    
    return res
}

func saveFileIntoDesktop(fileName: String, contents: String) {
    let directoryURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)[0]
    print(directoryURL)
    let fileURL = URL(fileURLWithPath: fileName, relativeTo: directoryURL).appendingPathExtension("txt")
    
    guard let data = contents.data(using: .utf8) else {
        print("Unalbe to convert string to data")
        return
    }

    do {
        try data.write(to: fileURL)
        print("File saved: \(fileURL.absoluteURL)")
    } catch {
        print(error.localizedDescription)
    }
}
