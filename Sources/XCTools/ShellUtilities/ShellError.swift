//
//  ShellError.swift
//  
//
//  Created by Ghazi Tozri on 29/09/2024.
//

import Foundation

enum ShellError: Error {
    case taskFailed(terminationStatus: Int32, output: String)
}
