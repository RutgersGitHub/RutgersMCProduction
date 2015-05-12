C...A simple skeleton program, illustrating a typical Pythia run:
C...ZZ pair production at CMS LHC.
C...Toy task: compare multiplicity distribution with matrix elements.
C...and with parton showers (using same fragmentation parameters).

C-----------------------------------------------------------------

C...Preamble: declarations.
 
C...All real arithmetic in double precision.
      IMPLICIT DOUBLE PRECISION(A-H, O-Z)
C...Three Pythia functions return integers, so need declaring.
      INTEGER PYK,PYCHGE,PYCOMP

C...EXTERNAL statement links PYDATA on most machines.
      EXTERNAL PYDATA

C...Commonblocks.
C...The event record.
      COMMON/PYJETS/N,NPAD,K(4000,5),P(4000,5),V(4000,5)
C...Parameters.
      COMMON/PYDAT1/MSTU(200),PARU(200),MSTJ(200),PARJ(200)
C...Particle properties + some flavour parameters.
      COMMON/PYDAT2/KCHG(500,4),PMAS(500,4),PARF(2000),VCKM(4,4)
C...Decay information.
      COMMON/PYDAT3/MDCY(500,3),MDME(8000,2),BRAT(8000),KFDP(8000,5)
C...Selection of hard scattering subprocesses.
      COMMON/PYSUBS/MSEL,MSELPD,MSUB(500),KFIN(2,-40:40),CKIN(200)
C...Parameters. 
      COMMON/PYPARS/MSTP(200),PARP(200),MSTI(200),PARI(200)
C...Supersymmetry parameters.
      COMMON/PYMSSM/IMSS(0:99),RMSS(0:99)
C...Random Seed.
      COMMON/PYDATR/MRPY(6),RRPY(100)

C-----------------------------------------------------------------

C...First section: initialization.
      LOGICAL debug
      INTEGER randomseed, numevnt
      REAL sqrtSinGeV
      CHARACTER txtoutput*200, lheoutput*200

      debug = .TRUE.

C...Reading in the names for all output files.
      READ(*,*) randomseed, numevnt, sqrtSinGeV, txtoutput, lheoutput

      MRPY(1) = randomseed   ! sets the random seed pythia will use

      IF (debug .EQV. .TRUE.) THEN
        WRITE(*,*) randomseed, numevnt, sqrtSinGeV
        WRITE(*,*) trim(txtoutput)
        WRITE(*,*) trim(lheoutput)
        WRITE(*,*) trim(lheoutput)//'.init'
        WRITE(*,*) trim(lheoutput)//'.evnt'
      END IF

C...Pythia log output.
      MSTU(11) = 11
      OPEN(UNIT=11,FILE=trim(txtoutput),STATUS='unknown')

C...Temporary files for initialization/event output.
      MSTP(161) = 12
      OPEN(UNIT=12,FILE=trim(lheoutput)//'.init',STATUS='unknown')
      MSTP(162) = 13
      OPEN(UNIT=13,FILE=trim(lheoutput)//'.evnt',STATUS='unknown')

C...Final Les Houches Event file, obtained by combining above two.
      MSTP(163) = 14
      OPEN(UNIT=14,FILE=trim(lheoutput),STATUS='unknown')

C...Main parameters of run: c.m. energy and number of events.
      ECM = sqrtSinGeV
      NEV = numevnt

C...Select ZZ pair production processes.
      MSEL = 0          ! user defined process
      MSUB(22) = 1      ! ZZ pair production
      MDME(174,1) = 0   ! Z --> d         dbar
      MDME(175,1) = 0   ! Z --> u         ubar
      MDME(176,1) = 0   ! Z --> s         sbar
      MDME(177,1) = 0   ! Z --> c         cbar
      MDME(178,1) = 0   ! Z --> b         bbar
      MDME(179,1) = 0   ! Z --> t         tbar
      MDME(180,1) = 0   ! Z --> b'        b'bar
      MDME(181,1) = 0   ! Z --> t'        t'bar
      MDME(182,1) = 1   ! Z --> e-        e+
      MDME(183,1) = 0   ! Z --> nu_e      nu_ebar
      MDME(184,1) = 1   ! Z --> mu-       mu+
      MDME(185,1) = 0   ! Z --> nu_mu     nu_mubar
      MDME(186,1) = 1   ! Z --> tau-      tau+
      MDME(187,1) = 0   ! Z --> nu_tau    nu_taubar
      MDME(188,1) = 0   ! Z --> tau'-     tau'+
      MDME(189,1) = 0   ! Z --> nu'_tau   nu'_taubar

C...Initialize PYTHIA for LHC.
       CALL PYINIT('CMS','p','p',ECM)

C-----------------------------------------------------------------

C...Second section: event loop.

C...Begin event loop.
      DO 100 IEV = 1, NEV
        CALL PYUPEV
 100  CONTINUE

C-----------------------------------------------------------------

C...Third section: produce output and end.

C...Cross section table and partial decay widths.
      CALL PYSTAT(1)
      CALL PYSTAT(2)
      CALL PYUPIN
      CALL PYLIST(12)

C...Produce final Les Houches Event File.
      CALL PYLHEF

      CLOSE(10)
      CLOSE(11)
      CLOSE(14)
      END
