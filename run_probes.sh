#!/bin/bash
cd /home/work/.openclaw/workspace/apex_stride_r24/harness
for f in t_text t_text_oracle t_footneg t_bowchan t_gills t_flexgrooves t_rings t_ruler t_speedlines t_turbine; do
  ( ../oscad -o "$f.stl" "$f.scad" 2> "$f.log"
    echo "$f exit=$? size=$(stat -c%s "$f.stl" 2>/dev/null || echo 0)" ) &
done
wait
echo "PROBES_DONE $(date -Is)"
