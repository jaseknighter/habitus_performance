# habitus_performance
230402 habitus performance notes and crow script<br>
@jaseknighter<br>
https://llllllll.co/t/deep-tissue-pdx-live-performance-4-1-and-stream-4-2/61496<br>

## setup and ideas to explore during the performance
### equipment setup
* nornsblue outputs -> nornsorange inputs
* fatesorange outputs -> tx-6 inputs 5/6
* tx-6 headphones -> bestie -> endless processor right
* sloths apathy x -> jf ramp
* w/ syn out -> 3sisters low input
* jf out1 -> 3sis span
* jf out6 -> 3sis fm
* 3sis low out -> endless processor left
* endless processor outs to w/ del in
* w/ del out -> rip A
* rip out -> tx-6 input 1
* wingie2 out -> tx-6 input 2
* wingie1 to ?????
* hachi-ni midi out -wingie2 midi in
* tx-6 main out -> PA system


### performance setup
* global clear endless processor
* load norns perf psets
* (rpls) fates blue softcut and tape to 0
* (oooooo) fates orange softcut and tape to 0
* reset w/del settings
* jf controls to noon
* sisters controls at noon

### performance steps
* start with blipoo
* cross fade blipoo and crow
* start second sequence 
* change rhythms, octaves, mel_add, melody
* bring up fates blue (rpls) softcut
* start score_melody timeline
* start r1mix timeline
* some lfo (output3) futzing
* change velo sequins
* play w/delay 
* bring down fatesblue (rpls) mix
* bring up fates orange (oooooo) softcut
* start fade out for end
* some jf lfo (output3) futzing
* some w/2 rate, feedback, mix futzing

### set w/
* ii.wdel.mix(-5)
* ii.wdel.mod_amount(0.5)
* ii.wdel.mod_rate(1)
* ii.wdel.feedback(1)
* ii.wdel.mix(-4)
* ii.wdel.mix(-2)
* ii.wdel.mix(0)

### m1 melody sequins ideas
* hs.m1=s{2,4}   
* hs.m1=s{1,3,5,7}:step(2)   

### octave sequins ideas
* hs.o2=s{1,1,1,1,0,2} 
* hs.o1=s{1,2,-1}  

### timeline setup for melodic sequence
* melody_add_note=s{s{0},s{4},s{6},s{1},s{4},s{2},s{4}}
* function melmix() hs.mel_add = s{melody_add_note()} end
* score_melody = timeline.queue():score{0, melmix,8, melmix,16,melmix,24,melmix,32,melmix,40,melmix,48, 'reset'}  
* score_melody:play()  

### lfos
* just friends: output[3].action = lfo(0.1,0.5);output[3].action()
* 3 sisters: output[4].action = lfo(0.5,0.5);output[4].action()


## commands sent to druid during the 4/2 performance @ psu's boiler room theatre
u tintinnabuli.lua
hs.r1=s{1,2,3} 
hs.r2=hs.r2*s{1,0.5}
hs.r2=hs.r2*s{1,0.25}
hs.r2=hs.r2*s{0.25}
hs.r2=hs.r2*s{1,0.25,1,0.5}  
-- melody_wsyn_settings = pluckylogger_vals("long")
tin_wsyn_settings = pluckylogger_vals()
score_melody:play()

hs.velo=s{1,2,0,3,0.25}
hs.velo=s{1,2,0,3,0.25}   

hs.mel_add=s{2}
hs.mel_add=s{0}
hs.mel_add=s{4}
hs.mel_add=s{2}
hs.mel_add=s{1}

hs.m1=s{1,3,5,7}

-- interesting melody_wsyn_settings
melody_wsyn_settings ={2.6, -0.2, 3.5, -3.2, 1.0, -2.0, -3.7}
melody_wsyn_settings ={2.0,  0.0,  3.9,  -4.6,  0.6666667,  0.4,  -4.5}

-----------------------------------------------------
-- set wsyn voices with pluckylogger
-----------------------------------------------------
set_wsyn(table.unpack(pluckylogger_vals()))  

-- separate voices
melody_wsyn_settings = pluckylogger_vals("long")
tin_wsyn_settings = pluckylogger_vals()
-----------------------------------------------------
-- wsyn commands
-----------------------------------------------------
-- commands                                                   
ii.wsyn.velocity( voice velocity )
ii.wsyn.pitch( voice, pitch )
ii.wsyn.play_voice( voice, pitch, velocity ) 
ii.wsyn.play_note( pitch, level )            
ii.wsyn.ar_mode( is_ar )                     
ii.wsyn.curve( curve )                       
ii.wsyn.ramp( ramp )                         
ii.wsyn.fm_index( index )                    
ii.wsyn.fm_env( amount )                     
ii.wsyn.fm_ratio( numerator, denomenator )   
ii.wsyn.lpg_time( time )                     
ii.wsyn.lpg_symmetry( symmetry )             
ii.wsyn.patch( jack, param )                 
ii.wsyn.voices( count )                      
-- request params                                                               
ii.wsyn.get( 'ar_mode' )                     
ii.wsyn.get( 'curve' )                       
ii.wsyn.get( 'ramp' )                        
ii.wsyn.get( 'fm_index' )                    
ii.wsyn.get( 'fm_env' )                      
ii.wsyn.get( 'lpg_time' )                    
ii.wsyn.get( 'lpg_symmetry' )                
ii.wsyn.get( 'patch', jack )                 
ii.wsyn.get( 'voices' )                      
ii.wsyn.get( 'fm_ratio' )                    
-- then receive                                                                 
ii.wsyn.event = function( e, value )         
  if e.name == 'ar_mode' then                                                   
    -- handle ar_mode response 
      -- e.arg: first argument, ie channel 
      -- e.device: index of device 
  elseif e.name == 'curve' then                                                 
  elseif e.name == 'ramp' then                                                  
  elseif e.name == 'fm_index' then                                              
  elseif e.name == 'fm_env' then                                                
  elseif e.name == 'lpg_time' then                                              
  elseif e.name == 'lpg_symmetry' then                                          
  elseif e.name == 'patch' then                                                 
  elseif e.name == 'voices' then                                                
  elseif e.name == 'fm_ratio' then                                              
  end 
