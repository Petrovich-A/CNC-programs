%_N_GEOMETR_OS_X_OS_Z_MPF
;$PATH=/_N_WKS_DIR/_N_OBK_OS_X_WPD
N1 ;DEFINE SMENA_ZYX AS G75 FP=1 Z1=0 Y1=0 X1=0 SPOS=0  
N2 DEFINE SMENA_Z AS g0 g53 z930 d0 m5 
N3 ;Proverka os_Z=Xo os_Z=Zo 
N4 ;STANOK nbh-6 INV12504
N5 ;paleta n_-nevagno!!
N6 ;KOPTYAEV S.G          21.07.14 otrabotana
N7 DEF REAL FUS=3000,ybez
N8 ;--NASTROI ZDES!!!!!-----------------------------
N9 r10=449.829      ;nastroi osi_Y(r10)!!!!!!!!!
;____________________________________________________
N10 R11=10          ;OS_Y NA nastroi osi_Z(r11) torec opravki!!
N20 R20=-20         ;OS_X
N11 R12=17.67     ;RADIUS T_OPRAVKI r=17.67
N12 ybez=900-R10          ;os_y bezopasn.
N13 ;------------------------------------------------
N14 $P_UIFR[1]=CTRANS(X,0,Y,0,Z,0,B,90)   ;  G54!!!!!! 
N15 ;     NALADKA INSTRUMENTA
N16 ;*MAG-1/POZ-2***********************************
N17 ; D3  T1(1/2) - drin  D3  L=350.68 R=17.67 Opravka CPS!!! 
N18 ;*****************************************************
N19 STOPRE
N20 G90 M12 G17
N21 SMENA_Z
N22  IF WORKING_STEP<=1    GOTOF ST1
N23  M91 ;gdi poka nezakonchitca cmena palet
N24 IF WORKING_STEP==999  GOTOF ST999
N25 ENDIF
N26 
N27 AA: MSG("WRONG WORKING_STEP")
N28 M0
N29 GOTOB AA
N30 
N31 ;==========================================================
N32 ST1: WORK_STEP(1)
N33 T="23.2" M6
N34 G0 G54 X-350
N35 m5m0 ;zameni instrument na OPRAVKU!!!!
N36 MSG("drin D3 L=350.680 R=17.670 WORK_STEP 1")
N37 G0 G54 g17 D3 y=r10+ybez x0            ;X0!!!
N38 SMENA_Z
N39 G0 G54 B0                              ;B0!!!
N40 z-50 D3
N41 y=r10
N42 m0
N43 m0 ;pover !!!!!!!!!
N44 G0 y=r10+ybez
N45 SMENA_Z
N46 G0 G54 B180                           ;B180!!!
N47 z-50 D3
N48 y=r10
N49 m0
N50 m0  ;pover!!!!!!!!
N51 G0 y=r10+ybez
N52 SMENA_Z
N53 m0
N54 MSG("PROVERKA OS_Z")
N55 m0 
N56 G0 G54 B90                           ;B0!!!
N57 X=R20 y=r10-R11
N58 G0 G54 z=-R12 D3
N59 m0
N60 m0  ;pover! v G54 z=-35.35/2 (na indekat. golov. natayg na=0!!!!)
N61 SMENA_Z
N62 G0 G54 X-350 Y=R10
N63 m0 ;zameni opravku na instrument !!!
N64 m0 ;ne zabil zamenit T_instr.
N65 ;==========================================================
N66 WORK_DONE
N67 GOTOF _ENDE
N68 
N69 ST999:TO_BROKEN
N70  _ENDE:T1 M6
N71 M91
N72 WORK_STEP(0)
N73 MSG("KRAJ PROGRAMA")
N74 M30
N75 
N76 
N77 
