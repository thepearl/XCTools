//
//  RemoveDD.swift
//  
//
//  Created by Ghazi Tozri on 29/09/2024.
//

import Foundation
import ArgumentParser
import Rainbow

struct RemoveDD: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "remove-dd",
        abstract: "Remove derived data"
    )

    @Option(name: .shortAndLong, help: "Custom path for derived data")
    var path: String?

    @Flag(name: .shortAndLong, help: "Clean the project after removing derived data")
    var clean: Bool = false

    func run() async throws {
        let fileManager = FileManager.default
        let derivedDataPath = path ?? "~/Library/Developer/Xcode/DerivedData"
        let expandedPath = NSString(string: derivedDataPath).expandingTildeInPath

        print("Removing derived data from: ".blue + expandedPath.yellow)

        do {
            if fileManager.fileExists(atPath: expandedPath) {
                try fileManager.removeItem(atPath: expandedPath)
                print("Successfully removed derived data.".green)
            } else {
                print("Derived data folder does not exist at the specified path.".yellow)
            }
        } catch {
            print("Error removing derived data: ".red + error.localizedDescription)
        }

        if clean {
            print("Cleaning the project...".blue)
            do {
                let output = try shell("xcodebuild", "-alltargets", "clean")
                print("Project cleaned successfully.".green)
                print(output)
            } catch {
                print("Error cleaning the project: ".red + error.localizedDescription)
            }
        }
    }
}
