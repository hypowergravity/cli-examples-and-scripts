# This script can be used to generate MD movie using chimeraX and frames can be updated 
# as 2D time label while recording
# the trajectory has to be loaded in chimeraX befor opening the script and default directory has to be set.
# Additional Commands
#
# align #12 toAtoms  #1 matchChainIds true (align the molecules)
#

from chimerax.core.commands import run

# --- parameters you can edit ---
model      = '#12'          # your trajectory model
start      = 1
end        = 10001
step       = 50            # change to 1000 for every-1000th frame
ns_per_fr  = 0.01          # 100 ns / 10,001 frames
out_mp4    = '479.mp4'
fps        = 10            # output framerate


# --------------------------------
# color protein 

run(session,f'color {model} cornflowerblue')
run(session,f'color  {model}:900 yellow')
run(session,'color byhetero')
# run(session,f'hide H')

# make/position the label once
run(session, '2dlabels delete all')
run(session, '2dlabels create timer text "Time: 0.00 ns" xpos 0.03 ypos 0.83 size 18 color black')

# record as PNG frames (robust) then encode, per workshop style
run(session, 'graphics rate maxFrameRate 30')
run(session, 'movie record directory . format png')

for f in range(start, end + 1, step):
    run(session, f'coordset {model} {f}')
    t_ns = (f - 1) * ns_per_fr
    run(session,f'show {model}:900 :<5 & protein')
    run(session,f'style {model}:900 :<5 & protein stick')
    run(session,f'color  {model}:900 :<5 & protein green')
    run(session,f'hide H')
    run(session, f'2dlabels change timer text "Time: {t_ns:.2f} ns"')
    run(session, 'wait 1')  # let the frame draw and get captured
    run(session,f'color {model} cornflowerblue')
    run(session,f'color  {model}:900 yellow')
    run(session,'color byhetero')
# encode the recorded PNGs to MP4
run(session, f'movie encode framerate {fps} quality higher output {out_mp4}')



