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
        let fileManager = FileManager.default
        let derivedDataPath = path ?? "~/Library/Developer/Xcode/DerivedData"
        let expandedPath = NSString(string: derivedDataPath).expandingTildeInPath

        print("Removing derived data from: \(expandedPath)")

        do {
            if fileManager.fileExists(atPath: expandedPath) {
                try fileManager.removeItem(atPath: expandedPath)
                print("Successfully removed derived data.")
            } else {
                print("Derived data folder does not exist at the specified path.")
            }
        } catch {
            print("Error removing derived data: \(error.localizedDescription)")
        }

        if clean {
#if os(macOS)
            print("Cleaning the project...")
            let task = Process()
            task.executableURL = URL(fileURLWithPath: "/usr/bin/xcodebuild")
            task.arguments = ["-alltargets", "clean"]

            do {
                try task.run()
                task.waitUntilExit()
                if task.terminationStatus == 0 {
                    print("Project cleaned successfully.")
                } else {
                    print("Error cleaning the project. Exit code: \(task.terminationStatus)")
                }
            } catch {
                print("Error running xcodebuild clean: \(error.localizedDescription)")
            }
#else
            fatalError("Cleaning the project is not supported on this platform.")
#endif
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
#if os(macOS)
            print("Cleaning the project...")
            let bundleInstallTask = Process()
        bundleInstallTask.executableURL = URL(fileURLWithPath: "/usr/bin/bundle")
        bundleInstallTask.arguments = ["install"]

        let podInstallTask = Process()
        podInstallTask.executableURL = URL(fileURLWithPath: "/usr/bin/bundle")
        podInstallTask.arguments = ["exec", "pod", "install"]

            do {
                try bundleInstallTask.run()
                bundleInstallTask.waitUntilExit()
                if bundleInstallTask.terminationStatus == 0 {
                    print("Project cleaned successfully.")
                } else {
                    print("Error cleaning the project. Exit code: \(bundleInstallTask.terminationStatus)")
                }
            } catch {
                print("Error running xcodebuild clean: \(error.localizedDescription)")
            }
#else
            fatalError("Install pods and reset packages cache is not supported on this platform.")
#endif

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
