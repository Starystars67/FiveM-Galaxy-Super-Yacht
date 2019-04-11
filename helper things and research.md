```
function DrawYachtName(name, style, color, font)
    if stage == 0 then
        if (renderId == -1) then
            renderId = CreateNamedRenderTargetForModel(target, prop)
        end
        if (movieId == -1) then
            movieId = RequestScaleformMovie("YACHT_NAME")
        end
        stage = 1
    elseif stage == 1 then
        if (HasScaleformMovieLoaded(movieId)) then
            local parameters = {
                p0 = {type = "string", value = name},
                p1 = {type = "int", value = 1},
                p2 = {type = "string", value = "US"}
            }
            SetupScaleform(movieId, "SET_YACHT_NAME", parameters)
            stage = 2
        else
            movieId = RequestScaleformMovie("YACHT_NAME")
        end
    elseif stage == 2 then
        SetTextRenderId(renderId)
        SetUiLayer(4)
        N_0xc6372ecd45d73bcd(true)
        ScreenDrawPositionBegin(73, 73)
        DrawScaleformMovie(movieId, 0.196, 0.245, 0.46, 0.66, 255, 255, 255, 255, 0)
        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
        ScreenDrawPositionEnd()
    end
end

function CreateNamedRenderTargetForModel(name, model)
    local handle = 0
    if not IsNamedRendertargetRegistered(name) then
        RegisterNamedRendertarget(name, false)
    end
    if not IsNamedRendertargetLinked(model) then
        LinkNamedRendertarget(model)
    end
    if IsNamedRendertargetRegistered(name) then
        handle = GetNamedRendertargetRenderId(name)
    end

    return handle
end

function SetupScaleform(movieId, scaleformFunction, parameters)
    BeginScaleformMovieMethod(movieId, scaleformFunction)
    N_0x77fe3402004cd1b0(name)
    if (IsTable(parameters)) then
        for i = 0, Tablelength(parameters) - 1 do
            local p = parameters["p" .. tostring(i)]
            if (p.type == "bool") then
                PushScaleformMovieMethodParameterBool(p.value)
            elseif (p.type == "int") then
                PushScaleformMovieMethodParameterInt(p.value)
            elseif (p.type == "float") then
                PushScaleformMovieMethodParameterFloat(p.value)
            elseif (p.type == "string") then
                PushScaleformMovieMethodParameterString(p.value)
            elseif (p.type == "buttonName") then
                PushScaleformMovieMethodParameterButtonName(p.value)
            end
        end
    end
    EndScaleformMovieMethod()
    N_0x32f34ff7f617643b(movieId, 1)
end

-- Check if a variable is a table
function IsTable(T)
    return type(T) == 'table'
end
-- Return the number of elements of the table
function Tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function HighlightObject(object)
    x, y, z = table.unpack(GetEntityCoords(object, true))
    SetDrawOrigin(x, y, z, 0)
    RequestStreamedTextureDict("helicopterhud", false)
    DrawSprite("helicopterhud", "hud_corner", -0.01, -0.01, 0.006, 0.006, 0.0, 255, 0, 0, 200)
    DrawSprite("helicopterhud", "hud_corner", 0.01, -0.01, 0.006, 0.006, 90.0, 255, 0, 0, 200)
    DrawSprite("helicopterhud", "hud_corner", -0.01, 0.01, 0.006, 0.006, 270.0, 255, 0, 0, 200)
    DrawSprite("helicopterhud", "hud_corner", 0.01, 0.01, 0.006, 0.006, 180.0, 255, 0, 0, 200)
    ClearDrawOrigin()
end

function DrawEmptyRect(name, model)
    local step = 250
    local timeout = 5 * 1000
    local currentTime = 0
    local renderId = CreateNamedRenderTargetForModel(name, model)

    while (not IsNamedRendertargetRegistered(name)) do
        Citizen.Wait(step)
        currentTime = currentTime + step
        if (currentTime >= timeout) then return false end
    end
    if (IsNamedRendertargetRegistered(name)) then
        SetTextRenderId(renderId)
        SetUiLayer(4)
        DrawRect(0.5, 0.5, 1.0, 1.0, 0, 0, 0, 0)
        SetTextRenderId(GetDefaultScriptRendertargetRenderId())

        ReleaseNamedRendertarget(0, name)
    end

    return true
end
```
