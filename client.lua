function SetUpYacht()
  Citizen.CreateThread(function()
    --YACHT_NAME()
    --INITIALISE(100)
    --SET_YACHT_NAME("YTGN", false, "gb")
  	RemoveIpl("apa_yacht_grp12_1")
  	RemoveIpl("apa_yacht_grp12_1_int")
  	RemoveIpl("apa_yacht_grp12_1_lod")
  	RemoveIpl("apa_yacht_grp12_2")
  	RemoveIpl("apa_yacht_grp12_2_int")
  	RemoveIpl("apa_yacht_grp12_2_lod")
  	RequestIpl("apa_yacht_grp12_3")
  	RequestIpl("apa_yacht_grp12_3_int")
  	RequestIpl("apa_yacht_grp12_3_lod")
  	RemoveIpl("apa_ch2_superyacht")

    local interiorId

  	interiorId = GetInteriorAtCoords(-381.77390000, 6946.96000000, 5.42995500) --GetInteriorFromEntity(GetPlayerPed(-1))

  	local items = {
  		[1] = GetHashKey("apa_mp_apa_yacht_radar_01a"),
  		[2] = GetHashKey("apa_mp_apa_yacht_option3"),
  		[3] = GetHashKey("apa_mp_apa_yacht_o3_rail_a"),
  		[4] = GetHashKey("apa_mp_apa_yacht_launcher_01a"),
      [5] = GetHashKey("apa_mp_apa_y3_l2b"),
      [6] = GetHashKey("apa_mp_apa_yacht_jacuzzi_ripple1")
  	}
  	for i=1,#items do
  		RequestModel(items[i])
  	end

    local loading = true
    while loading do
      Wait(0)
      loading = false
      for i=1,#items do
        if not HasModelLoaded(items[i]) then
          loading = true
        end
      end
    end

  	RefreshInterior(interiorId)
    DisplayHelpText(interiorId)

    for i=1,#items do
      local x = GetClosestObjectOfType(-381.77390000, 6946.96000000, 5.42995500, 100.0, items[i])
      SetEntityAsMissionEntity(x, true, true)
      DeleteEntity(x)
    end

    local e = GetClosestObjectOfType(-381.77390000, 6946.96000000, 5.42995500, 0.1, GetHashKey('apa_mp_apa_yacht'))


    Wait(1000)
    for i=1,#items do
      local pos = GetEntityCoords(e)
      local h = GetEntityHeading(e)
      local o
      if i == 1 then
        o = CreateObject(items[i], pos.x+1.715, pos.y-1.05, pos.z+13.05, true, true, true)
      elseif i == 3 then
        o = CreateObject(items[i], pos.x, pos.y, pos.z-7.225, true, true, true)
      elseif i == 5 then
        o = CreateObject(items[i], pos.x, pos.y, pos.z-4.05, true, true, true)
      elseif i == 6 then
        o = CreateObject(items[i], pos.x-13.9, pos.y-49.0, pos.z-0.9, true, true, true)
      else
        o = CreateObject(items[i], pos.x, pos.y, pos.z-5.227, true, true, true)
      end
      SetEntityHeading(o, h)
    end
    SetObjectTextureVariant(e, 9)


    DrawEmptyRect("apa_prop_ap_name_text", "apa_prop_ap_name_text")
    while true do
      Wait(0)
      DrawYachtName(name)
      ModifyWater(-396.0, 6892.68, 5.0, 0.0)
      --SetRainFxIntensity(0.0)
      --SetWavesIntensity(0.0)
    end
  end)
end

SetUpYacht()
