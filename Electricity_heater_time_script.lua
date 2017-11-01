-- Zezwolenie na uzycie podlogowki w weekendy i noc oraz w dzien zaleznie od daty
-- Konieczne przy taryfach czasowych energii elektrycznej
--
-- 01.04 – 30.09 godz. 15-17 miesiace: 4,5,6,7,8,9              godziny: 15,16      LATO
-- 01.10 – 31.03 godz. 13-15 miesiace: 10,11,12 oraz: 1,2,3     godziny: 13,14      ZIMA
--
-- ogrzewanie moze dzialać gdy:
-- godziny 22-06
-- Weekend
-- oraz po dwie godziny w ciagu dnia w zaleznosci od pory roku
--
-- udostępniam na licencji GPL v.31
-- rysieklabus@gmail.com
--
month = tonumber(os.date("%m"));                                            -- wyciagam miesiac
hr = tonumber(os.date("%H"));                                               -- wyciagam godzine
week_day = tonumber(os.date("%w"));                                         -- weekday [0-6 = Sunday-Saturday]
Heat_enable = 0
Heat_Timer_Switch = "Timer Ogrzewanie"

-- print("miesiac: "..month.." godzina: "..hr.." dzień tygodnia: "..week_day)
if week_day == 0 or week_day == 6 then                                      -- jesli dni weekendowe to zezwalaj
    Heat_enable = 1
else                                                                        -- jesli nie weekend kombinujemy dalej 
    if hr == 22 or hr == 23 or hr <= 5 then                                 -- jesli godziny nocne to zezwalaj
        Heat_enable = 1
    else                                                                    -- jesli nie weekend i nie noc kombinuj dalej
        if month >= 4 and month <= 9 then                                   -- jesli nie weekend nie noc ale lato to
            if hr == 15 or hr == 16 then                                    -- jesli godzina 15 lub 16 to mozemy grzac  
                Heat_enable = 1
            else                                                            -- jesli inne godziny to nie grzej
                Heat_enable = 0
            end
        else                                                                -- jesli nie weekend nie noc ale zima to
            if hr == 13 or hr == 14 then                                    -- jesli godzina 13 lub 14 to mozemy grzac
                Heat_enable = 1
            else                                                            -- jesli inne godziny to nie grzej
                Heat_enable = 0
            end          
        end
    end
end

-- sprawdzam jaka ma wartosc wirtualny przelacznik i w zaleznosci od tego ustawiam go we wlasciwej pozycji
-- zapis do logu tylko podczas zmian stanu
commandArray = {}
    if Heat_enable == 1 and otherdevices[Heat_Timer_Switch] == 'Off' then
       commandArray[Heat_Timer_Switch]='On' 
       print("HEAT TIMER SWITCH ON")
    elseif Heat_enable == 0 and otherdevices[Heat_Timer_Switch] == 'On' then
       commandArray[Heat_Timer_Switch]='Off'
       print("HEAT TIMER SWITCH OFF")
    end    
return commandArray
