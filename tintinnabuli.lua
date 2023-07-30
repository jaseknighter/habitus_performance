-- monome crow script for aug 2023 performances at patch point in berlin and blivande in stockholm
-- @jaseknighter
-- <insert lines link>

-- TODO
-- humanize rhythm and notes

s = sequins
tl = timeline
hs = hotswap

NOTE_NAMES = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"}

-- scales from norns musicutil from https://github.com/fredericcormier/WesternMusicElements
hs.lydian = s{0, 2, 4, 6, 7, 9, 11} -- "Lydian", 
hs.minor = s{0, 2, 3, 5, 7, 8, 10, 12} -- "Minor", 
hs.major = s{0, 2, 4, 5, 7, 9, 11, 12} -- "Major", 

function generate_scale(root_num, scale_data, length)
  local out_array = {}
  local scale_len = #scale_data
  local note_num
  local i = 0
  while #out_array < length do
    if i > 0 and i % scale_len == 0 then
      root_num = root_num + scale_data[scale_len]
    else
      note_num = root_num + scale_data[i % scale_len + 1]
      if note_num > 127 then break
      else table.insert(out_array, note_num) end
    end
    i = i + 1
  end
  return s{table.unpack(out_array)}
end

WSYN_SETTINGS_DEFAULT = {0,0,0,0,1,1,0.5,0}

function init()
  ii.jf.mode(1) 
  
  m_scale = generate_scale(0, hs.major, #hs.major);
  t_scale = generate_scale(4, hs.minor, #hs.minor)
  --[[
  m_scale = generate_scale(0, hs.lydian, #hs.lydian);
  t_scale = generate_scale(0, hs.lydian, #hs.lydian)
  ]]
  humanize = 0.05
  hs.velo = s{0.1}
  hs.mel_add = s{0}
  output[2].action = ar() -- assign a simple AR envelope to output 2

  hs.r1 = s{1,1,0.5} -- rhythm1 sequins
  hs.r1 = hs.r1*4
  hs.o1=s{0} -- octave1 sequins
  hs.m1=s{8,9,7,6} -- melody1 sequins
  -- hs.m1=s{1,3,5,7} -- melody1 sequins

  hs.p1=tl.loop{hs.r1, {play_melody,hs.m1}} --loop timeline 1

  hs.r2 = s{1,1,3} -- tintinnabuli rhythm
  hs.o2=s{0} -- tintinnabuli octaves
  hs.m2=s{1,3,5} --  tintinnabuli chords
  hs.p2=tl.queue():loop{hs.r2, {tintinnabluize,hs.m2}} --loop timeline 2
  hs.p2:play()     
  
  -- melody_wsyn_settings = WSYN_SETTINGS_DEFAULT
  melody_wsyn_settings = {2.6, -0.2, 3.5, -3.2, 1.0, -2.0, -3.7};
  tin_wsyn_settings = WSYN_SETTINGS_DEFAULT
  
  melody_add_note=s{s{0}, s{4}, s{6}, s{1}, s{4}, s{2}, s{4}}
  function melmix() hs.mel_add = s{melody_add_note()} end
  score_melody = timeline.queue():score{0, melmix,8, melmix,16,melmix,24,melmix,32,melmix,40,melmix,48, 'reset'}

end

function find_note(n, scale)
  local note
  if n > 0 then
    local base_index = n % #scale == 0 and #scale or n % #scale
    local octave_shift = n % #scale == 0 and math.floor(n/#scale) - 1 or math.floor(n/#scale) 
    note = scale[base_index] + (octave_shift * 12)
    return note
  end
end

local melody_note

function play_melody(n)
  n = n==0 and 0 or math.ceil(n)
  if n < 1 then return end
  local oct
  oct = hs.o1() * 12
  local mel_add = math.floor(hs.mel_add())
  mel_add = mel_add > 0 and mel_add or 0
  melody_note_pre_oct = find_note(n+mel_add, m_scale) 
  melody_note = melody_note_pre_oct + (oct)
  local hmn = math.random()*humanize
  if melody_wsyn_settings then
    set_wsyn(table.unpack(melody_wsyn_settings))  
  end
  ii.wsyn.play_voice( 1, (melody_note+hmn)/12, hs.velo() )
  output[1].volts = melody_note/12 -- assign the next note as a voltage
  output[2]() -- create an AR envelope
end

function tintinnabluize()
  local t_chord_note = hs.m2()
  local hmn = math.random()*humanize
  local oct = hs.o2() * 12    
  if melody_note_pre_oct+t_chord_note < 1 then return end
  local t_note = find_note(melody_note_pre_oct+t_chord_note, t_scale)+oct
  if tin_wsyn_settings then
    set_wsyn(table.unpack(tin_wsyn_settings))  
  end
  if t_note then
    ii.wsyn.play_voice( 2, (t_note+hmn)/12, hs.velo() )
    ii.jf.play_note((t_note+hmn)/12, hs.velo() )
  end
end


function pluckylogger_vals(lpg_time)
  wsyn_rand_curve = math.random(-40, 40)/10
  wsyn_rand_ramp = math.random(-5, 5)/10
  wsyn_rand_fm_index = math.random(-50, 50)/10
  wsyn_rand_fm_env = math.random(-50, 40)/10
  wsyn_rand_fm_ratio = math.random(1, 4)/math.random(1, 4)
  if lpg_time == "long" then
    wsyn_rand_lpg_time = math.random(-28, -5)/10
  else
    wsyn_rand_lpg_time = math.random(0, 10)/10
  end
  wsyn_rand_lpg_symmetry = math.random(-50, -30)/10

  -- print(wsyn_rand_curve, wsyn_rand_ramp, wsyn_rand_fm_index, wsyn_rand_fm_env, wsyn_rand_fm_ratio, wsyn_rand_lpg_time, wsyn_rand_lpg_symmetry)

  return {wsyn_rand_curve, 
    wsyn_rand_ramp, 
    wsyn_rand_fm_index, 
    wsyn_rand_fm_env, 
    wsyn_rand_fm_ratio, 
    wsyn_rand_lpg_time, 
    wsyn_rand_lpg_symmetry}
end

function set_wsyn(wsyn_rand_curve, wsyn_rand_ramp, wsyn_rand_fm_index, wsyn_rand_fm_env, wsyn_rand_fm_ratio, wsyn_rand_lpg_time, wsyn_rand_lpg_symmetry)
  ii.wsyn.curve(wsyn_rand_curve)
  ii.wsyn.ramp(wsyn_rand_ramp)
  ii.wsyn.fm_index(wsyn_rand_fm_index)
  ii.wsyn.fm_env(wsyn_rand_fm_env)
  ii.wsyn.fm_ratio(wsyn_rand_fm_ratio)
  ii.wsyn.lpg_time(wsyn_rand_lpg_time)
  ii.wsyn.lpg_symmetry(wsyn_rand_lpg_symmetry)
end