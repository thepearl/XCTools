# XCTools

XCTools is a command-line utility designed to streamline common Xcode-related tasks for iOS developers. It provides easy-to-use commands for managing derived data, refreshing dependencies, and running test plans.

## Features

- **Remove Derived Data**: Quickly clean up Xcode's derived data folder.
- **Fresh Installation**: Easily reinstall pods and reset package cache.
- **Launch Test Plans**: Interactively select and run specific test plans.

## Installation

### Requirements

- macOS 10.15 (Catalina) or later
- Xcode 13.0 or later
- Swift 5.10 or later

### From Source

1. Clone the repository:
   ```bash
   git clone https://github.com/thepearl/XCTools.git
   ```

2. Navigate to the project directory:
   ```bash
   cd XCTools
   ```

3. Build the project:
   ```bash
   swift build -c release
   ```

4. Install the binary:
   ```bash
   cp -f .build/release/XCTools /usr/local/bin/xctools
   ```

## Usage

After installation, you can run XCTools using the `xctools` command.

### General Help

To see all available commands:

```bash
xctools --help
```

### Remove Derived Data

To remove Xcode's derived data:

```bash
xctools remove-dd
```

Options:
- `--path <path>`: Specify a custom path for derived data.
- `--clean`: Clean the project after removing derived data.

Example with options:
```bash
xctools remove-dd --path ~/CustomDerivedData --clean
```

### Fresh Installation

To reinstall pods and reset package cache:

```bash
xctools fresh
```

Options:
- `--spm`: Also freshen Swift Package Manager dependencies.

Example with SPM option:
```bash
xctools fresh --spm
```

### Launch Test Plans

To interactively launch a test plan:

```bash
xctools test
```

This command will guide you through selecting:
1. The target
2. The test plan
3. The iOS version

Follow the prompts to select your desired options.

## Contributing

We welcome contributions to XCTools! If you have a feature request, bug report, or want to contribute code, please open an issue or pull request on our GitHub repository.

## License

XCTools is released under the MIT License. See the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions, please file an issue on the GitHub issue tracker.

Thank you for using XCTools!
