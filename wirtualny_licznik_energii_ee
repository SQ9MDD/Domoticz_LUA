-- licznik energii elektrycznej
-- co minutę naliczamy zużycie dla danego obwodu na podstawie jego mocy jeśli jest uruchomiony

dummyEnergyMeterid = 62			    -- idx dummy licznika 
pwr = 850 							-- moc w watach
obw = 'Kuchnia Mata Grzewcza'		-- nazwa monitorowanego obwodu
current_pwr = 0                     -- biezaca moc obwodu

commandArray = {}
	-- print(dummyEnergyMeterid)
	if (otherdevices[obw] == 'On') then
		-- print('YES')
		commandArray[1] = {['Variable:kuchnia_mata_pwr'] = 	tostring(uservariables["kuchnia_mata_pwr"] + (pwr/60))} --moc obwodu w watt przez 60 dostajemy watogodzinę	
		current_pwr = pwr
	else
		-- print('NO')
		commandArray[1] = {['Variable:kuchnia_mata_pwr'] = 	tostring(uservariables["kuchnia_mata_pwr"])}
		current_pwr = 0
	end

	consumed_pwr = tostring(uservariables["kuchnia_mata_pwr"])
	-- print(consumed_pwr)
	commandArray[2] = {['UpdateDevice'] = dummyEnergyMeterid .. "|0|" .. current_pwr .. ";" .. consumed_pwr}
return commandArray
