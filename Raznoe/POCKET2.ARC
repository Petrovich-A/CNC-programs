@@MMCARC.001                                                                                                7       060428  12          1444386535  2426                                                                                                                                                                                                                                        \CST.DIR\                                                                                                                       POCKET2.SPF
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    /_N_POCKET2_SPF                                   POCKET2.SPF                                       71771   7       060428  6200        1444386535  4235     *                                                                                                   /_N_CST_DIR/                                                                                                                                                                                                                                                   PROC POCKET2 (REAL RTP,REAL RFP,REAL SDIS,REAL DP,REAL DPR,REAL PRAD,REAL CPA,REAL CPO,REAL FFD,REAL FFP1,REAL MID,INT CDIR,REAL FAL,INT VARI,REAL MIDF,REAL FFP2,REAL SSF) SAVE DISPLOF
;VERSION: 06.05.19.00 Jun 26, 2007
;CHANGE : 06.05.17.00 Jun 27, 2005
;Kreistasche, mit Stirnfraeser
DEF AXIS _X,_Y,_Z
DEF REAL HH1,HH2,HH3,WZR,HHS,HHF,HHF1,HHZ,HHG,HR,HK,_SDZI,_FAK1
DEF INT HZ1,HZ2,HZ4,HZE,HZE1,_II
DEF BOOL SOWZ,_MDG
DEF INT _MIRR=0,_IS_CYCFR
DEF INT _ARTIS[16]
N18 _X=$P_AXN1 _Y=$P_AXN2 _Z=$P_AXN3 SDIS=ABS(SDIS) DPR=ABS(DPR) HK=SQRT(1.8)
PRAD=ABS(PRAD) MID=ABS(MID) MIDF=ABS(MIDF) VARI=ABS(VARI)
IF (($MC_MM_SYSTEM_FRAME_MASK B_AND 'B100000') AND ($AN_NCK_VERSION>=480300))
_IS_CYCFR=1
ENDIF
IF _SC_TOOL_VALI[0]<>0
_ARTIS[0]=_SC_TOOL_VALI[0] _ARTIS[1]=_SC_TOOL_VALI[1] _ARTIS[2]=_SC_TOOL_VALI[2] _ARTIS[3]=_SC_TOOL_VALI[3] _ARTIS[4]=_SC_TOOL_VALI[4] _ARTIS[5]=_SC_TOOL_VALI[5] _ARTIS[6]=_SC_TOOL_VALI[6]
_ARTIS[7]=_SC_TOOL_ON_OFF[0] _ARTIS[8]=_SC_TOOL_ON_OFF[1]
IF (_ARTIS[0] MOD 10 <>1 )
GOTOF _FEHL7
ENDIF
_II=_ARTIS[0] DIV 10
IF ((_II MOD 10 > 3) OR (_II MOD 10 < 1))
GOTOF _FEHL7
ELSE
_ARTIS[11]=_II MOD 10
IF (_ARTIS[3]<>0)
_ARTIS[13]=_ARTIS[1]
ENDIF
IF (_ARTIS[6]<>0)
_ARTIS[14]=_ARTIS[4]
ENDIF
ENDIF
_II=_II DIV 10
IF ((_II MOD 10 > 2) OR (_II MOD 10 < 0))
GOTOF _FEHL7
ELSE
_ARTIS[12]=_II MOD 10
ENDIF
_ARTIS[0]=_ARTIS[0] MOD 100
ENDIF
_MIRR=$P_ACTFRAME[_X,MI]+$P_ACTFRAME[_Y,MI]
IF _MIRR==1
IF CDIR==2
CDIR=CDIR+1
ELSE
CDIR=CDIR-1
ENDIF
ENDIF
IF(_ZSD[1]==0)
_SDZI=SDIS
ENDIF
IF ($P_TOOL==0) AND ($P_SIM==1)
SOWZ=TRUE
MSG("$80013")
_MDG=1
ELSE
SOWZ=FALSE
ENDIF
IF ($P_TOOL==0) AND ($P_SIM==0) GOTOF FEHL6 IF VARI>2 GOTOF FEHL5
IF(CDIR==2)OR(CDIR==3) GOTOF _MM00
MSG("$80001")
CDIR=3 _MDG=1
_MM00:IF FFP2 GOTOF _MM01
FFP2=FFP1
_MM01:IF SSF<0 GOTOF _M01
HHS=$P_S[0]
_M01:IF SSF>0 GOTOF _MM02
SSF=HHS
_MM02:IF DPR==0 GOTOF _MM1 IF RTP==RFP GOTOF FEHL1 IF VARI > 2 GOTOF FEHL5
HH2=RFP-((RTP-RFP)/ABS(RTP-RFP)*DPR)
IF DP==0 GOTOF _MM0 IF DP==HH2 GOTOF _MM1A
N10 MSG("$80000")
_MDG=1
_MM0: DP=HH2
GOTOF _MM1A
_MM1:DPR=ABS(RFP-DP)
_MM1A:HH2=RTP-RFP
IF RFP==DP GOTOF _MM8
IF HH2==0 GOTOF _MM2 IF HH2/ABS(HH2) <> (RFP-DP)/DPR GOTOF FEHL1
_MM2:HH2=(RFP-DP)/DPR
IF SOWZ==TRUE
WZR=0 VARI=2
ELSE
WZR=$P_TOOLR
ENDIF
HHF=$P_F
IF($P_GG[13]<3)
_FAK1=1
IF($MN_SCALING_SYSTEM_IS_METRIC)
IF($P_GG[13]==1)
_FAK1=1/$MN_SCALING_VALUE_INCH
ENDIF
ELSE
IF($P_GG[13]==2)
_FAK1=$MN_SCALING_VALUE_INCH
ENDIF
ENDIF
ELSE
_FAK1=1
ENDIF
HZ1=$MN_SCALING_SYSTEM_IS_METRIC HZ2=$P_GG[13]
IF(HZ2>2) GOTOF _MM2B
IF ((HZ1) AND (HZ2==2)) OR ((HZ1==0) AND (HZ2 <> 2)) GOTOF _MM2B
IF HZ1 GOTOF _MM2A
WZR=WZR*$MN_SCALING_VALUE_INCH
GOTOF _MM2B
_MM2A:WZR=WZR/$MN_SCALING_VALUE_INCH
_MM2B:WZR=WZR/$P_ACTFRAME[_X,SC]
IF (WZR==0) AND ($P_SIM==0) GOTOF FEHL6
IF MIDF GOTOF _MM2C
MIDF=_SDZI+DPR
_MM2C:
IF (_IS_CYCFR==1)
N100 $P_CYCFRAME=$P_CYCFRAME:CTRANS(_X,CPA*1/_FAK1,_Y,CPO*1/_FAK1)
ELSE
N105 ATRANS AX[_X]=CPA AX[_Y]=CPO
ENDIF
HH3=PRAD-FAL
IF WZR >PRAD GOTOF FEHL4 IF HH3>WZR GOTOF _MM3
FAL=PRAD-WZR HH3=WZR HHZ=0
GOTOF _MM3A
_MM3: IF SOWZ==TRUE GOTOF _MM3A
HHF1=FFP1 HZE=(HH3-WZR)/WZR/HK+0.4999 HHZ=(HH3-WZR)/HZE HZE1=HZE HHG=HHZ
_MM3A: IF FAL<WZR*2 GOTOF _MMA
IF SOWZ==TRUE GOTOF _MMA
MSG("$80003")
_MDG=1
_MMA:IF MID GOTOF _MM4
MID=_SDZI+DPR
_MM4:HZ1=(_SDZI+DPR)/MID+0.4999
IF HZ1==0
HZ1=1
ENDIF
HH1=(_SDZI+DPR)/HZ1 HZ2=1
N10 G0 G40 G60 G90 AX[_X]=0 AX[_Y]=0
G64 AX[_Z]=RFP+SDIS*HH2
IF CDIR==3
IF (_IS_CYCFR==1)
$P_CYCFRAME=$P_CYCFRAME:CMIRROR(_Y)
ELSE
AMIRROR AX[_Y]=0
ENDIF
ENDIF
_MG0:IF VARI==2 GOTOF _MS1
_MM7:
IF SOWZ==TRUE
HZ2=HZ1
ENDIF
IF (_ARTIS[11]==3)
_ARTIS[10]=_ARTIS[10]+1
IF (_ARTIS[6]<>0)
IF (_ARTIS[10]==_ARTIS[14])
_ARTIS[4]=_ARTIS[14] _ARTIS[5]=_ARTIS[14]
IF (_ARTIS[14]+_ARTIS[6]<=_SC_TOOL_VALI[5])
_ARTIS[14]=_ARTIS[14]+_ARTIS[6]
ENDIF
ENDIF
ELSE
IF ((_SC_TOOL_VALI[4]<=_ARTIS[10]) AND (_ARTIS[10]<=_SC_TOOL_VALI[5]))
_ARTIS[4]=_ARTIS[10] _ARTIS[5]=_ARTIS[10]
ENDIF
ENDIF
ENDIF
IF HZ1>1
IF(HZ2==1)
WRTPR("TMP_BLK_BEG()",1)
ENDIF
IF(HZ2==HZ1)
WRTPR("TMP_BLK_END()",1)
ENDIF
ENDIF
IF (_ARTIS[0]==11) OR ((_ARTIS[11]==3) AND ((_ARTIS[12]==0) OR (_ARTIS[12]==2)))
IF (_ARTIS[10]==_ARTIS[4])
M=QU(_ARTIS[7])
ENDIF
ENDIF
N20 G1 G60 F=FFD AX[_Z]=DP+(HZ1-HZ2)*HH1*HH2
IF HZ4 GOTOF _MG02 IF HHZ==0 GOTOF _MM7A
N200 G2 G64 AX[_X]=HHZ AX[_Y]=0 F=HHF1 IP[_X]=AC(HHZ/2) IP[_Y]=AC(0)
N210 _MG01: AX[_X]=-HHG AX[_Y]=0 IP[_X]=AC(0) IP[_Y]=AC(0)
HZE1=HZE1-1
IF HZE1==0 GOTOF _MG03
N216 AX[_X]=HHG+HHZ AX[_Y]=0 IP[_X]=AC(HHZ/2) IP[_Y]=AC(0)
HHG=HHG+HHZ
IF HZE1 > 1 GOTOB _MG01
N225 AX[_X]=-HHG AX[_Y]=0 IP[_X]=AC(0) IP[_Y]=AC(0)
N226 _MG03: AX[_X]=HHG AX[_Y]=0 IP[_X]=AC(0) IP[_Y]=AC(0)
N230 AX[_X]=0 AX[_Y]=0 IP[_X]=AC(HHG/2) IP[_Y]=AC(0)
_MM7A:
IF (_ARTIS[0]==11) OR ((_ARTIS[11]==3) AND ((_ARTIS[12]==0) OR (_ARTIS[12]==2)))
IF (_ARTIS[10]==_ARTIS[5])
M=QU(_ARTIS[8])
ENDIF
ENDIF
HZ2=HZ2+1 HHG=HHZ HZE1=HZE
IF HZ2<=HZ1 GOTOB _MM7
_MS0:IF (VARI==1) OR (FAL==0) GOTOF _MM7C
_MS1: HZ4=1 HZ1=(_SDZI+DPR)/MIDF+0.4999
IF HZ1==0
HZ1=1
ENDIF
HH1=(_SDZI+DPR)/HZ1 HZ2=1 HHF1=FFP2 HR=HH3-WZR HHG=(PRAD-WZR)/2
_MS3:IF SSF<0 GOTOB _MM7
S=SSF G60
GOTOB _MM7
_MG02:
N310 G2 G64 AX[_X]=PRAD-WZR AX[_Y]=0 IP[_X]=AC(HHG) IP[_Y]=AC(0) F=HHF1
N320 AX[_X]=WZR-PRAD AX[_Y]=0 IP[_X]=AC(0) IP[_Y]=AC(0)
N321 AX[_X]=PRAD-WZR AX[_Y]=0 IP[_X]=AC(0) IP[_Y]=AC(0)
N330 AX[_X]=0 AX[_Y]=0 IP[_X]=AC(HHG) IP[_Y]=AC(0)
IF (_ARTIS[0]==11) OR ((_ARTIS[11]==3) AND (_ARTIS[12]>0))
IF (_ARTIS[10]==_ARTIS[5])
M=QU(_ARTIS[8])
ENDIF
ENDIF
HZ2=HZ2+1
IF SOWZ==TRUE GOTOF VS1
IF HZ2<=HZ1 GOTOB _MM7
VS1:
_MM7C:G0 G90 AX[_Z]=RTP
AX[_X]=0 AX[_Y]=0
IF (_ARTIS[0]<>0)
M=QU(_ARTIS[8])
ENDIF
IF HHF GOTOF _MM7D
HHF=HHF1
_MM7D: F=HHF
IF SSF<0 GOTOF _MM8
S=HHS
_MM8:
IF _MDG==1
MSG("")
ENDIF
WRTPR("TMP_BLK_DEL()",1)
IF (_IS_CYCFR==1)
IF CDIR==3
N700 $P_CYCFRAME=$P_CYCFRAME:CMIRROR(_Y)
ENDIF
N710 $P_CYCFRAME=$P_CYCFRAME:CTRANS(_X,-CPA*1/_FAK1,_Y,-CPO*1/_FAK1)
ENDIF
RET
FEHL1:STOPRE
SETAL(61101)
RET
FEHL4:STOPRE
SETAL(61105)
RET
FEHL5:STOPRE
SETAL(61002)
RET
FEHL6:STOPRE
SETAL(61000)
RET
_FEHL7:
SETAL(62106)
RET
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        