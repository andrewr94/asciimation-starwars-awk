#!/usr/bin/awk -f
BEGIN {
  DELAY_TIME=1;
  LINES_PER_FRAME=14;
  system("tput cols" | getline COLS);
  system("tput lines" | getline ROWS);
  system("tput civis");
  ROWS=int(ROWS/2) - 7;
  COLS=int(COLS/2) - 32;
}

{
  if (0 == (FNR - 1) % LINES_PER_FRAME) {
    rc = system("sleep "DELAY_TIME);
    if (rc) {
      exit rc
    }
    DELAY_TIME=(0.06 * $1.0);
    printf "\x1b[2J\n"; 
  } else {
    system("tput cup "(ROWS + (FNR-1)%LINES_PER_FRAME) " "COLS);
    print $0
  }
}

