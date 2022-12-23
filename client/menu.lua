_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu(" ", config.menuname, 1380, 0)
mainMenu:SetMenuWidthOffset(40)
_menuPool:Add(mainMenu)


function clockin(menu)
    for i, data in pairs(config.command_option) do
        local options = NativeUI.CreateItem(data.option_name, data.description)
        menu:AddItem(options)
        options.Activated = function()
            ExecuteCommand(data.command)
            ShowNotification('~g~Success~w~: Option executed.')
        end
    end
end

RegisterCommand("commands", function()
    _menuPool:ProcessMenus()
    Citizen.Wait(1)
    mainMenu:Visible(not mainMenu:Visible())
end)

clockin(mainMenu)
_menuPool:RefreshIndex()
_menuPool:MouseControlsEnabled(false)
_menuPool:MouseEdgeEnabled(false)
_menuPool:ControlDisablingEnabled(false)
_menuPool:ProcessMenus()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
    end
end)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
