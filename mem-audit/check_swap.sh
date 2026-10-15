# Audit top 15 processes by compressed/swapped memory with exact vmmap metrics
echo "Scanning top 15 processes by Compressed/Swapped Memory..."
echo "=========================================================================="

# Extract only the PIDs from top sorted by CMPRS
top -l 1 -o CMPRS -n 15 -stats pid | awk "NR>12 && \$1 ~ /^[0-9]+\$/ {print \$1}" | while read -r pid; do
  # Get the clean full process name via ps
  cmd=$(ps -p "$pid" -o comm= 2>/dev/null | awk -F/ "{print \$NF}")
  [ -z "$cmd" ] && continue

  echo "Process: $cmd (PID: $pid)"

  # Capture Physical footprint, Writable regions (swapped_out), and the first TOTAL table row
  vmmap -summary "$pid" 2>/dev/null | awk "
        /Physical footprint:/ { print \"  \" \$0 }
        /Writable regions:/ { print \"  \" \$0 }
        /^REGION TYPE/ && !header_printed { 
            printf \"  %-28s %10s %10s %10s\n\", \"SUMMARY TABLE\", \"RESIDENT\", \"DIRTY\", \"SWAPPED\"
            header_printed=1 
        }
        /^TOTAL[[:space:]]+/ && !total_printed { 
            printf \"  %-28s %10s %10s %10s\n\", \"TOTAL\", \$3, \$4, \$5
            total_printed=1 
        }
    "
  echo "--------------------------------------------------------------------------"
done
