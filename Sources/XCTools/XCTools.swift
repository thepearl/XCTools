import Foundation
import ArgumentParser

@main
struct XCTools: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "xctools",
        abstract: "A utility for Xcode-related tasks",
        subcommands: [RemoveDD.self, Fresh.self, Test.self]
    )
}

struct RemoveDD: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "remove-dd",
        abstract: "Remove derived data"
    )

    @Option(name: .long, help: "Custom path for derived data")
    var path: String?

    @Flag(name: .long, help: "Clean the project after removing derived data")
    var clean: Bool = false

    func run() throws {
        let derivedDataPath = path ?? "~/Library/Developer/Xcode/DerivedData"
        print("Removing derived data from: \(derivedDataPath)")

        // Add code to remove derived data here

        if clean {
            print("Cleaning the project...")
            // Add code to run xcodebuild -alltargets clean
        }
    }
}

struct Fresh: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "fresh",
        abstract: "Install pods and reset packages cache"
    )

    @Flag(name: .long, help: "Also freshen SPM dependencies")
    var spm: Bool = false

    func run() throws {
        print("Running: bundle exec install && bundle exec pod install")
        // Add code to run the above command

        if spm {
            print("Resolving package dependencies...")
            // Add code to run xcodebuild -resolvePackageDependencies
        }
    }
}

struct Test: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "test",
        abstract: "Launch a test plan"
    )

    func run() throws {
        print("Available targets:")
        // Add code to list available targets

        print("Enter the target name:")
        guard let targetName = readLine() else {
            throw ValidationError("Invalid target name")
        }

        print("Available test plans for \(targetName):")
        // Add code to list available test plans for the selected target

        print("Enter the test plan name:")
        guard let testPlanName = readLine() else {
            throw ValidationError("Invalid test plan name")
        }

        print("Available iOS versions:")
        // Add code to list available iOS versions

        print("Enter the iOS version:")
        guard let iosVersion = readLine() else {
            throw ValidationError("Invalid iOS version")
        }

        print("Launching test plan: \(testPlanName) for target: \(targetName) on iOS \(iosVersion)")
        // Add code to launch the test plan
    }
}
