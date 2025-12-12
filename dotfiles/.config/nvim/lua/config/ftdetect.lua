local isAnsibleFile = function(path)
    local cfgFile = vim.fs.find("ansible.cfg", {
        path = vim.fs.basename(path),
        upward = true
    })
    if #cfgFile == 0 then
        return nil
    end

    local ansibleRootDir = vim.fn.fnamemodify(cfgFile[1], ":p:h")
    local fileDir = vim.fn.fnamemodify(path, ":p:h")
    if fileDir == ansibleRootDir then
        return true
    end

    local ansibleDirs = { "tasks", "handlers", "vars", "defaults" }
    for _, ansibleDir in ipairs(ansibleDirs) do
        local testDir = vim.fs.joinpath(ansibleRootDir, ansibleDir)
        if string.find(fileDir, testDir, 1, true) == 1 then
            return true
        end
    end
    return false
end

vim.filetype.add({
    extension = {
        yaml = function (path, _)
            if isAnsibleFile(path) then
                return "yaml.ansible"
            else
                return "yaml"
            end
        end,
        yml = function (path, _)
            if isAnsibleFile(path) then
                return "yaml.ansible"
            else
                return "yaml"
            end
        end
    }
})
