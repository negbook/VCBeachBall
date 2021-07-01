CreateThread(function()
    RequestModel(`prop_beachball_02`)
    while not HasModelLoaded(`prop_beachball_02`) do Wait(0) end 
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	local obj = CreateObject(
		`prop_beachball_02` --[[ Hash ]], 
		x --[[ number ]], 
		y --[[ number ]], 
		z+1.5 --[[ number ]], 
		false --[[ boolean ]], 
		false --[[ boolean ]], 
		false --[[ boolean ]]
	)
    SetEntityVelocity(obj, 0.0, 0.0, 0.1)
    local num = 0
    local LastTime = GetGameTimer()
    CreateThread(function()
        while true do Wait(0)
            if IsEntityTouchingEntity(obj,PlayerPedId()) and GetGameTimer() > LastTime + 50 then 
                local gevo = GetEntityVelocity(obj)
                local gevp = GetEntityVelocity(PlayerPedId())
                local rand = function() return randomFloat(-0.3,0.3) end 
                local dgev = (gevo - gevp) - vector3(rand(),rand(),rand())
                local dfgev = (-1.1 - gevp)
                SetEntityVelocity(obj, dgev.x,dgev.y, randomFloat(9.0,12.0))
                PlaySoundFromEntity(-1,"WEAPON_AMMO_PURCHASE",obj,"HUD_AMMO_SHOP_SOUNDSET",0,0)
                num = num + 1
                LastTime = GetGameTimer()
            end 
            if GetGameTimer() > LastTime + 30 + 3000 and not IsEntityTouchingEntity(obj,PlayerPedId()) then 
                num = 0
                return 
            end 
            DrawText3D(GetEntityCoords(PlayerPedId())+vector3(0.0,0.0,1.5),num,3.0,0)
        end 
    end)

end)
function DrawText3D(coords, text, size, font)
	coords = vector3(coords.x, coords.y, coords.z)

	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)

	if not size then size = 1 end
	if not font then font = 0 end

	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.55 * scale)
	SetTextFont(font)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	SetDrawOrigin(coords, 0)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end
function randomFloat(lower, greater)
    return lower + math.random()  * (greater - lower);
end
