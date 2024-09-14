# ChromeProfileManager Spoon

`ChromeProfileManager` is a Hammerspoon Spoon designed to manage multiple Google Chrome profiles efficiently. It automates the process of opening specified Chrome profiles, restoring their last sessions, and ensures that each profile window is only opened if it is not already active. This is particularly useful for users who work with multiple Chrome profiles and want a streamlined way to manage them.

Happy Chrome profile management! 🚀

## Features

- **Profile Management**: Automatically opens specified Chrome profiles if they are not already open.
- **Session Restoration**: Restores the last session tabs for each profile upon opening.
- **Focus Control**: Switches focus to Chrome and optionally focuses on a default profile window.
- **Customizable Profiles**: Easily configure which profiles to manage and their friendly names.
- **Integration Ready**: Designed to be called from your own Hammerspoon configuration or hyper key setup.

## Installation

1.  **Install Hammerspoon**:\
    Ensure you have Hammerspoon installed on your system. Download it from [Hammerspoon.org](https://www.hammerspoon.org/).

2.  **Install `ChromeProfileManager` Spoon**:

    - **Copy the Spoon**:\
      Copy the `ChromeProfileManager.spoon` directory to your Hammerspoon's `Spoons` directory: `~/.hammerspoon/Spoons/`.

    - **Load the Spoon in your Hammerspoon config**:\
      In your `~/.hammerspoon/init.lua`, add the following code:

```lua
        hs.loadSpoon("ChromeProfileManager")

        spoon.ChromeProfileManager.profiles = {
            { dir = "Default", name = "Personal" },
            { dir = "Profile 9", name = "Work" },
            { dir = "Profile 10", name = "School" }
        }

        spoon.ChromeProfileManager.defaultProfileName = "Personal"
```

3.  **Reload Hammerspoon's Config**:\
    Click on the Hammerspoon menu bar icon and select **"Reload Config"**, or press `Ctrl + Option + Command + R`.

## Usage

### Managing Profiles

To manage your Chrome profiles, call the `manageProfiles` method. This can be triggered from your own hyper key setup or called directly.

### Customizing Profiles

To customize the profiles you want to manage:

```lua
spoon.ChromeProfileManager.profiles = {
    { dir = "Default", name = "Personal" },
    { dir = "Profile 9", name = "Work" },
    { dir = "Profile 10", name = "School" }
}
```

- **`dir`**: The profile directory name (e.g., `"Default"`, `"Profile 9"`).
- **`name`**: The profile name as it appears in the Chrome window title.

### Setting the Default Profile

To set the default profile window to focus on:

```lua
spoon.ChromeProfileManager.defaultProfileName = "Personal"
```

## Logging

`ChromeProfileManager` uses Hammerspoon's logging facilities to provide detailed information and errors. By default, the logging level is set to `info`. You can monitor the logs through Hammerspoon's console or customize the log level if needed.

### Setting the Log Level

To set the log level to `debug` for more detailed logs:

```lua
spoon.ChromeProfileManager.logger.setLogLevel("debug")
```

## License

`ChromeProfileManager` is distributed under the MIT license. See the [LICENSE](https://opensource.org/licenses/MIT) for more details.

## Contributing

Contributions are welcome! Feel free to fork the repository, make your changes, and submit a pull request.

## Author

Developed by [James Turnbull](https://github.com/jamtur01).

## Acknowledgements

Special thanks to the Hammerspoon community for providing an amazing automation tool for macOS.
