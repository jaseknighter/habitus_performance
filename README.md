# habitus_performance
230402 habitus performance notes and crow script<br>
@jaseknighter<br>
https://llllllll.co/t/deep-tissue-pdx-live-performance-4-1-and-stream-4-2/61496<br>

## setup and ideas to explore during the performance
### equipment setup
* rip out -> tx-6 input 2
* wingie2 out -> tx-6 input 1
* tx-6 out -> fatesorange inputs
* fatesorange output -> fatesblue inputs
* fatesblue output -> mixer
* hachi-ni midi out -> wingie2 midi in
* grid -> fates blue


### performance setup
* tune mangrove
* load norns perf psets
* oooooo birds quiet!!!
* (rpls) fates blue softcut to 0
* (oooooo) fates orange softcut to 0
* reset w/del settings
* mangrove air off
* jf controls to noon
* clear and reset crow
* coldmac to noon
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
* bring down fatesorange mix
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


## actual druid log from druid on 4/2 @ psu boiler room theatre
^^clear        
^^reset                                                                                     
u perf.lua                                                                                  
hs.p2:play()                                                                                
hs.o2=s{1}                                                                                  
hs.o2=s{1,0}                                                                                
hs.o2=s{1,0,2}                                                                              
hs.o2=s{1,0}                                                                                
hs.o1=s{-1}                                                                                 
hs.o1=s{-1,0}                                                                               
hs.o1=s{-1,0,1}                                                                             
hs.r1=hs.r1*3                                                                               
hs.r1=hs.r1*2.5                                                                           
hs.r1=hs.r1*3                                                                             
hs.r1=hs.r1*2.5                                                                           
hs.r1=hs.r1*2.25                                                                          
hs.r1=hs.r1*2.1                                                                           
hs.r1=hs.r1*1.6                                                                           
hs.r1=hs.r1*s{1,2}                                                                        
hs.r1=hs.r1*s{1,2,0.7}                                                                    
hs.r1=hs.r1*s{1,1,0.7}                                                                    
hs.r1=hs.r1*s{1,1,0.5}                                                                    
hs.r1=hs.r1*s{1,0.5,0.5}       
melody_add_note=s{s{0},s{4},s{6},s{1},s{4},s{2},s{4}}                                     
function melmix() hs.mel_add = s{melody_add_note()} end                                   
score_melody = timeline.queue():score{0, melmix,8, melmix,16,melmix,24,melmix,32,melmix,40,melmix,48, 'reset'}                                                                       
hs.mel_add=s{2}                                                                           
hs.mel_add=s{0}                                                                           
hs.mel_add=s{4}                                                                           
hs.mel_add=s{2}                                                                           
hs.mel_add=s{1}     
score_melody:play()
