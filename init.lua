--- === ChromeProfileManager ===
---
--- Manages Google Chrome profiles, opening specified profiles if they are not already open.
---
--- #### Features
--- - Opens Chrome with specified profiles if they are not already open.
--- - Restores last session tabs for each profile.
--- - Switches focus to Chrome and focuses on a default profile window.
---
--- #### Usage
--- 1. Place the `ChromeProfileManager.spoon` in your `~/.hammerspoon/Spoons/` directory.
--- 2. Configure the profiles in your `init.lua`.
--- 3. Call the `manageProfiles` method from your own configuration or hyper key setup.

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "ChromeProfileManager"
obj.version = "1.2"
obj.author = "James Turnbull <james@lovedthanlost.net>"
obj.homepage = "https://github.com/jamtur01/ChromeProfileManager.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- ChromeProfileManager.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('ChromeProfileManager', 'info')

--- ChromeProfileManager.profiles
--- Variable
--- Table of profiles to manage. Each entry should be a table with 'dir' and 'name' keys.
---
--- Example:
--- ```
--- spoon.ChromeProfileManager.profiles = {
---     { dir = "Default", name = "Personal" },
---     { dir = "Profile 9", name = "Smartrr" },
---     { dir = "Profile 10", name = "Convergint" }
--- }
--- ```
obj.profiles = {}

--- ChromeProfileManager.defaultProfileName
--- Variable
--- The name of the default profile to focus on when switching to Chrome.
obj.defaultProfileName = "Personal"

--- ChromeProfileManager:manageProfiles()
--- Method
--- Manages Chrome profiles according to the logic specified.
---
--- Parameters:
---  * None
---
--- Returns:
---  * None
function obj:manageProfiles()
    self.logger.d("Starting manageProfiles")
    local chromeIsRunning = self:isAppRunning("Google Chrome")
    local openProfiles = {}

    if chromeIsRunning then
        self.logger.d("Chrome is running.")
        -- Get the list of open profiles by examining window titles
        local chrome = hs.application.get("Google Chrome")
        local windows = chrome:allWindows()
        for _, win in ipairs(windows) do
            local title = win:title()
            self.logger.d("Window Title: " .. (title or "nil"))
            if title then
                -- Convert both title and profile name to lower case for case-insensitive matching
                local lowerTitle = string.lower(title)
                for _, profile in ipairs(self.profiles) do
                    if string.find(lowerTitle, string.lower(profile.name), 1, true) then
                        openProfiles[profile.dir] = true
                        self.logger.d("Matched profile: " .. profile.name)
                    end
                end
            end
        end
    else
        self.logger.d("Chrome is not running.")
    end

    -- Open profiles that are not open
    for _, profile in ipairs(self.profiles) do
        if not openProfiles[profile.dir] then
            self.logger.d("Profile not open, launching: " .. profile.name)
            self:launchChromeWithProfile(profile.dir)
            hs.timer.usleep(500000) -- Wait for half a second
        else
            self.logger.d("Profile already open: " .. profile.name)
        end
    end

    -- Switch focus to Chrome, selecting the default profile window
    hs.application.launchOrFocus("Google Chrome")
    local chrome = hs.application.get("Google Chrome")
    if chrome then
        local windows = chrome:allWindows()
        for _, win in ipairs(windows) do
            local title = win:title()
            if title and string.find(string.lower(title), string.lower(self.defaultProfileName), 1, true) then
                win:focus()
                self.logger.d("Focused on default profile window: " .. self.defaultProfileName)
                break
            end
        end
    end
end
-- Helper function to check if an app is running
function obj:isAppRunning(appName)
    return hs.application.get(appName) ~= nil
end

-- Helper function to launch Chrome with a specific profile
function obj:launchChromeWithProfile(profileDir)
    local chromePath = "/Applications/Google Chrome.app"
    local command = string.format(
        [[open -n -a "%s" --args --profile-directory="%s"]],
        chromePath, profileDir
    )
    hs.execute(command)
    self.logger.i("Launched Chrome with profile directory: " .. profileDir)
end

return obj
