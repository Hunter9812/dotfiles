local M = {}

local cached_os = nil

local function detect_os()
    if cached_os ~= nil then
        return cached_os
    end

    if jit and jit.os then
        local hosts = {
            OSX = "macos",
            Windows = "windows",
            Linux = "linux",
        }
        cached_os = hosts[jit.os]

    elseif package.config:sub(1, 1) == '\\' then
        cached_os = "windows"

    else
        local fh = assert(io.popen("uname -s"))
        local uname = fh:read("*l")
        fh:close()

        if uname then
            uname = uname:lower()
            if uname:find("linux", 1, true) then
                cached_os = "linux"
            elseif uname:find("darwin", 1, true) then
                cached_os = "macos"
            end
        end
    end

    return cached_os or "unknown"
end

function M.get()
    if not cached_os then
        cached_os = detect_os()
    end
    return cached_os
end

function M.is_windows()
    return M.get() == "windows"
end

function M.is_linux()
    return M.get() == "linux"
end

function M.is_macos()
    return M.get() == "macos"
end

function M.is_unix()
    local os = M.get()
    return os == "linux" or os == "macos"
end

function M.is_wsl()
    if M.get() ~= "linux" then
        return false
    end

    local f = io.open("/proc/version", "r")
    if not f then
        return false
    end

    local content = f:read("*a")
    f:close()

    return content:lower():find("microsoft") ~= nil
end

return M
