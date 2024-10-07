//
//  CreateArchitecture.swift
//
//
//  Created by Ghazi Tozri on 07/10/2024.
//

import Foundation
import ArgumentParser
import Rainbow

struct CreateArchitecture: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "ca",
        abstract: "Create architecture files for a new page"
    )

    @Argument(help: "Path to the folder where files will be created")
    var folderPath: String

    @Option(name: .shortAndLong, help: "Name of the page (e.g., HomePage)")
    var page: String

    func run() async throws {
        let fileManager = FileManager.default
        let expandedPath = (folderPath as NSString).expandingTildeInPath

        guard fileManager.fileExists(atPath: expandedPath) else {
            throw ValidationError("The specified folder does not exist: \(expandedPath)")
        }

        print("Creating architecture files for \(page) in \(expandedPath)".blue)

        try createFile(name: "\(page).swift", content: generatePageContent())
        try createFile(name: "\(page)Factory.swift", content: generateFactoryContent())
        try createFile(name: "\(page)HostingViewController.swift", content: generateHostingViewControllerContent())
        try createFile(name: "\(page)ViewModel.swift", content: generateViewModelContent())

        print("Successfully created architecture files for \(page).".green)
    }

    private func createFile(name: String, content: String) throws {
        let filePath = (folderPath as NSString).appendingPathComponent(name)
        try content.write(toFile: filePath, atomically: true, encoding: .utf8)
        print("Created \(name)".green)
    }

    private func generatePageContent() -> String {
        """
        import SwiftUI

        public protocol \(page)Navigator {

        }

        struct \(page): View {
            var body: some View {
                Text("\(page)")
            }
        }

        #Preview {
            \(page)()
        }
        """
    }

    private func generateFactoryContent() -> String {
        """
        import Foundation

        public protocol \(page)Factory { }

        public extension \(page)Factory {
            func make\(page)() { // -> RoutablePage
            }
        }

        public extension \(page)Factory {
            func make\(page)ViewController(page: \(page)) { // -> RoutablePage
            }

            func make\(page)ViewModel() -> \(page)ViewModel {
                return \(page)ViewModel()
            }
        }
        """
    }

    private func generateHostingViewControllerContent() -> String {
        """
        import SwiftUI
        import UIKit

        public final class \(page)HostingViewController: UIHostingController<\(page)> {
            public var shouldHideBottomBar: Bool = false
        }

        extension \(page)HostingViewController { // : RoutablePage {
            public func shouldHideNavigationBar() -> Bool {
                true
            }
        }
        """
    }

    private func generateViewModelContent() -> String {
        """
        import Combine

        public final class \(page)ViewModel {
            init() { }
        }
        """
    }
}
