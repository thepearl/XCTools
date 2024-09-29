//
//  Shell.swift
//
//
//  Created by Ghazi Tozri on 29/09/2024.
//

import Foundation

func shell(_ command: String, _ arguments: String...) throws -> String {
    let task = Process()
    let pipe = Pipe()

    task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    task.arguments = [command] + arguments
    task.standardOutput = pipe
    task.standardError = pipe

    try task.run()

    let data = try pipe.fileHandleForReading.readToEnd() ?? Data()
    let output = String(decoding: data, as: UTF8.self).trimmingCharacters(in: .whitespacesAndNewlines)

    task.waitUntilExit()

    guard task.terminationStatus == 0 else {
        throw ShellError.taskFailed(terminationStatus: task.terminationStatus, output: output)
    }

    return output
}
