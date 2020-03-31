1    CLS
10   C9=0
11   R9=0
12   C8=0
20   DIM O1$[2],P1$[2]
30   DIM L$[8],G$[20],A$[20],G1$[20],A1$[20],J$[1]
40   DIM E1$[4]

160  FOR N2=1 TO 8
170    N2$ = STR$(N2)
180    L$=L$+N2$
190  NEXT N2
210  REM *PAUSE(.5)
215  N%=2:GOSUB 10000
220  PRINT SPACE$(35);"MASTERMIND"
225  N%=2:GOSUB 10000
240  PRINT SPACE$(17);"Written by Jeff Langr and Michael Glasser"
250  N%=4:GOSUB 10000
260  PRINT SPACE$(17)
270  INPUT "Do you need instructions [N]? ", I$
290  IF I$<>"Y" AND I$<>"y" THEN 530

299  CLS
300  PRINT "The object of the game is to solve the hidden code generated by the"
310  PRINT "computer. There are two different games: MASTERMIND and SUPER MASTERMIND."
320  PRINT "In MASTERMIND there are four holes, six digits, and ten tries to break"
330  PRINT "the code. SUPER MASTERMIND expands the game to five holes, the digits"
340  PRINT "1 through 8, and a maximum of twelve guesses."
350  PRINT
360  PRINT "For each guess at the code, the computer will give you a clue consisting"
370  PRINT "of a number of black pegs and a number of white pegs. For every number"
380  PRINT "in your guess that is the same number and in the same position as that"
390  PRINT "in the hidden code you receive one black peg; for every number in your"
400  PRINT "guess that matches one of the numbers in the code but is not in the correct"
410  PRINT "position you receive a white peg."
420  PRINT
430  PRINT "The clue can consist of any combination of digits, which means that duplication"
440  PRINT "of digits is possible."
450  PRINT
460  PRINT "Example:"
470  PRINT "             Hidden code : 6 4 5 2 5"
480  PRINT "             Guess :       7 4 5 5 1"
490  PRINT "               # black pegs = 2"
500  PRINT "               # white pegs = 1"
510  N%=1:GOSUB 10000
511  INPUT "--- Hit return when ready...", X$
512  CLS
530  REM 
540  REM *PAUSE(.5) 
549  N%=10:GOSUB 10000 
550  PRINT SPACE$(10);

559  INPUT "Do you want to play SUPER MASTERMIND [N] ? ", Y1$
580  IF Y1$<>"Y" AND Y1$<>"y" THEN GOTO 640
590    P=5
600    M=12
610    R0=1
620    N1=8
630    GOTO 690
640  REM ELSE 
650    P=4
660    R0=3
670    M=10
680    N1=6
690  REM IF-END

700  REM *** go print initial board
710  GOSUB 1670

711  REM *** initialize random answer
715  RANDOMIZE TIMER
719  A$=SPACE$(P)
720  FOR I%=1 TO P
721    G=INT(N1 * RND + 1)
730    MID$(A$,I%)=MID$(STR$(G), 2)
740  NEXT I%
750  IF P=4 THEN A$[5]=" "

760  FOR N=1 TO M
770    C8=8+M
780    LOCATE 1,C8
790    W=0
800    B=0
810    rem PRINT E2$
820    LOCATE 19,23
822    PRINT "                                          "
823    LOCATE 19,23
830    INPUT "", G$

860    IF G$<>"GEEK" THEN 910
861      PRINT A$
870      PRINT SPACE$(23)+ MID$(A$, 1, 1)+"  "+MID$(A$, 2, 1)+"  "+MID$(A$, 3, 1)+"  "+MID$(A$, 4, 1)+"  "+MID$(A$, 5, 1)+"  --- cheater!"
890      REM *PAUSE(.5)
891      INPUT "", J$ 
900      GOTO 810 
910    REM DOEND

920    IF G$="QUIT" OR G$="EXIT" OR G$="//" OR G$="E" THEN 2100

960    IF LEN(G$)=P THEN 1000
970      P1$=STR$(P)
980      PRINT SPACE$(23)+"Guess must be "+P1$+" characters long.";
990      GOTO 810
1000   REM DOEND

1010   N1$=STR$(N1)
1020   FOR M9=1 TO P
1024     M%=VAL(MID$(G$, M9, 1))
1030     IF VAL(MID$(G$, M9, 1))>=1 AND VAL(MID$(G$, M9, 1)) <= VAL(N1$) THEN 1080
1035       IF P=5 THEN M$="8." ELSE M$="6."
1040       PRINT SPACE$(23)+"Enter only the digits 1 through "+M$
1070       GOTO 810
1080     REM IF-END
1090   NEXT M9
1100   C9=19
1110   R9=N+3+R0
1120   FOR X=1 TO 5
1130     C9=C9+4
1135     LOCATE R9,C9
1136     PRINT MID$(G$, X, 1)
1150   NEXT X
1160   G1$=G$
1170   A1$=A$

