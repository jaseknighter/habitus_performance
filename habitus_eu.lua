-- monome crow script for aug 2023 performances at patch point in berlin and blivande in stockholm
-- @jaseknighter
-- <insert lines link>

s = sequins
tl = timeline
hs = hotswap

hs.lydian = s{0, 2, 4, 6, 7, 9, 11} -- "Lydian", 
-- scales from norns musicutil from https://github.com/fredericcormier/WesternMusicElements

function init()
  ii.jf.mode(0) 
  scale = hs.lydian
  hs.velo = s{4}
  hs.mel_add = s{0}
  output[2].action = ar() -- assign a simple AR envelope to output 2

  hs.r1 = s{1,1,0.5} -- rhythm1 sequins
  hs.r1 = hs.r1*4
  hs.o1=s{0} -- octave1 sequins
  hs.m1=s{8,9,7,6} -- melody1 sequins
  -- hs.m1=s{1,3,5,7} -- melody1 sequins
  hs.p1=tl.loop{hs.r1, {make_note,hs.m1,1}} --loop timeline 1

  hs.r2 = s{1,1,3} -- rhythm2 sequins
  hs.o2=s{0} -- octave2 sequins
  hs.m2=s{1,1,3} -- melody2 sequins
  hs.p2=tl.queue():loop{hs.r2, {make_note,hs.m2,2}} --loop timeline 2
end

function find_note(n)
  local note
  if n > 0 then
    local base_index = n % #scale == 0 and #scale or n % #scale
    local octave_shift = n % #scale == 0 and math.floor(n/#scale) - 1 or math.floor(n/#scale) 
    note = scale[base_index] + (octave_shift * 12)
    return note
  end
end

function make_note(n,voice)
  n = n==0 and 0 or math.ceil(n)
  if n < 1 then return end
  local oct
  if voice == 1 then
    oct = hs.o1() * 12
  elseif voice == 2 then
    oct = hs.o2() * 12    
  end
  local mel_add = math.floor(hs.mel_add())
  mel_add = mel_add > 0 and mel_add or 0
  note = find_note(n+mel_add) + (oct)
  if voice == 1 then
      ii.wsyn.play_voice( voice, note/12, hs.velo() )
      output[1].volts = note/12 -- assign the next note as a voltage
      output[2]() -- create an AR envelope
  else
    ii.wsyn.play_voice( voice, note/12, hs.velo() )
  end
end
