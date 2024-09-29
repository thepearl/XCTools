import Foundation
import ArgumentParser

@main
struct XCTools: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "xctools",
        abstract: "A utility of Xcode-related tasks, mainly for iOS developers.",
        subcommands: [RemoveDD.self, Fresh.self, Test.self]
    )
}