end                                      

-----------------------------------------------------
-- wsyn reset
-----------------------------------------------------
ii.wsyn.curve(0); ii.wsyn.ramp(0); ii.wsyn.fm_index(0);ii.wsyn.fm_env(0); ii.wsyn.fm_ratio(1); ii.wsyn.ar_mode(1); ii.wsyn.lpg_time(0.5); ii.wsyn.lpg_symmetry(0)

-----------------------------------------------------
-- wsyn pluckylogger
-----------------------------------------------------
ii.wsyn.curve(math.random(-40, 40)/10);ii.wsyn.ramp(math.random(-5, 5)/10);ii.wsyn.fm_index(math.random(-50, 50)/10);ii.wsyn.fm_env(math.random(-50, 40)/10);ii.wsyn.fm_ratio(math.random(1, 4)/math.random(1, 4));ii.wsyn.lpg_time(math.random(-28, -5)/10);ii.wsyn.lpg_symmetry(math.random(-50, -30)/10)

--short notes
ii.wsyn.curve(math.random(-40, 40)/10);ii.wsyn.ramp(math.random(-5, 5)/10);ii.wsyn.fm_index(math.random(-50, 50)/10);ii.wsyn.fm_env(math.random(-50, 40)/10);ii.wsyn.fm_ratio(math.random(1, 4)/math.random(1, 4));ii.wsyn.lpg_time(math.random(0, 10)/10);ii.wsyn.lpg_symmetry(math.random(-50, -30)/10)

-----------------------------------------------------
-- wdel commands
-----------------------------------------------------
ii.wdel.feedback( level )                    
ii.wdel.mix( fade )                          
ii.wdel.filter( cutoff )                     
ii.wdel.freeze( is_active )                  
ii.wdel.time( seconds )                      
ii.wdel.length( count, divisions )           
ii.wdel.position( count, divisions )         
ii.wdel.cut( count, divisions )              
ii.wdel.rate( multiplier )                   
ii.wdel.freq( volts )                        
ii.wdel.clock(  )                            
ii.wdel.clock_ratio( mul, div )              
ii.wdel.pluck( volume )                      
ii.wdel.mod_rate( rate )                     
ii.wdel.mod_amount( amount )                 
-- request params                                                               
ii.wdel.get( 'feedback' )                    
ii.wdel.get( 'mix' )                         
ii.wdel.get( 'filter' )                      
ii.wdel.get( 'freeze' )                      
ii.wdel.get( 'time' )                        
ii.wdel.get( 'rate' )                        
ii.wdel.get( 'freq' )                        
ii.wdel.get( 'mod_rate' )                    
ii.wdel.get( 'mod_amount' )                  
-- then receive                                                                 
ii.wdel.event = function( e, value )         
  if e.name == 'feedback' then                                                  
    -- handle feedback response                                                 
      -- e.arg: first argument, ie channel                                      
      -- e.device: index of device                                              
  elseif e.name == 'mix' then                                                   
  elseif e.name == 'filter' then                                                
  elseif e.name == 'freeze' then                                                
  elseif e.name == 'time' then                                                  
  elseif e.name == 'rate' then                                                  
  elseif e.name == 'freq' then                                                  
  elseif e.name == 'mod_rate' then                                              
  elseif e.name == 'mod_amount' then                                            
  end                                                                           
end                         


>>>>>>>>>>>>>>>>>>>>>>>>

hs.m1=s{8,9,7,6}    
hs.m1=s{1,3,5,7}    
hs.r2=s{1}          
hs.r2=s{0.7}        
hs.r2=s{0.5}        
hs.m2=s{5,1,3}      
hs.m2=s{5,1,3}:step(2)                                                                      
                                                                                              
hs.m2=s{5,1,3,3,1,4,9}:step(2)                                                              
                                                                                              
hs.r2=s{0.2}        
hs.r2=s{0.1}        
hs.r1=hs.r1*2       
hs.r1=hs.r1*1       
hs.r1=hs.r1*s{1}    
hs.r1=hs.r1*s{0.5}  
hs.r1=hs.r1*s{0.25} 
melody_wsyn_settings ={2.6, -0.2, 3.5, -3.2, 1.0, -2.0, -3.7}                               
                                                                                              
melody_wsyn_settings ={2.0,  0.0,  3.9,  -4.6,  0.6666667,  0.4,  -4.5}                     
                                                                                              
hs.r1=hs.r1*s{4}    
hs.r1=hs.r1*s{3}    
hs.r1=hs.r1*s{2}    
hs.r1=hs.r1*s{1}    
hs.r1=hs.r1*s{0.5}  
hs.r2=s{0.2}        
hs.r1=hs.r1*s{2}    
hs.r1=hs.r1*s{2,1,3}
hs.r2=s{0.5}  