1180   REM *** Count black pegs and mask out on guess & answer
1190   FOR K=1 TO P
1200     IF MID$(G1$, K, 1) <> MID$(A1$, K, 1) THEN 1260
1210       B =B + 1
1220       MID$(G1$, K, 1)="X"
1230       MID$(A1$, K, 1)="X"
1240       O=N
1250       IF (B=P) THEN GOTO 1550
1260     REM IF-END
1270   NEXT K

1280   REM *** Find the number of white pegs
1290   FOR L=1 TO P
1300     IF MID$(G1$, L, 1) = "X" THEN 1380
1310       FOR J=1 TO P
1320         IF (MID$(G1$, L, 1)<>MID$(A1$, J, 1)) OR (MID$(G1$, L, 1) = "X") THEN 1360
1330           W = W + 1
1340           MID$(G1$, L, 1) = "X"
1350           MID$(A1$, J, 1) = "X"
1360         REM DOEND
1370       NEXT J
1380     REM DOEND
1390   NEXT L
1400   C9=C9+6
1410   FOR X9=1 TO W
1420     C9 = C9 + 3
1428     LOCATE R9, C9
1429     PRINT "W"
1440   NEXT X9
1450   FOR X9=1 TO B
1460     C9 = C9 + 3
1468     LOCATE R9, C9
1469     PRINT "B"
1480   NEXT X9
1490 NEXT N

1500 IF B >= P THEN 1540
1505   LOCATE 24, 19
1510   PRINT "You aren't very good at this"
1520   GOSUB 1960
1530   GOTO 1610
1540 REM DOEND

1550 REM *** Routine used after the answer has been found
1560 O1$=STR$(O)
1570 C9=C9+9
1575 LOCATE R9, C9
1578 PRINT "CORRECT"
1590 GOSUB 1960
1598 LOCATE 21,22
1600 PRINT "You guessed it correctly in "+O1$+" tries."
1605 LOCATE 22,28

1610 REM *** Play again? *** 
1620 INPUT "Care to play again [Y]? ", Y$
1640 IF Y$ <> "N" AND Y$ <> "n" THEN 530
1650 GOTO 2100
1660 END

1670 REM *** Subroutine to print the initial board
1680 CLS
1690 IF M=12 THEN PRINT SPACE$(32)+"SUPER MASTERMIND" ELSE PRINT:PRINT:PRINT SPACE$(35)+"MASTERMIND"
1750 PRINT
1760 PRINT SPACE$(27)+"GUESS"+SPACE$(16)+"CLUE"
1770 PRINT
1780 FOR Y=1 TO M
1790   IF Y >= 10 THEN 1830
1800     Z=Y
1860     Z$=STR$(Z)
1820     PRINT SPACE$(15)+MID$(STR$(Z),1)+")"
1821     GOTO 1890
1830   REM DOEND
1840   REM ELSE DO
1850     Z = Y - 10
1860     Z$=STR$(Z)
1870     PRINT SPACE$(15)+"1"+MID$(Z$,2)+")"
1880   REM DOEND
1890 NEXT Y

1900 PRINT
1910 IF M=12 THEN PRINT SPACE$(14)+"ANSWER :                 "
1920 ELSE         PRINT SPACE$(14)+"ANSWER :                  "
1930 PRINT
1940 PRINT SPACE$(14)+"GUESS  :";
1950 RETURN

1960 REM *** Print answer line
1970 LOCATE 17, 23
1980 PRINT MID$(A$, 1, 1)+"  "+MID$(A$, 2, 1)+"  "+MID$(A$, 3, 1)+"  "+MID$(A$, 4, 1)+"  "+MID$(A$, 5, 1)
2000 RETURN

2010 DEF FNC$(X0,Y0)
2020   DIM X$[2],Y$[2]
2030   X$=STR$(X0)
2040   Y$=STR$(Y0)
2050   RETURN '27"&a"+Y$+"r"+X$+"C"
2060 FNEND

2100 REM *** QUITTING
2101 PRINT E4$+E1$
2110 STOP
9999 END

10000 REM print N% lines
10001 FOR I=1 TO N%
10020     PRINT CHR$(13)
10030 NEXT I
10040 RETURN
