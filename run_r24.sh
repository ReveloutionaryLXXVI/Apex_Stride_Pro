#!/bin/bash
cd /home/work/.openclaw/workspace/apex_stride_r24
mkdir -p r24
python3 - <<'EOF'
src = open('Apex_Stride_Pro_RevR2_4_L.scad').read()
head = src.split('/* ============ FLOWSKIN + COLOR SPLIT')[0]
tail = src.split('/* ============ SOLVER')[1]
open('r24/lib_R24.scad','w').write(head + '/* ============ SOLVER' + tail)
EOF
cat > r24/t_body_R24.scad <<'EOF'
include <lib_R24.scad>
monolith_body();
EOF
( ./oscad -o r24/body_R24.stl r24/t_body_R24.scad 2> r24/body_R24.log; echo "R24_BODY exit=$? $(date -Is)" ) &
( ./oscad -o r24/Apex_Stride_Pro_RevR2_4_L.stl Apex_Stride_Pro_RevR2_4_L.scad 2> r24/export_L.log; echo "R24_EXPORT_L exit=$? $(date -Is)" ) &
wait
echo "R24_RENDERS_DONE $(date -Is)"
