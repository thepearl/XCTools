//
//  Test.swift
//  
//
//  Created by Ghazi Tozri on 29/09/2024.
//

import Foundation
import ArgumentParser
import Rainbow

struct Test: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "test",
        abstract: "Launch a test plan"
    )

    @Option(name: .shortAndLong, help: "Target name")
    var target: String?

    @Option(name: .shortAndLong, help: "Test plan name")
    var plan: String?

    @Option(name: .shortAndLong, help: "iOS version")
    var ios: String?

    func run() async throws {
        let targetName = try await getTarget()
        let testPlanName = try await getTestPlan(for: targetName)
        let iosVersion = try await getIOSVersion()

        print("Launching test plan: ".blue + testPlanName.yellow + " for target: ".blue + targetName.yellow + " on iOS ".blue + iosVersion.yellow)

        do {
            let output = try shell("xcodebuild", "test",
                                         "-scheme", targetName,
                                         "-destination", "platform=iOS Simulator,OS=\(iosVersion)",
                                         "-testPlan", testPlanName)
            print("Tests completed successfully.".green)
            print(output)
        } catch {
            print("Error launching test plan: ".red + error.localizedDescription)
        }
    }

    private func getTarget() async throws -> String {
        if let target = target {
            return target
        }
        print("Available targets:".blue)
        // Add code to list available targets
        print("Enter the target name:".yellow)
        guard let targetName = readLine(), !targetName.isEmpty else {
            throw ValidationError("Invalid target name")
        }
        return targetName
    }

    private func getTestPlan(for target: String) async throws -> String {
        if let plan = plan {
            return plan
        }
        print("Available test plans for \(target):".blue)
        // Add code to list available test plans for the selected target
        print("Enter the test plan name:".yellow)
        guard let testPlanName = readLine(), !testPlanName.isEmpty else {
            throw ValidationError("Invalid test plan name")
        }
        return testPlanName
    }

    private func getIOSVersion() async throws -> String {
        if let ios = ios {
            return ios
        }
        print("Available iOS versions:".blue)
        // Add code to list available iOS versions
        print("Enter the iOS version:".yellow)
        guard let iosVersion = readLine(), !iosVersion.isEmpty else {
            throw ValidationError("Invalid iOS version")
        }
        return iosVersion
    }
}
