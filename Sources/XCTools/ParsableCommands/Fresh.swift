//
//  Fresh.swift
//  
//
//  Created by Ghazi Tozri on 29/09/2024.
//

import Foundation
import ArgumentParser
import Rainbow

struct Fresh: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "fresh",
        abstract: "Install pods and reset packages cache"
    )

    @Flag(name: .shortAndLong, help: "Also freshen SPM dependencies")
    var spm: Bool = false

    func run() async throws {
        print("Running: bundle exec install && bundle exec pod install".blue)

        do {
            let bundleOutput = try shell("bundle", "install")
            print("Bundle install completed successfully.".green)
            print(bundleOutput)

            let podOutput = try shell("bundle", "exec", "pod", "install")
            print("Pod install completed successfully.".green)
            print(podOutput)
        } catch {
            print("Error running tasks: ".red + error.localizedDescription)
        }

        if spm {
            print("Resolving package dependencies...".blue)
            do {
                let output = try shell("xcodebuild", "-resolvePackageDependencies")
                print("SPM dependencies resolved successfully.".green)
                print(output)
            } catch {
                print("Error resolving SPM dependencies: ".red + error.localizedDescription)
            }
        }
    }
}
