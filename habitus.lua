-- monome crow script for 230402 performance at psu's boiler room theatre
-- @jaseknighter
-- https://llllllll.co/t/deep-tissue-pdx-live-performance-4-1-and-stream-4-2/61496

s = sequins
tl = timeline
hs = hotswap

hs.lydian = s{0, 2, 4, 6, 7, 9, 11} -- "Lydian", 
-- scales from norns musicutil from https://github.com/fredericcormier/WesternMusicElements

function init()
  ii.jf.mode(1) 
  scale = hs.lydian
  hs.velo = s{8}
  hs.mel_add = s{0}
	output[2].action = ar() -- assign a simple AR envelope to output 2

  hs.r1 = s{1,1,0.5}
  hs.r1 = hs.r1*4
  hs.o1=s{0}
  hs.m1=s{1,3,5,7}
  hs.p1=tl.loop{hs.r1, {make_note,hs.m1,1}}

  hs.r2 = s{1,1,3}
  hs.o2=s{0}
  hs.m2=s{1,1,3}
  hs.p2=tl.queue():loop{hs.r2, {make_note,hs.m2,2}}
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
  elseif voice == 3 then
    oct = hs.o3() * 12    
  end
  local mel_add = math.floor(hs.mel_add())
  mel_add = mel_add > 0 and mel_add or 0
  note = find_note(n+mel_add) + (oct)
  if voice == 1 then
      ii.jf.play_voice( voice, note/12, hs.velo() )
      output[1].volts = note/12 -- assign the next note as a voltage
      output[2]() -- create an AR envelope
  else
    ii.jf.play_voice( voice, note/12, hs.velo() )
  end
end
