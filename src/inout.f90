! ********************************************************************
!       
! TM1DNNN - Transfer matrix method for the Anderson model
! in 1D with finite-range hopping
!
! ********************************************************************
      
       
! ********************************************************************
!       
! $Header: /home/cvs/phsht/GrapheneTMM/src/Restart/ALL/inout.f90,v 1.1 2011/07/22 17:49:19 ccspam Exp $
!
! ********************************************************************

! -----------------------------------------------------------------------
!Input: Read the input file
!
!	IErr	error code
! ----------------------------------------------------------------------

SUBROUTINE Input( IErr )

  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IErr, ILine
  REAL(KIND=RKIND) ROfIter
  
  !	PRINT*,"DBG: Input()"
  
  IErr = 0
  ILine= 0
  
  OPEN(UNIT= IChInp, ERR= 120, FILE= "tm1dNNN.inp",&
       STATUS= 'OLD')
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) ISeed
  !PRINT*,"ISeed        = ",ISeed
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) NOfIter
  !NOfIter= NINT(MIN(ROfIter,DBLE(MAXIter)))
  ! PRINT*,"ROfIter      = ", ROfIter
  ! PRINT*,"NOfIter      = ", NOfIter
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) NOfOrtho
  !PRINT*,"NOfOrtho     = ", NOfOrtho
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) NOfPrint
  !PRINT*,"NOfPrint     = ", NOfPrint
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) NOfGamma
  !PRINT*,"NOfGamma     = ", NOfGamma
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) IBCFlag
  !PRINT*,"IBCFlag      = ", IBCFlag
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) IRNGFlag
  !PRINT*,"IRNGFlag      = ", IRNGFlag
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) IKeepFlag
  !PRINT*,"IKeepFlag    = ", IKeepFlag
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) IWriteFlag
  !PRINT*,"IWriteFlag   = ", IWriteFlag
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) ISortFlag
  !PRINT*,"ISortFlag    = ", ISortFlag
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) IFluxFlag
  !PRINT*,"IFluxFlag    = ", IFluxFlag

  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) Range0
  !PRINT*,"Range0       = ",Range0
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) Range1
  !PRINT*,"Range1       = ", Range1
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) dRange
  !PRINT*,"dRange       = ", dRange
  
  ILine= ILine+1
  READ(IChInp,15,ERR=20,END=30) DiagDis0
  !PRINT*,"DiagDis0     = ", DiagDis0
  
  ILine= ILine+1
  READ(IChInp,15,ERR=20,END=30) DiagDis1
  !PRINT*,"DiagDis1     = ", DiagDis1
  
  ILine= ILine+1
  READ(IChInp,15,ERR=20,END=30) dDiagDis
  !PRINT*,"dDiagDis     = ", dDiagDis
  
  ILine= ILine+1
  READ(IChInp,15,ERR=20,END=30) Energy0
  !PRINT*,"Energy0      = ", Energy0
  
  ILine= ILine+1
  READ(IChInp,15,ERR=20,END=30) Energy1
  !PRINT*,"Energy1      = ", Energy1
  
  ILine= ILine+1
  READ(IChInp,15,ERR=20,END=30) dEnergy
  !PRINT*,"dEnergy      = ", dEnergy
  
  ILine= ILine+1
  READ(IChInp,10,ERR=20,END=30) IKappaFlag
  !PRINT*,"IKappaFlag   = ", IKappaFlag

  ILine= ILine+1
  READ(IChInp,15,ERR=20,END=30) Kappa
  !PRINT*,"Kappa        = ", Kappa
  
  ILine= ILine+1
  READ(IChInp,15,ERR=20,END=30) Epsilon
  !PRINT*,"Epsilon      = ", Epsilon
 
  ILine= Iline+1
  READ(IChInp,10,ERR=20,END=30) IMidDump
  !PRINT*,"IMidDump      = ", IMidDump
 
  ILine= Iline+1
  READ(IChInp,10,ERR=20,END=30) IWalltime
  !PRINT*,"IWalltime      = ", IWalltime

  ILine= Iline+1
  READ(IChInp,10,ERR=20,END=30) IRestart
  !PRINT*,"IRestart      = ", IRestart
  
10 FORMAT(16X,I15.1)
  ! 10	FORMAT("IMAXIteration= ",I15.1)
15 FORMAT(16X,F18.9)
  ! 15     FORMAT("IMAXIteration= ",F18.9)
  
  CLOSE(IChInp, ERR=130)
  
  ! check the parameters for validity
  
  IF( ROfIter.GT.MAXIter ) THEN
     PRINT*,"Input(): NOfIter=",ROfIter,&
          " > MAXIter=", MAXIter
     PRINT*,"Input(): NOfIter set to", NOfIter
  ENDIF
  
  IF( NOfIter.LE.0 ) THEN
     PRINT*,"Input(): NOfIter <= 0"
     IErr= 1
  ENDIF
  
  IF( NOfGamma.GT.MAXGamma ) THEN
     PRINT*,"Input(): NOfGamma > MAXGamma (=",MAXGamma,")"
     IErr= 1
  ENDIF
  
  IF( Range0.LE.0 ) THEN
     PRINT*,"Input(): Range0 <= 0"
     IErr= 1
  ENDIF
  
  IF( Range0.GT.MAXRange ) THEN
     PRINT*,"Input(): Range0 > MAXRange (=",MAXRange,")"
     IErr= 1
  ENDIF
  
  IF( Range1.GT.MAXRange ) THEN
     PRINT*,"Input(): Range1 > MAXRange (=",MAXRange,")"
     IErr= 1
  ENDIF
  
  IF( (Range0.GT.Range1) .AND. (dRange.GT.0) ) THEN
     PRINT*,"Input(): Range0 > Range1 and dRange>0"
     IErr= 1
  ENDIF

  IF( IBCFlag.GT.MAXBCFlag ) THEN
     PRINT*,"Input(): IBCFlag > MAXBCFlag (=",&
          MAXBCFlag,")"
     IErr= 1
  ENDIF
  
  IF( IRNGFlag.GT.MAXRNGFlag ) THEN
     PRINT*,"Input(): IRNGFlag > MAXRNGFlag (=",&
          MAXRNGFlag,")"
     IErr= 1
  ENDIF
  
  IF( IKeepFlag.GT.MAXKeepFlag ) THEN
     PRINT*,"Input(): IKeepFlag > MAXKeepFlag (=",&
          MAXKeepFlag,")"
     IErr= 1
  ENDIF
  
  IF( IWriteFlag.GT.MAXWriteFlag ) THEN
     PRINT*,"Input(): IWriteFlag > MAXWriteFlag (=",&
          MAXWriteFlag,")"
     IErr= 1
  ENDIF
  
  IF( ISortFlag.GT.MAXSortFlag ) THEN
     PRINT*,"Input(): ISortFlag > MAXSortFlag (=",&
          MAXSortFlag,")"
     IErr= 1
  ENDIF
  
  IF( IFluxFlag.GT.MAXFluxFlag ) THEN
     PRINT*,"Input(): IFluxFlag > MAXFluxFlag (=",&
          MAXFluxFlag,")"
     IErr= 1
  ENDIF
  
  IF( MagFlux.GT.TINY) THEN
     PRINT*,"Input(): MagFlux=", MagFlux, " is not implemented correctly - CAUTION!"
     PRINT*,"Input(): program will continue to execute, but results may be WRONG  !"
     IErr= 0
  ENDIF
  
  IF( Epsilon.LE.0.0D0) THEN
     PRINT*,"Input(): nonpositive Epsilon"
     IErr= 1
  ENDIF

  IF(IMidDump .NE. 0 .AND. IMidDump .NE. 1) THEN
     PRINT*,"Input(): Error - Acceptable values: IMidDump=0 >>"
     PRINT*,"Don't Dump Values, IMidDump=1 >> Dump Values"
     IErr=1
  ENDIF

  IF(IWalltime .LT. 0) THEN
     PRINT*,"Input(): Error - Must have positive walltime"
     IErr=1
  ENDIF
  
  IF(IRestart .LT. 0 .OR. IRestart .GT. 15) THEN
     PRINT*,"Input(): Error - Acceptable values: IRestart=0 >>"
     PRINT*,"No Auto Restart, IRestart=N >> Auto re-submit job N times"
     IErr=1
  ENDIF

  RETURN
  
  !	error in OPEN detected
120 PRINT*,"Input(): ERR in OPEN"
  GOTO 1000
  
  !	error in CLOSE detected
130 PRINT*,"Input(): ERR in CLOSE"
  GOTO 1000
  
  !	error in READ detected
20 PRINT*,"Input(): ERR in READ at line", ILine
  GOTO 1000
  
  !	EOF in READ occured prematurely
30 PRINT*,"Input(): EOF in READ at line", ILine
  
  ! dump the input help
  
1000 &
  PRINT*,"Input parameters:          ; explanation:"
  PRINT*,"--------------------------------------------------------------------"
  PRINT*,"ISeed         = 123456     ; (1) seed"
  
  PRINT*,"NOfIter       = 1          ; (2) # steps for SINGLE config."
  PRINT*,"NOfOrtho      = 10         ; (3) # steps until reorthonormalization"
  PRINT*,"NOfPrint      = 10         ; (4) # steps until printout"
  PRINT*,"NOfGamma      = 1          ; (5) # smallest Lyapunov exponents"

  PRINT*,"IBCFlag       = 0          ; (6) 0/1/2 = hard wall/periodic/antiperiodic BC"
  PRINT*,"IRNGFlag      = 0          ; (7) 0/1/2 = uniform/rescaled uniform/Gaussian disorder"
  PRINT*,"IKeepFlag     = 0          ; (8) 0/1 = yes/no data overwrite"
  PRINT*,"IWriteFlag    = 1          ; (9) 0/1/2/3/4 = no/log/category/wave fcn/Gamma/RHO output"
  PRINT*,"ISortFlag     = 0          ; (10) 0/1 = no/yes ReSort()"
  PRINT*,"IFluxFlag     = 1          ; (11) 0/1 = DiagDis/Energy loop"
  
  PRINT*,"Range0        = 0          ; (13) minimal width"
  PRINT*,"Range1        = 0          ; (14) maximal width"
  PRINT*,"dRange        = 0          ; (15) width increment"
  
  PRINT*,"DiagDis0      = 0.         ; (16) minimal diagonal disorder"
  PRINT*,"DiagDis1      = 5.         ; (17) maximal  diagonal disorder"
  PRINT*,"dDiagDis      = 0.5        ; (18) increment of diagonal disorder"
  
  PRINT*,"Energy0       = 0.         ; (19) minimal energy"
  PRINT*,"Energy1       = 5.         ; (20) maximal energy"
  PRINT*,"dEnergy       = 0.5        ; (21) increment of energy"
  
  PRINT*,"IKappaFlag    = 1          ; (22) 0/1 = square/ZZ lattice"
  PRINT*,"Kappa         = 1.0        ; (23) inter-layer hopping"

  PRINT*,"MagFlux       = 0.0        ; (24) magnetic flux strength"
  PRINT*,"Epsilon       = 5.0E-2     ; (25) accuracy goal of iteration"

  PRINT*,"IMidDump      = 1          ; (26) # dump values"
  PRINT*,"IWalltime     = 20         ; (27) walltime"
  PRINT*,"IRestart      = 2          ; (28) # re-submit job"

  IErr= 1
  RETURN
  
END SUBROUTINE Input


!-------------------------------------------------------------------
!
! SaveCurrent: Save where you've gotten to!
!
!----------------------------------------------------------------

SUBROUTINE SaveCurrent(IErr)

  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels

  implicit none
  
  INTEGER(KIND=IKIND) :: IErr, IOne
  REAL (KIND=RKIND) ROfIter
  
  IErr=0
  IOne=1
  
  OPEN(UNIT= IChInp, ERR= 10, STATUS= 'REPLACE', FILE= 'tmseGR.inp')

     WRITE(IChInp,202,ERR=20) ISeed
202  FORMAT("ISeed        = ", I15.1)
     
     WRITE(IChInp,203,ERR=20) NOfIter
203  FORMAT("NOfIter      = ", I15.1)
     
     WRITE(IChInp,204,ERR=20) NOfOrtho
204  FORMAT("NOfOrtho     = ", I15.1)
     
     WRITE(IChInp,205,ERR=20) NOfPrint
205  FORMAT("NOfPrint     = ", I15.1)
     
     WRITE(IChInp,206,ERR=20) NOfGamma
206  FORMAT("NOfGamma     = ", I15.1)
     
     WRITE(IChInp,207,ERR=20) IBCFlag
207  FORMAT("IBCFlag      = ", I15.1)
     
     WRITE(IChInp,208,ERR=20) IRNGFlag
208  FORMAT("IRNGFlag     = ", I15.1)
     
     WRITE(IChInp,209,ERR=20) IOne !IKeepFlag
209  FORMAT("IKeepFlag    = ", I15.1)
     
     WRITE(IChInp,210,ERR=20) IWriteFlag
210  FORMAT("IWriteFlag   = ", I15.1)
     
     WRITE(IChInp,211,ERR=20) ISortFlag
211  FORMAT("ISortFlag    = ", I15.1)
     
     WRITE(IChInp,212,ERR=20) IFluxFlag
212  FORMAT("IFluxFlag    = ", I15.1)

     WRITE(IChInp,214,ERR=20) Range0
214  FORMAT("Range0       = ", I15.1)
     
     WRITE(IChInp,215,ERR=20) Range1
215  FORMAT("Range1       = ", I15.1)
     
     WRITE(IChInp,216,ERR=20) dRange
216  FORMAT("dRange       = ", I15.1)
     
     WRITE(IChInp,217,ERR=20) DiagDis
217  FORMAT("DiagDis0     = ", F18.9)
     
     WRITE(IChInp,218,ERR=20) DiagDis1
218  FORMAT("DiagDis1     = ", F18.9)
     
     WRITE(IChInp,219,ERR=20) dDiagDis
219  FORMAT("dDiagDis     = ", F18.9)
     
     WRITE(IChInp,220,ERR=20) Energy
220  FORMAT("Energy0      = ", F18.9)
     
     WRITE(IChInp,221,ERR=20) Energy1
221  FORMAT("Energy1      = ", F18.9)
     
     WRITE(IChInp,222,ERR=20) dEnergy
222  FORMAT("dEnergy      = ", F18.9)

     WRITE(IChInp,223,ERR=20) IKappaFlag
223  FORMAT("IKappaFlag   = ", I15.1)

     WRITE(IChInp,224,ERR=20) Kappa
224  FORMAT("Kappa        = ", F18.9)

     WRITE(IChInp,225,ERR=20) MagFlux
225  FORMAT("MagFlux      = ", F18.9)
     
     WRITE(IChInp,226,ERR=20) Epsilon
226  FORMAT("Epsilon      = ", F18.9)
     
     WRITE(IChInp, 227, ERR=20) IMidDump
227  FORMAT("IMidDump     = ",I15.1)

     WRITE(IChInp, 228, ERR=20) IWalltime
228  FORMAT("IWalltime    = ",I15.1)

     WRITE(IChInp, 229, ERR=20) IRestart
229  FORMAT("IRestart     = ",I15.1)
  
  CLOSE(UNIT= IChInp, ERR=30)

  RETURN

10 PRINT*,"SaveCurrent(): ERR in OPEN()"
  IErr= 1
  RETURN

20 PRINT*,"SaveCurrent(): ERR in WRITE()"
  IErr= 1
  RETURN

30 PRINT*,"SaveCurrent(): ERR in CLOSE()"
  IErr= 1
  RETURN

END SUBROUTINE SaveCurrent


!--------------------------------------------------------------------
!CheckOutputAvg: Try to create new .raw file, fails if exists!
!
!	IErr	error code
!---------------------------------------------------------------------

SUBROUTINE CheckOutputAvg( IErr )

  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IErr

  LOGICAL::LExist
  
  CHARACTER*23 CName
  
  !	PRINT*,"DBG: CheckOutputAvg()"
  
  IErr= 0
  
  !   WRITE out the input parameter

  IF (IFluxFlag .EQ. 0) THEN
     WRITE(CName,300) IRange,"W-",ISeed,"S-Dis.raw"
  ELSE
     WRITE(CName,301) IRange,"W-",ISeed,"S-Ene.raw"
  ENDIF

300  FORMAT(I4.4,A2,I5.5,A9)
301  FORMAT(I4.4,A2,I5.5,A9)

  !PRINT*, "flag: Checking AVG"

  INQUIRE(FILE=CName, ERR=10, EXIST=LExist)

  RETURN

 !	error in OPEN detected
10 PRINT*,"CheckOutputAvg(): ERR in OPEN()"
  IErr= 1
  RETURN
  
END SUBROUTINE CheckOutputAvg


!-----------------------------------------------------------------------
!OpenOutputAvg: Open AVG file for first time and write input parameters
!
!	IErr	error code
!-----------------------------------------------------------------------

SUBROUTINE OpenOutputAvg( IErr )
  
  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IErr
  
  CHARACTER*23 CName
  CHARACTER*23 PName
  
  !PRINT*,"DBG: OpenOutputAvg()"
  
  IErr= 0

   !	WRITE out the input parameter

  IF (IFluxFlag .EQ. 0) THEN
     WRITE(CName,300) IRange,"W-",ISeed,"S-Dis.raw"
  ELSE
     WRITE(CName,301) IRange,"W-",ISeed,"S-Ene.raw"
  ENDIF

  IF (IFluxFlag .EQ. 0) THEN
     WRITE(PName,300) IRange,"W-",ISeed,"S-Dis.psi"
  ELSE
     WRITE(PName,301) IRange,"W-",ISeed,"S-Ene.psi"
  ENDIF

300  FORMAT(I4.4,A2,I5.5,A9)
301  FORMAT(I4.4,A2,I5.5,A9)

     OPEN(UNIT=IChOut, ERR=10, STATUS= 'NEW', FILE=CName)

     OPEN(UNIT=IChOutPsi, ERR=10, STATUS= 'NEW', FILE=PName)

     WRITE(IChOut,201,ERR=20) RStr,DStr,AStr
201   FORMAT("(* ",3A," *)")
     
     WRITE(IChOut,202,ERR=20) ISeed
202  FORMAT("ISeed        = ", I15.1)
     
     WRITE(IChOut,203,ERR=20) NOfIter
203  FORMAT("NOfIter      = ", I15.1)
     
     WRITE(IChOut,204,ERR=20) NOfOrtho
204  FORMAT("NOfOrtho     = ", I15.1)
     
     WRITE(IChOut,205,ERR=20) NOfPrint
205  FORMAT("NOfPrint     = ", I15.1)
     
     WRITE(IChOut,206,ERR=20) NOfGamma
206  FORMAT("NOfGamma     = ", I15.1)
     
     WRITE(IChOut,207,ERR=20) IBCFlag
207  FORMAT("IBCFlag      = ", I15.1)
     
     WRITE(IChOut,208,ERR=20) IRNGFlag
208  FORMAT("IRNGFlag     = ", I15.1)
     
     WRITE(IChOut,209,ERR=20) IKeepFlag
209  FORMAT("IKeepFlag    = ", I15.1)
     
     WRITE(IChOut,210,ERR=20) IWriteFlag
210  FORMAT("IWriteFlag   = ", I15.1)
     
     WRITE(IChOut,211,ERR=20) ISortFlag
211  FORMAT("ISortFlag    = ", I15.1)
     
     WRITE(IChOut,212,ERR=20) IFluxFlag
212  FORMAT("IFluxFlag    = ", I15.1)

     WRITE(IChOut,214,ERR=20) Range0
214  FORMAT("Range0       = ", I15.1)
     
     WRITE(IChOut,215,ERR=20) Range1
215  FORMAT("Range1       = ", I15.1)
     
     WRITE(IChOut,216,ERR=20) dRange
216  FORMAT("dRange       = ", I15.1)
     
     WRITE(IChOut,217,ERR=20) DiagDis0
217  FORMAT("DiagDis0     = ", F18.9)
     
     WRITE(IChOut,218,ERR=20) DiagDis1
218  FORMAT("DiagDis1     = ", F18.9)
     
     WRITE(IChOut,219,ERR=20) dDiagDis
219  FORMAT("dDiagDis     = ", F18.9)
     
     WRITE(IChOut,220,ERR=20) Energy0
220  FORMAT("energy0      = ", F18.9)
     
     WRITE(IChOut,221,ERR=20) Energy1
221  FORMAT("energy1      = ", F18.9)
     
     WRITE(IChOut,222,ERR=20) dEnergy
222  FORMAT("denergy      = ", F18.9)

     WRITE(IChOut,223,ERR=20) IKappaFlag
223  FORMAT("IKappaFlag   = ", I15.1)

     WRITE(IChOut,224,ERR=20) Kappa
224  FORMAT("Kappa        = ", F18.9)

     WRITE(IChOut,225,ERR=20) MagFlux
225  FORMAT("MagFlux      = ", F18.9)
     
     WRITE(IChOut,226,ERR=20) Epsilon
226  FORMAT("epsilon      = ", F18.9) 
     
     WRITE(IChOut, 227, ERR=20) IMidDump
227  FORMAT("IMidDump     = ",I15.1)

     WRITE(IChOut, 228, ERR=20) IWalltime
228  FORMAT("IWalltime    = ",I15.1)

     WRITE(IChOut, 229, ERR=20) IRestart
229  FORMAT("IRestart     = ",I15.1)

     WRITE(IChOut,500,ERR=20)
500  FORMAT("data= {")
     
  RETURN
     
  !	error in OPEN detected
10 PRINT*,"OpenOutputAvg(): ERR in OPEN()"
  IErr= 1
  RETURN
  
  !	error in WRITE detected
20 PRINT*,"OpenOutputAvg(): ERR in WRITE()"
  IErr= 1
  RETURN
  
END SUBROUTINE OpenOutputAvg


!----------------------------------------------------------------------
! ReOpenOutputAvg: Re-Open AVG file, does not write input parameters
!
! IErr	error code
!-----------------------------------------------------------------------

SUBROUTINE ReOpenOutputAvg( IErr )
  
  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IErr
  
  CHARACTER*23 CName
  CHARACTER*23 PName
  
  ! PRINT*,"DBG: ReOpenOutputAvg()"

  IErr= 0
  
  ! WRITE out the input parameter

  IF (IFluxFlag .EQ. 0) THEN
     WRITE(CName,300) IRange,"W-",ISeed,"S-Dis.raw"
  ELSE
     WRITE(CName,301) IRange,"W-",ISeed,"S-Ene.raw"
  ENDIF

 IF (IFluxFlag .EQ. 0) THEN
     WRITE(PName,300) IRange,"W-",ISeed,"S-Dis.psi"
  ELSE
     WRITE(PName,301) IRange,"W-",ISeed,"S-Ene.psi"
  ENDIF

300  FORMAT(I4.4,A2,I5.5,A9)
301  FORMAT(I4.4,A2,I5.5,A9)

 !PRINT*, "flag: Re-Opening AVG"

  OPEN(UNIT=IChOut, ERR=10, STATUS= 'OLD', ACCESS = 'APPEND', FILE=CName)

  OPEN(UNIT=IChOutPsi, ERR=10, STATUS= 'OLD', ACCESS = 'APPEND', FILE=PName)

  RETURN

10 PRINT*, "ReOpenOutputAvg(): Error in OPEN()"
  IErr=1
  RETURN
  
END SUBROUTINE ReOpenOutputAvg


!--------------------------------------------------------------------
! WriteOutputAvg: Write Lyapunov exponent data if converged!
!
! IErr	error code
!---------------------------------------------------------------------

SUBROUTINE WriteOutputAvg(&
     IRange, 	&
     DiagDis, 	&
     Energy,	&
     gam, var, NOfL,  &
     psi,	&
     IErr, TMM_CONVERGED)
        
  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IRange, NOfL, IErr, TMM_CONVERGED
  REAL(KIND=RKIND) DiagDis, Energy,&
       psi(IRange,IRange)
  
  REAL(KIND=RKIND) gam(NOfL), var(NOfL)
  
  INTEGER iState, jSite, iL
  
  !PRINT*,"DBG: WriteOutputAvg()"
  
  IErr= 0
  
  ! average Lyapunov exponent Gamma
  
  DO iL= 1,NOfL
     
     WRITE(IChOut,410,ERR=10) &
          iL, &
          DiagDis, &
          Energy, &
          gam(iL), var(iL), &
          TMM_CONVERGED
     
410  FORMAT("{ ", I7.1, &
          ", ", F15.6, &
          ", ", F15.6, &
          ", ", F25.16, &
          ", ", F25.16, &
          ", ", I1.1, &
          " },")

  ENDDO
           

      RETURN
           
      !	ERR in Write detected
10    PRINT*,"WriteOutputAvg(): ERR in WRITE()"
      IErr= 1
      RETURN
           
END SUBROUTINE WriteOutputAvg

!--------------------------------------------------------------------
! WriteOutputPsi: Write Lyapunov exponent data if converged!
!
! IErr	error code
!---------------------------------------------------------------------

SUBROUTINE WriteOutputPsi(&
     Ilayer, IRange,	&
     psi,	&
     IErr)
        
  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER Ilayer, IErr, IRange
  COMPLEX(KIND=CKIND) psi(IRange,IRange)
  
  INTEGER jState, iSite

  ! wavefunctions

    IF( IWriteFlag.GE.1 ) THEN
        
        DO jState= 1, 1
           
           DO iSite= 1, IRange
              WRITE(IChOutPsi,550,ERR=10) Ilayer, iSite,&
                   psi(IRange+1-jState,iSite)**2
550           FORMAT( I9.1, " ", I4.1, " ", 1(F25.15), " ", 1(F25.15) )
           ENDDO
              
        ENDDO
              
      ENDIF
           

      RETURN
           
      !	ERR in Write detected
10    PRINT*,"WriteOutputAvg(): ERR in WRITE()"
      IErr= 1
      RETURN
           
END SUBROUTINE WriteOutputPsi

!--------------------------------------------------------------------
! CloseOutputAvg: Close AVG file
!
! IErr	error code
!---------------------------------------------------------------------

SUBROUTINE CloseOutputAvg( IErr )

  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IErr
  
  !PRINT*,"DBG: CloseOutputAvg()"
  
  IErr= 0
  
  CLOSE(UNIT= IChOut, ERR= 10)

  CLOSE(UNIT= IChOutPsi, ERR= 10)
     
  RETURN
     
  ! ERR in CLOSE detected
10 PRINT*,"CloseOutputAvg(): ERR in CLOSE()"
  IErr= 1
  RETURN
  
END SUBROUTINE CloseOutputAvg


!--------------------------------------------------------------------
!OpenOutputGamma: Creates file to save the Lyapunov exponents
!
!	IErr	error code
!-------------------------------------------------------------------

SUBROUTINE OpenOutputGamma( IRange, &
           DiagDis, Energy,  &
           IErr )

   USE MyNumbers

	USE CConstants
	USE IConstants
	
	USE IPara
	USE DPara

	USE IChannels

   INTEGER IRange, IErr
   REAL(KIND=RKIND) DiagDis, Energy
	
	INTEGER ICh

   CHARACTER*24 CNameP
   CHARACTER*25 CNameM

! PRINT*,"DBG: OpenOutputGamma()"

	IErr= 0
   ICh = IChOutGam

!	the filename is different for this gamma logging

   IF( Energy.GE.-1.0D-10 ) THEN

		WRITE(CNameP, 100)                        &
            IRange,".",									&
            NINT(100.0D0*ABS(DiagDis)),".",		&
            NINT(100.0D0*ABS(Energy))
100	FORMAT(I4.4,A1,I4.4,A1,I4.4)

		OPEN(UNIT= ICh, ERR= 10, STATUS= 'UNKNOWN', &
		     FILE=CNameP)
	ELSE

		WRITE(CNameM, 200)                         &
		      IRange,".",			 &
		      NINT(100.0D0*ABS(DiagDis)),".-",		 &
		      NINT(100.0D0*ABS(Energy))
200	FORMAT(I4.4,A1,I4.4,A2,I4.4) 

		OPEN(UNIT= ICh, ERR= 10, STATUS= 'UNKNOWN', &
		     FILE=CNameM)
	ENDIF

	RETURN

!	error in OPEN detected
10	PRINT*,"OpenOutputGamma(): ERR in OPEN()"
	IErr= 1
	RETURN

END SUBROUTINE OpenOutputGamma


!--------------------------------------------------------------------
!WriteOutputGamma: Save the Lyapunov Exponents
!
!	IErr	error code
!--------------------------------------------------------------------

SUBROUTINE WriteOutputGamma( index, gam, var, NOfL, IErr )
        
   USE MyNumbers

	USE CConstants
	USE IConstants

	USE IPara
	USE DPara

	USE IChannels

	INTEGER index, NOfL, IErr
	REAL(KIND=RKIND) gam(NOfL), var(NOfL)

	INTEGER ICh, iL

! 	PRINT*,"DBG: WriteOutputGamma()"

	IErr= 0
	ICh = IChOutGam

!	Lyapunov exponent Gamma

	DO 100 iL=1,NOfL
		WRITE(ICh,410,ERR=10) index, iL, gam(iL), var(iL)
410	FORMAT(" ",I7.1, " ", I4.1, " ", G25.16, " ", G25.16)
100 &
	CONTINUE

	RETURN

!	ERR in Write detected
10	PRINT*,"WriteOutputGamma(): ERR in WRITE()"
	IErr= 1
	RETURN

END SUBROUTINE WriteOutputGamma


!--------------------------------------------------------------------
!CloseOutputGamma: Close the Lyapunov exponents storage file
!
!	IErr	error code
!--------------------------------------------------------------------

SUBROUTINE CloseOutputGamma( IErr )

	USE CConstants
	USE IConstants

	USE IPara
	USE DPara

	USE IChannels

	INTEGER IErr

	INTEGER ICh

!	PRINT*,"DBG: CloseOutputGamma()"

	IErr= 0
	ICh = IChOutGam

	CLOSE(UNIT= ICh, ERR= 10)

	RETURN

!	ERR in CLOSE detected
10	PRINT*,"CloseOutputGamma(): ERR in CLOSE()"
	IErr= 1
	RETURN

END SUBROUTINE CloseOutputGamma

!------------------------------------------------------------------
! LoadLoopParams: This restarts a mid-way complete TMM!
!
!	IErr	error code
!-------------------------------------------------------------------

SUBROUTINE LoadLoopParams(IErr)

        USE MyNumbers
        USE Randoms
        USE Extensions
        USE Gammas

	USE CConstants
	USE IConstants

	USE IPara
	USE DPara

	USE IChannels

	INTEGER IErr
        INTEGER ICh

        IErr=0
        ICh=IChLoadLP

        OPEN(UNIT= ICh, ERR=10, FILE= "tmseGR.tmp", STATUS= 'OLD')
        READ(ICh,*,ERR=20) index1,PsiB,PsiA,gamma,gamma2,&
           acc_variance,nGamma,z1,z2,z3,z4
        CLOSE(UNIT= ICh, ERR=30)

        index1=index1+1
        RETURN

10      PRINT*,"LoadLoopParams(): ERR in OPEN()"
        IErr= 1
        RETURN

20      PRINT*,"LoadLoopParams(): ERR in READ()"
        IErr= 1
        RETURN

30      PRINT*,"LoadLoopParams(): ERR in CLOSE()"
        IErr= 1
        RETURN

END SUBROUTINE LoadLoopParams

!-----------------------------------------------------------------
! SaveLoopParams: Saves mid-way parameters for a restart!
!
!	IErr	error code
!-----------------------------------------------------------------

SUBROUTINE SaveLoopParams(IErr)

        USE MyNumbers
        USE Randoms
        USE Extensions
        USE Gammas

	USE CConstants
	USE IConstants

	USE IPara
	USE DPara

	USE IChannels

	INTEGER IErr
        INTEGER ICh

        IErr=0
        ICh=IChSaveLP

        OPEN(UNIT= ICh, ERR=10, FILE= "tmseGR.tmp", STATUS= "REPLACE")
        WRITE(ICh,*,ERR=20) Iter1,PsiB,PsiA,gamma,gamma2,&
           acc_variance,nGamma,z1,z2,z3,z4
        CLOSE(UNIT= ICh, ERR=30)
  
        RETURN
  
10      PRINT*,"SaveLoopParams(): ERR in OPEN()"
        IErr= 1
        RETURN
  
20      PRINT*,"SaveLoopParams(): ERR in WRITE()"
        IErr= 1
        RETURN
  
30      PRINT*,"SaveLoopParams(): ERR in CLOSE()"
        IErr= 1
        RETURN
  
END SUBROUTINE SaveLoopParams

!-------------------------------------------------------------------
! RestartRoutineZZENEHW: Submit new job to the CoW from Fortran!
!
!	IErr	error code
!--------------------------------------------------------------------

SUBROUTINE RestartRoutineZZENEHW(IErr)


   USE MyNumbers
   USE Randoms
   
   USE CConstants
   USE IConstants

   USE IPara
   USE DPara

   USE IChannels

   INTEGER IErr
   INTEGER ICh

   INTEGER(KIND=IKIND) ::  a, b, i
   CHARACTER(100) :: Jobname, NewJobname, OutJobname, &
                     StrDis,StrEne0,StrWalltime,StrRange

   !PRINT*, "flag: restartroutine - assigned data types"     

   ICh=IChRes

   WRITE(StrWalltime,'(I6)') IWalltime
   WRITE(StrRange,'(I6)') Range0
   WRITE(StrDis,'(F12.5)') DiagDis0
   WRITE(StrEne0,'(F12.5)') Energy0

  !PRINT*, "flag: restartroutine - wrote initial strings"     


  a = len_trim(StrDis)
  b = INDEX(StrDis, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrDis(i:i) .EQ. '0') THEN
        StrDis(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO

  a = len_trim(StrEne0)
  b = INDEX(StrEne0, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrEne0(i:i) .EQ. '0') THEN
        StrEne0(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO


 ! PRINT*, "flag: restartroutine - trimmed initial strings"  

  WRITE(Jobname,*) "TMM-ZZ-HW-ENE-w",trim(adjustl(StrRange)),&
       "-d",trim(adjustl(StrDis))

  WRITE(NewJobname,*) "R-TMM-ZZ-HW-ENE-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".pbs"

   WRITE(OutJobname,*) "R-TMM-ZZ-HW-ENE-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".out"

  OPEN(UNIT= ICh, ERR=10, FILE= NewJobname, STATUS= "REPLACE")

  WRITE(ICh,*,ERR=20) "#!/bin/bash"
  WRITE(ICh,*,ERR=20) "#PBS -l nodes=1:ppn=1,pvmem=500mb"
  WRITE(ICh,*,ERR=20) "#PBS -l walltime=",trim(adjustl(StrWalltime)),":00:00"
  WRITE(ICh,*,ERR=20) "#PBS -V"
  WRITE(ICh,*,ERR=20) "#PBS -m bea"
  WRITE(ICh,*,ERR=20) "#PBS -r y"
  WRITE(ICh,*,ERR=20) "#PBS -j oe"
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cd $PBS_O_WORKDIR"
  WRITE(ICh,*,ERR=20) "cd /gpfs/ccspam/RUNS/", trim(adjustl(Jobname))
  WRITE(ICh,*,ERR=20) 
  WRITE(ICh,*,ERR=20) "sleep 40"
  WRITE(ICh,*,ERR=20) "./tmseGR.PG  <tmseGR.inp>> ", trim(adjustl(OutJobname))
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cp *.raw /gpfs/ccspam/Projects/GrapheneTMM/", trim(adjustl(Jobname))

  CLOSE(UNIT= ICh, ERR=30)

  CALL SYSTEM("qsub -r y " // trim(adjustl(NewJobname)))
  
  RETURN

10 PRINT*,"RestartRoutine(): ERR in OPEN()"
  IErr= 1
  RETURN
  
20 PRINT*,"RestartRoutine(): ERR in WRITE()"
  IErr= 1
  RETURN
  
30 PRINT*,"RestartRoutine(): ERR in CLOSE()"
  IErr= 1
  RETURN

END SUBROUTINE RestartRoutineZZENEHW

!-------------------------------------------------------------------
! RestartRoutineZZENEPBC: Submit new job to the CoW from Fortran!
!
!	IErr	error code
!--------------------------------------------------------------------

SUBROUTINE RestartRoutineZZENEPBC(IErr)


   USE MyNumbers
   USE Randoms
   
   USE CConstants
   USE IConstants

   USE IPara
   USE DPara

   USE IChannels

   INTEGER IErr
   INTEGER ICh

   INTEGER(KIND=IKIND) ::  a, b, i
   CHARACTER(100) :: Jobname, NewJobname, OutJobname, &
                     StrDis,StrEne0,StrWalltime,StrRange

   !PRINT*, "flag: restartroutine - assigned data types"     

   ICh=IChRes

   WRITE(StrWalltime,'(I6)') IWalltime
   WRITE(StrRange,'(I6)') Range0
   WRITE(StrDis,'(F12.5)') DiagDis0
   WRITE(StrEne0,'(F12.5)') Energy0

  !PRINT*, "flag: restartroutine - wrote initial strings"     


  a = len_trim(StrDis)
  b = INDEX(StrDis, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrDis(i:i) .EQ. '0') THEN
        StrDis(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO

  a = len_trim(StrEne0)
  b = INDEX(StrEne0, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrEne0(i:i) .EQ. '0') THEN
        StrEne0(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO


 ! PRINT*, "flag: restartroutine - trimmed initial strings"  

  WRITE(Jobname,*) "TMM-ZZ-PBC-ENE-w",trim(adjustl(StrRange)),&
       "-d",trim(adjustl(StrDis))

  WRITE(NewJobname,*) "R-TMM-ZZ-PBC-ENE-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".pbs"

   WRITE(OutJobname,*) "R-TMM-ZZ-PBC-ENE-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".out"

  OPEN(UNIT= ICh, ERR=10, FILE= NewJobname, STATUS= "REPLACE")

  WRITE(ICh,*,ERR=20) "#!/bin/bash"
  WRITE(ICh,*,ERR=20) "#PBS -l nodes=1:ppn=1,pvmem=500mb"
  WRITE(ICh,*,ERR=20) "#PBS -l walltime=",trim(adjustl(StrWalltime)),":00:00"
  WRITE(ICh,*,ERR=20) "#PBS -V"
  WRITE(ICh,*,ERR=20) "#PBS -m bea"
  WRITE(ICh,*,ERR=20) "#PBS -r y"
  WRITE(ICh,*,ERR=20) "#PBS -j oe"
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cd $PBS_O_WORKDIR"
  WRITE(ICh,*,ERR=20) "cd /gpfs/ccspam/RUNS/", trim(adjustl(Jobname))
  WRITE(ICh,*,ERR=20) 
  WRITE(ICh,*,ERR=20) "sleep 40"
  WRITE(ICh,*,ERR=20) "./tmseGR.PG  <tmseGR.inp>> ", trim(adjustl(OutJobname))
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cp *.raw /gpfs/ccspam/Projects/GrapheneTMM/", trim(adjustl(Jobname))

  CLOSE(UNIT= ICh, ERR=30)

  CALL SYSTEM("qsub -r y " // trim(adjustl(NewJobname)))
  
  RETURN

10 PRINT*,"RestartRoutine(): ERR in OPEN()"
  IErr= 1
  RETURN
  
20 PRINT*,"RestartRoutine(): ERR in WRITE()"
  IErr= 1
  RETURN
  
30 PRINT*,"RestartRoutine(): ERR in CLOSE()"
  IErr= 1
  RETURN

END SUBROUTINE RestartRoutineZZENEPBC

!-------------------------------------------------------------------
! RestartRoutineACENEHW: Submit new job to the CoW from Fortran!
!
!	IErr	error code
!--------------------------------------------------------------------

SUBROUTINE RestartRoutineACENEHW(IErr)


   USE MyNumbers
   USE Randoms
   
   USE CConstants
   USE IConstants

   USE IPara
   USE DPara

   USE IChannels

   INTEGER IErr
   INTEGER ICh

   INTEGER(KIND=IKIND) ::  a, b, i
   CHARACTER(100) :: Jobname, NewJobname, OutJobname, &
                     StrDis,StrEne0,StrWalltime,StrRange

   !PRINT*, "flag: restartroutine - assigned data types"     

   ICh=IChRes

   WRITE(StrWalltime,'(I6)') IWalltime
   WRITE(StrRange,'(I6)') Range0
   WRITE(StrDis,'(F12.5)') DiagDis0
   WRITE(StrEne0,'(F12.5)') Energy0

  !PRINT*, "flag: restartroutine - wrote initial strings"     


  a = len_trim(StrDis)
  b = INDEX(StrDis, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrDis(i:i) .EQ. '0') THEN
        StrDis(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO

  a = len_trim(StrEne0)
  b = INDEX(StrEne0, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrEne0(i:i) .EQ. '0') THEN
        StrEne0(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO


 ! PRINT*, "flag: restartroutine - trimmed initial strings"  

  WRITE(Jobname,*) "TMM-AC-HW-ENE-w",trim(adjustl(StrRange)),&
       "-d",trim(adjustl(StrDis))

  WRITE(NewJobname,*) "R-TMM-AC-HW-ENE-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".pbs"

   WRITE(OutJobname,*) "R-TMM-AC-HW-ENE-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".out"

  OPEN(UNIT= ICh, ERR=10, FILE= NewJobname, STATUS= "REPLACE")

  WRITE(ICh,*,ERR=20) "#!/bin/bash"
  WRITE(ICh,*,ERR=20) "#PBS -l nodes=1:ppn=1,pvmem=500mb"
  WRITE(ICh,*,ERR=20) "#PBS -l walltime=",trim(adjustl(StrWalltime)),":00:00"
  WRITE(ICh,*,ERR=20) "#PBS -V"
  WRITE(ICh,*,ERR=20) "#PBS -m bea"
  WRITE(ICh,*,ERR=20) "#PBS -r y"
  WRITE(ICh,*,ERR=20) "#PBS -j oe"
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cd $PBS_O_WORKDIR"
  WRITE(ICh,*,ERR=20) "cd /gpfs/ccspam/RUNS/", trim(adjustl(Jobname))
  WRITE(ICh,*,ERR=20) 
  WRITE(ICh,*,ERR=20) "sleep 40"
  WRITE(ICh,*,ERR=20) "./tmseGR.PG  <tmseGR.inp>> ", trim(adjustl(OutJobname))
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cp *.raw /gpfs/ccspam/Projects/GrapheneTMM/", trim(adjustl(Jobname))

  CLOSE(UNIT= ICh, ERR=30)

  CALL SYSTEM("qsub -r y " // trim(adjustl(NewJobname)))
  
  RETURN

10 PRINT*,"RestartRoutine(): ERR in OPEN()"
  IErr= 1
  RETURN
  
20 PRINT*,"RestartRoutine(): ERR in WRITE()"
  IErr= 1
  RETURN
  
30 PRINT*,"RestartRoutine(): ERR in CLOSE()"
  IErr= 1
  RETURN

END SUBROUTINE RestartRoutineACENEHW

!-------------------------------------------------------------------
! RestartRoutineACENEPBC: Submit new job to the CoW from Fortran!
!
!	IErr	error code
!--------------------------------------------------------------------

SUBROUTINE RestartRoutineACENEPBC(IErr)


   USE MyNumbers
   USE Randoms
   
   USE CConstants
   USE IConstants

   USE IPara
   USE DPara

   USE IChannels

   INTEGER IErr
   INTEGER ICh

   INTEGER(KIND=IKIND) ::  a, b, i
   CHARACTER(100) :: Jobname, NewJobname, OutJobname, &
                     StrDis,StrEne0,StrWalltime,StrRange

   !PRINT*, "flag: restartroutine - assigned data types"     

   ICh=IChRes

   WRITE(StrWalltime,'(I6)') IWalltime
   WRITE(StrRange,'(I6)') Range0
   WRITE(StrDis,'(F12.5)') DiagDis0
   WRITE(StrEne0,'(F12.5)') Energy0

  !PRINT*, "flag: restartroutine - wrote initial strings"     


  a = len_trim(StrDis)
  b = INDEX(StrDis, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrDis(i:i) .EQ. '0') THEN
        StrDis(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO

  a = len_trim(StrEne0)
  b = INDEX(StrEne0, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrEne0(i:i) .EQ. '0') THEN
        StrEne0(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO


 ! PRINT*, "flag: restartroutine - trimmed initial strings"  

  WRITE(Jobname,*) "TMM-AC-PBC-ENE-w",trim(adjustl(StrRange)),&
       "-d",trim(adjustl(StrDis))

  WRITE(NewJobname,*) "R-TMM-AC-PBC-ENE-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".pbs"

   WRITE(OutJobname,*) "R-TMM-AC-PBC-ENE-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".out"

  OPEN(UNIT= ICh, ERR=10, FILE= NewJobname, STATUS= "REPLACE")

  WRITE(ICh,*,ERR=20) "#!/bin/bash"
  WRITE(ICh,*,ERR=20) "#PBS -l nodes=1:ppn=1,pvmem=500mb"
  WRITE(ICh,*,ERR=20) "#PBS -l walltime=",trim(adjustl(StrWalltime)),":00:00"
  WRITE(ICh,*,ERR=20) "#PBS -V"
  WRITE(ICh,*,ERR=20) "#PBS -m bea"
  WRITE(ICh,*,ERR=20) "#PBS -r y"
  WRITE(ICh,*,ERR=20) "#PBS -j oe"
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cd $PBS_O_WORKDIR"
  WRITE(ICh,*,ERR=20) "cd /gpfs/ccspam/RUNS/", trim(adjustl(Jobname))
  WRITE(ICh,*,ERR=20) 
  WRITE(ICh,*,ERR=20) "sleep 40"
  WRITE(ICh,*,ERR=20) "./tmseGR.PG  <tmseGR.inp>> ", trim(adjustl(OutJobname))
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cp *.raw /gpfs/ccspam/Projects/GrapheneTMM/", trim(adjustl(Jobname))

  CLOSE(UNIT= ICh, ERR=30)

  CALL SYSTEM("qsub -r y " // trim(adjustl(NewJobname)))
  
  RETURN

10 PRINT*,"RestartRoutine(): ERR in OPEN()"
  IErr= 1
  RETURN
  
20 PRINT*,"RestartRoutine(): ERR in WRITE()"
  IErr= 1
  RETURN
  
30 PRINT*,"RestartRoutine(): ERR in CLOSE()"
  IErr= 1
  RETURN

END SUBROUTINE RestartRoutineACENEPBC

!-------------------------------------------------------------------
! RestartRoutineZZDISHW: Submit new job to the CoW from Fortran!
!
!	IErr	error code
!--------------------------------------------------------------------

SUBROUTINE RestartRoutineZZDISHW(IErr)


   USE MyNumbers
   USE Randoms
   
   USE CConstants
   USE IConstants

   USE IPara
   USE DPara

   USE IChannels

   INTEGER IErr
   INTEGER ICh

   INTEGER(KIND=IKIND) ::  a, b, i
   CHARACTER(100) :: Jobname, NewJobname, OutJobname, &
                     StrDis,StrEne0,StrWalltime,StrRange

   !PRINT*, "flag: restartroutine - assigned data types"     

   ICh=IChRes

   WRITE(StrWalltime,'(I6)') IWalltime
   WRITE(StrRange,'(I6)') Range0
   WRITE(StrDis,'(F12.5)') DiagDis0
   WRITE(StrEne0,'(F12.5)') Energy0

  !PRINT*, "flag: restartroutine - wrote initial strings"     


  a = len_trim(StrDis)
  b = INDEX(StrDis, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrDis(i:i) .EQ. '0') THEN
        StrDis(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO

  a = len_trim(StrEne0)
  b = INDEX(StrEne0, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrEne0(i:i) .EQ. '0') THEN
        StrEne0(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO


 ! PRINT*, "flag: restartroutine - trimmed initial strings"  

  WRITE(Jobname,*) "TMM-ZZ-HW-DIS-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)) 

  WRITE(NewJobname,*) "R-TMM-ZZ-HW-DIS-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".pbs"

   WRITE(OutJobname,*) "R-TMM-ZZ-HW-DIS-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".out"

  OPEN(UNIT= ICh, ERR=10, FILE= NewJobname, STATUS= "REPLACE")

  WRITE(ICh,*,ERR=20) "#!/bin/bash"
  WRITE(ICh,*,ERR=20) "#PBS -l nodes=1:ppn=1,pvmem=500mb"
  WRITE(ICh,*,ERR=20) "#PBS -l walltime=",trim(adjustl(StrWalltime)),":00:00"
  WRITE(ICh,*,ERR=20) "#PBS -V"
  WRITE(ICh,*,ERR=20) "#PBS -m bea"
  WRITE(ICh,*,ERR=20) "#PBS -r y"
  WRITE(ICh,*,ERR=20) "#PBS -j oe"
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cd $PBS_O_WORKDIR"
  WRITE(ICh,*,ERR=20) "cd /gpfs/ccspam/RUNS/", trim(adjustl(Jobname))
  WRITE(ICh,*,ERR=20) 
  WRITE(ICh,*,ERR=20) "sleep 40"
  WRITE(ICh,*,ERR=20) "./tmseGR.PG  <tmseGR.inp>> ", trim(adjustl(OutJobname))
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cp *.raw /gpfs/ccspam/Projects/GrapheneTMM/", trim(adjustl(Jobname))

  CLOSE(UNIT= ICh, ERR=30)

  CALL SYSTEM("qsub -r y " // trim(adjustl(NewJobname)))
  
  RETURN

10 PRINT*,"RestartRoutine(): ERR in OPEN()"
  IErr= 1
  RETURN
  
20 PRINT*,"RestartRoutine(): ERR in WRITE()"
  IErr= 1
  RETURN
  
30 PRINT*,"RestartRoutine(): ERR in CLOSE()"
  IErr= 1
  RETURN

END SUBROUTINE RestartRoutineZZDISHW

!-------------------------------------------------------------------
! RestartRoutineZZDISPBC: Submit new job to the CoW from Fortran!
!
!	IErr	error code
!--------------------------------------------------------------------

SUBROUTINE RestartRoutineZZDISPBC(IErr)


   USE MyNumbers
   USE Randoms
   
   USE CConstants
   USE IConstants

   USE IPara
   USE DPara

   USE IChannels

   INTEGER IErr
   INTEGER ICh

   INTEGER(KIND=IKIND) ::  a, b, i
   CHARACTER(100) :: Jobname, NewJobname, OutJobname, &
                     StrDis,StrEne0,StrWalltime,StrRange

   !PRINT*, "flag: restartroutine - assigned data types"     

   ICh=IChRes

   WRITE(StrWalltime,'(I6)') IWalltime
   WRITE(StrRange,'(I6)') Range0
   WRITE(StrDis,'(F12.5)') DiagDis0
   WRITE(StrEne0,'(F12.5)') Energy0

  !PRINT*, "flag: restartroutine - wrote initial strings"     


  a = len_trim(StrDis)
  b = INDEX(StrDis, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrDis(i:i) .EQ. '0') THEN
        StrDis(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO

  a = len_trim(StrEne0)
  b = INDEX(StrEne0, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrEne0(i:i) .EQ. '0') THEN
        StrEne0(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO


 ! PRINT*, "flag: restartroutine - trimmed initial strings"  

  WRITE(Jobname,*) "TMM-ZZ-PBC-DIS-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)) 

  WRITE(NewJobname,*) "R-TMM-ZZ-PBC-DIS-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".pbs"

   WRITE(OutJobname,*) "R-TMM-ZZ-PBC-DIS-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".out"

  OPEN(UNIT= ICh, ERR=10, FILE= NewJobname, STATUS= "REPLACE")

  WRITE(ICh,*,ERR=20) "#!/bin/bash"
  WRITE(ICh,*,ERR=20) "#PBS -l nodes=1:ppn=1,pvmem=500mb"
  WRITE(ICh,*,ERR=20) "#PBS -l walltime=",trim(adjustl(StrWalltime)),":00:00"
  WRITE(ICh,*,ERR=20) "#PBS -V"
  WRITE(ICh,*,ERR=20) "#PBS -m bea"
  WRITE(ICh,*,ERR=20) "#PBS -r y"
  WRITE(ICh,*,ERR=20) "#PBS -j oe"
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cd $PBS_O_WORKDIR"
  WRITE(ICh,*,ERR=20) "cd /gpfs/ccspam/RUNS/", trim(adjustl(Jobname))
  WRITE(ICh,*,ERR=20) 
  WRITE(ICh,*,ERR=20) "sleep 40"
  WRITE(ICh,*,ERR=20) "./tmseGR.PG  <tmseGR.inp>> ", trim(adjustl(OutJobname))
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cp *.raw /gpfs/ccspam/Projects/GrapheneTMM/", trim(adjustl(Jobname))

  CLOSE(UNIT= ICh, ERR=30)

  CALL SYSTEM("qsub -r y " // trim(adjustl(NewJobname)))
  
  RETURN

10 PRINT*,"RestartRoutine(): ERR in OPEN()"
  IErr= 1
  RETURN
  
20 PRINT*,"RestartRoutine(): ERR in WRITE()"
  IErr= 1
  RETURN
  
30 PRINT*,"RestartRoutine(): ERR in CLOSE()"
  IErr= 1
  RETURN

END SUBROUTINE RestartRoutineZZDISPBC

!-------------------------------------------------------------------
! RestartRoutineACDISHW: Submit new job to the CoW from Fortran!
!
!	IErr	error code
!--------------------------------------------------------------------

SUBROUTINE RestartRoutineACDISHW(IErr)


   USE MyNumbers
   USE Randoms
   
   USE CConstants
   USE IConstants

   USE IPara
   USE DPara

   USE IChannels

   INTEGER IErr
   INTEGER ICh

   INTEGER(KIND=IKIND) ::  a, b, i
   CHARACTER(100) :: Jobname, NewJobname, OutJobname, &
                     StrDis,StrEne0,StrWalltime,StrRange

   !PRINT*, "flag: restartroutine - assigned data types"     

   ICh=IChRes

   WRITE(StrWalltime,'(I6)') IWalltime
   WRITE(StrRange,'(I6)') Range0
   WRITE(StrDis,'(F12.5)') DiagDis0
   WRITE(StrEne0,'(F12.5)') Energy0

  !PRINT*, "flag: restartroutine - wrote initial strings"     


  a = len_trim(StrDis)
  b = INDEX(StrDis, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrDis(i:i) .EQ. '0') THEN
        StrDis(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO

  a = len_trim(StrEne0)
  b = INDEX(StrEne0, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrEne0(i:i) .EQ. '0') THEN
        StrEne0(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO


 ! PRINT*, "flag: restartroutine - trimmed initial strings"  

  WRITE(Jobname,*) "TMM-AC-HW-DIS-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)) 

  WRITE(NewJobname,*) "R-TMM-AC-HW-DIS-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".pbs"

   WRITE(OutJobname,*) "R-TMM-AC-HW-DIS-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".out"

  OPEN(UNIT= ICh, ERR=10, FILE= NewJobname, STATUS= "REPLACE")

  WRITE(ICh,*,ERR=20) "#!/bin/bash"
  WRITE(ICh,*,ERR=20) "#PBS -l nodes=1:ppn=1,pvmem=500mb"
  WRITE(ICh,*,ERR=20) "#PBS -l walltime=",trim(adjustl(StrWalltime)),":00:00"
  WRITE(ICh,*,ERR=20) "#PBS -V"
  WRITE(ICh,*,ERR=20) "#PBS -m bea"
  WRITE(ICh,*,ERR=20) "#PBS -r y"
  WRITE(ICh,*,ERR=20) "#PBS -j oe"
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cd $PBS_O_WORKDIR"
  WRITE(ICh,*,ERR=20) "cd /gpfs/ccspam/RUNS/", trim(adjustl(Jobname))
  WRITE(ICh,*,ERR=20) 
  WRITE(ICh,*,ERR=20) "sleep 40"
  WRITE(ICh,*,ERR=20) "./tmseGR.PG  <tmseGR.inp>> ", trim(adjustl(OutJobname))
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cp *.raw /gpfs/ccspam/Projects/GrapheneTMM/", trim(adjustl(Jobname))

  CLOSE(UNIT= ICh, ERR=30)

  CALL SYSTEM("qsub -r y " // trim(adjustl(NewJobname)))
  
  RETURN

10 PRINT*,"RestartRoutine(): ERR in OPEN()"
  IErr= 1
  RETURN
  
20 PRINT*,"RestartRoutine(): ERR in WRITE()"
  IErr= 1
  RETURN
  
30 PRINT*,"RestartRoutine(): ERR in CLOSE()"
  IErr= 1
  RETURN

END SUBROUTINE RestartRoutineACDISHW

!-------------------------------------------------------------------
! RestartRoutineACDISPBC: Submit new job to the CoW from Fortran!
!
!	IErr	error code
!--------------------------------------------------------------------

SUBROUTINE RestartRoutineACDISPBC(IErr)


   USE MyNumbers
   USE Randoms
   
   USE CConstants
   USE IConstants

   USE IPara
   USE DPara

   USE IChannels

   INTEGER IErr
   INTEGER ICh

   INTEGER(KIND=IKIND) ::  a, b, i
   CHARACTER(100) :: Jobname, NewJobname, OutJobname, &
                     StrDis,StrEne0,StrWalltime,StrRange

   !PRINT*, "flag: restartroutine - assigned data types"     

   ICh=IChRes

   WRITE(StrWalltime,'(I6)') IWalltime
   WRITE(StrRange,'(I6)') Range0
   WRITE(StrDis,'(F12.5)') DiagDis0
   WRITE(StrEne0,'(F12.5)') Energy0

  !PRINT*, "flag: restartroutine - wrote initial strings"     


  a = len_trim(StrDis)
  b = INDEX(StrDis, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrDis(i:i) .EQ. '0') THEN
        StrDis(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO

  a = len_trim(StrEne0)
  b = INDEX(StrEne0, '.', BACK=.TRUE.)
  DO i= a,b+2,-1
     IF (StrEne0(i:i) .EQ. '0') THEN
        StrEne0(i:i) = ' '
     ELSE
        EXIT
     ENDIF
  ENDDO


 ! PRINT*, "flag: restartroutine - trimmed initial strings"  

  WRITE(Jobname,*) "TMM-AC-PBC-DIS-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)) 

  WRITE(NewJobname,*) "R-TMM-AC-PBC-DIS-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".pbs"

   WRITE(OutJobname,*) "R-TMM-AC-PBC-DIS-w",trim(adjustl(StrRange)),&
       "-e",trim(adjustl(StrEne0)),&
       "-d",trim(adjustl(StrDis)),".out"

  OPEN(UNIT= ICh, ERR=10, FILE= NewJobname, STATUS= "REPLACE")

  WRITE(ICh,*,ERR=20) "#!/bin/bash"
  WRITE(ICh,*,ERR=20) "#PBS -l nodes=1:ppn=1,pvmem=500mb"
  WRITE(ICh,*,ERR=20) "#PBS -l walltime=",trim(adjustl(StrWalltime)),":00:00"
  WRITE(ICh,*,ERR=20) "#PBS -V"
  WRITE(ICh,*,ERR=20) "#PBS -m bea"
  WRITE(ICh,*,ERR=20) "#PBS -r y"
  WRITE(ICh,*,ERR=20) "#PBS -j oe"
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cd $PBS_O_WORKDIR"
  WRITE(ICh,*,ERR=20) "cd /gpfs/ccspam/RUNS/", trim(adjustl(Jobname))
  WRITE(ICh,*,ERR=20) 
  WRITE(ICh,*,ERR=20) "sleep 40"
  WRITE(ICh,*,ERR=20) "./tmseGR.PG  <tmseGR.inp>> ", trim(adjustl(OutJobname))
  WRITE(ICh,*,ERR=20)
  WRITE(ICh,*,ERR=20) "cp *.raw /gpfs/ccspam/Projects/GrapheneTMM/", trim(adjustl(Jobname))

  CLOSE(UNIT= ICh, ERR=30)

  CALL SYSTEM("qsub -r y " // trim(adjustl(NewJobname)))
  
  RETURN

10 PRINT*,"RestartRoutine(): ERR in OPEN()"
  IErr= 1
  RETURN
  
20 PRINT*,"RestartRoutine(): ERR in WRITE()"
  IErr= 1
  RETURN
  
30 PRINT*,"RestartRoutine(): ERR in CLOSE()"
  IErr= 1
  RETURN

END SUBROUTINE RestartRoutineACDISPBC


! --------------------------------------------------------------------
! SaveCurrentParameters: Save Parameters
!---------------------------------------------------------------------

SUBROUTINE SaveCurrentParameters( &
  IRange, flux, IErr)
  
  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IRange, IErr
  REAL(KIND=RKIND) flux

  CHARACTER*8 CName
  
  ! PRINT*,"DBG: ReOpenOutputAvg()"

  IErr= 0
  
  ! WRITE out the input parameter
  
  OPEN(UNIT= IChtmp, ERR= 10, STATUS= 'UNKNOWN',&
       FILE="tmseXd.tmp")

  WRITE(IChtmp,100,ERR=20) IRange, flux
100 FORMAT(I15.1,F18.9)

  CLOSE(UNIT= IChtmp, ERR=40)

  RETURN

  ! ERR in Open detected
10 PRINT*,"SaveCurrentParameters(): ERR in OPEN()"
  IErr= 1
  RETURN
  
  ! error in WRITE detected
20 PRINT*,"SaveCurrentParameters(): ERR in WRITE()"
  IErr= 1
  RETURN
  
  ! ERR in CLOSE
40 PRINT*,"SaveCurrentParameters(): ERR in CLOSE()"
  IErr= 1
  RETURN

END SUBROUTINE SaveCurrentParameters

! --------------------------------------------------------------------
! ReloadCurrentParameters:
!----------------------------------------------------------------------

SUBROUTINE ReloadCurrentParameters( &
  IRange, flux, IErr)
  
  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IRange, IErr
  REAL(KIND=RKIND) flux

  CHARACTER*8 CName
  
  ! PRINT*,"DBG: ReOpenOutputAvg()"

  IErr= 0
  
  ! WRITE out the input parameter
        
  OPEN(UNIT= IChtmp, ERR= 10, STATUS= 'OLD',&
       FILE="tmseXd.tmp")

  READ(IChtmp,100,ERR=20,END=30) IRange, flux
100 FORMAT(I15.1,F18.9)

  CLOSE(UNIT= IChtmp, ERR=40)

  RETURN

  ! ERR in Open detected
10 PRINT*,"ReloadCurrentParameters(): ERR in OPEN()"
  IErr= 1
  RETURN
  
  ! error in READ detected
20 PRINT*,"ReloadCurrentParameters(): ERR in READ()"
  IErr= 1
  RETURN
  
  ! EOF in READ occured prematurely
30 PRINT*,"ReloadCurrentParameters(): EOF in READ()"
  IErr= 1
  RETURN
  
  ! ERR in CLOSE
40 PRINT*,"ReloadCurrentParameters(): ERR in CLOSE()"
  IErr= 1
  RETURN

END SUBROUTINE ReloadCurrentParameters

! --------------------------------------------------------------------
! DeleteCurrentParameters:
!--------------------------------------------------------------------

SUBROUTINE DeleteCurrentParameters( &
  IRange, IErr)
  
  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IRange, IErr

  ! PRINT*,"DBG: ReOpenOutputAvg()"

  IErr= 0
  
  ! DELETE the parameter file
   
  OPEN(UNIT=IChtmp)
  CLOSE(UNIT=IChtmp,STATUS='DELETE',ERR=10)

  RETURN

  ! ERR in Delete detected
10 PRINT*,"DeleteCurrentParameters(): ERR in DELETE()"
  RETURN
  
END SUBROUTINE DeleteCurrentParameters


!***********************************************************
! Input/Output for RHO
!***********************************************************

!--------------------------------------------------------------------
!	WriteOutputAvgRHO:
!
!	IErr	error code
!--------------------------------------------------------------------

SUBROUTINE WriteOutputAvgRHO(  		&
     IChannelOut, IRange, IChannelMax,	&
     DiagDis, Energy,			&
     rhoMat, NOfL, NSamples,		&
     IErr )
  
   USE MyNumbers
   
   USE CConstants
   USE IConstants

   USE IPara
   USE DPara
	
   USE IChannels

   INTEGER IRange, IChannelOut, IChannelMax, NOfL, NSamples, IErr
   REAL(KIND=RKIND) DiagDis, Energy

   REAL(KIND=RKIND) rhoMat(IRange,0:IChannelMax) 

   INTEGER iState, jChannel, iL

! PRINT*,"DBG: WriteOutputAvgRHO()"

	IErr= 0

!	average Lyapunov exponent Gamma

   DO jChannel=0,IChannelMax
       DO iState= 1,IRange

		   WRITE(IChannelOut,410,ERR=10) &
                jChannel, iState, &
                DiagDis, Energy,	&
                rhoMat(iState,jChannel)/REAL(NSamples)

410	   FORMAT(" ", I7.1, " ", I7.1, &
                " ", F15.6, " ", F15.6, &
                " ", G25.16)
      ENDDO
   ENDDO

	RETURN

!	ERR in Write detected
10	PRINT*,"WriteOutputAvgRHO(): ERR in WRITE()"
	IErr= 1
	RETURN

END SUBROUTINE WriteOutputAvgRHO

!--------------------------------------------------------------------
!	WriteOutputAvgRHOX:
!
!	IErr	error code
!--------------------------------------------------------------------

SUBROUTINE WriteOutputAvgRHOX(  	&
     IChannelOut, IRange, IChannelMax,	&
     DiagDis, Energy,			&
     rhoMat, NOfL, NSamples,		&
     IErr )
  
  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IRange, IChannelOut, IChannelMax, NOfL, NSamples, IErr
  REAL(KIND=RKIND) DiagDis, Energy
  
  REAL(KIND=RKIND) rhoMat(0:IChannelMax,0:IChannelMax) 
  
  INTEGER iChannel, jChannel, iL
  
  ! PRINT*,"DBG: WriteOutputAvgRHO()"
  
  IErr= 0
  
  !	average Lyapunov exponent Gamma
  
  DO iChannel=0,IChannelMax
     DO jChannel= 0,IChannelMax
        
        WRITE(IChannelOut,410,ERR=10) &
             iChannel, jChannel, &
             DiagDis, Energy,	&
             rhoMat(iChannel,jChannel)/REAL(NSamples)
        
410     FORMAT(" ", I7.1, " ", I7.1, &
             " ", F15.6, " ", F15.6, &
             " ", G25.16)
     ENDDO
  ENDDO
  
  RETURN
  
  !	ERR in Write detected
10 PRINT*,"WriteOutputAvgRHOX(): ERR in WRITE()"
  IErr= 1
  RETURN
  
END SUBROUTINE WriteOutputAvgRHOX


!--------------------------------------------------------------------
!	OpenOutputRHO:
!
!	IErr	error code
!-------------------------------------------------------------------

SUBROUTINE OpenOutputRHO( IRange, &
           DiagDis, Energy,  &
           IErr )

  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IRange, IErr
  REAL(KIND=RKIND) DiagDis, Energy
  
  INTEGER ICh
  
  CHARACTER*28 CNameP
  CHARACTER*29 CNameM
  
  ! PRINT*,"DBG: OpenOutputRHO()"
  
  IErr= 0
  ICh = IChOutRHO
  
  !	the filename is different for this RHO logging
  
  IF( Energy.GE.-1.0D-10 ) THEN
     
     WRITE(CNameP, 100) &
          IRange,".",	&
          NINT(100.0D0*ABS(DiagDis)),".", &
          NINT(100.0D0*ABS(Energy)),".rho"
100  FORMAT(I4.4,A1,I4.4,A1,I4.4,A4)
     
     OPEN(UNIT= ICh, ERR= 10, STATUS= 'UNKNOWN', &
          FILE=CNameP)
  ELSE
     
     WRITE(CNameM, 200) &
          IRange,".",	&
          NINT(100.0D0*ABS(DiagDis)),".-", &
          NINT(100.0D0*ABS(Energy)),".rho"
200  FORMAT(I4.4,A1,I4.4,A2,I4.4,A4) 
     
     OPEN(UNIT= ICh, ERR= 10, STATUS= 'UNKNOWN', &
          FILE=CNameM)
  ENDIF
  
  RETURN
  
  !	error in OPEN detected
10 PRINT*,"OpenOutputRHO(): ERR in OPEN()"
  IErr= 1
  RETURN
  
END SUBROUTINE OpenOutputRHO


!--------------------------------------------------------------------
!	WriteOutputRHO:
!
!	IErr	error code
!-------------------------------------------------------------------

SUBROUTINE WriteOutputRHO(  &
     IChannelOut, IRange, IChannelMax,	&
     DiagDis, Energy,	&
     rhoMat, NOfL, NSamples,	&
     IErr )
  
  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IRange, IChannelOut, IChannelMax, NOfL, NSamples, IErr
  REAL(KIND=RKIND) DiagDis, Energy
  
  REAL(KIND=RKIND) rhoMat(IRange,0:IChannelMax) 
  
  INTEGER iState, jChannel, iL
  
  ! PRINT*,"DBG: WriteOutputRHO()"
  
  IErr= 0
  
  !	average Lyapunov exponent Gamma
  
  DO jChannel=0,IChannelMax
     DO iState= 1,IRange
        
        WRITE(IChannelOut,410,ERR=10) &
             NSamples,jChannel, iState, &
             DiagDis, Energy,	&
             rhoMat(iState,jChannel)/REAL(NSamples)
        
410     FORMAT(" ", I7.1, " ", I7.1, " ", I7.1, &
             " ", F15.6, " ", F15.6, &
             " ", G25.16)
     ENDDO
  ENDDO
  
  RETURN
  
  !	ERR in Write detected
10 PRINT*,"WriteOutputAvgRHO(): ERR in WRITE()"
  IErr= 1
  RETURN
  
END SUBROUTINE WriteOutputRHO


!--------------------------------------------------------------------
!	CloseOutputRHO:
!
!	IErr	error code
!------------------------------------------------------------------

SUBROUTINE CloseOutputRHO( IErr )
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IErr
  
  INTEGER ICh
  
  !	PRINT*,"DBG: CloseOutputRHO()"
  
  IErr= 0
  ICh = IChOutRHO
  
  CLOSE(UNIT= ICh, ERR= 10)
  
  RETURN
  
  !	ERR in CLOSE detected
10 PRINT*,"CloseOutputRHO(): ERR in CLOSE()"
  IErr= 1
  RETURN
  
END SUBROUTINE CloseOutputRHO

! --------------------------------------------------------------------
! WriteOutputHAV:
!
! IErr	error code
!---------------------------------------------------------------------

SUBROUTINE WriteOutputHAV(&
     IRange, 	&
     DiagDis, 	&
     Energy,	&
     gam, NOfL,  &
     sumhavg,	&
     IErr )
  
  USE MyNumbers
  
  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara
  
  USE IChannels
  
  INTEGER IRange, NOfL, IErr
  REAL(KIND=RKIND) DiagDis, Energy
  REAL(KIND=RKIND) gam(NOfL), sumhavg

  REAL(KIND=RKIND) sumgam
  
  INTEGER iState, jSite, iL
  
  ! PRINT*,"DBG: WriteOutputHAV()"
  
  IErr= 0
  
  ! sum of Lyapunov exponents

  sumgam  = 0.0D0
  DO iL= 1,NOfL
     sumgam   = sumgam + gam(iL)
  ENDDO

  WRITE(IChOutHAV,410,ERR=10) &
     NOfL, &
     DiagDis, &
     Energy, &
     sumgam, sumhavg
     
410 FORMAT(I7.1, &
         ", ", F15.6, &
         ", ", F15.6, &
         ", ", F25.16, ", ", F25.16, ", ", F25.16)
  
  RETURN
           
  !	ERR in Write detected
10 PRINT*,"WriteOutputHAV(): ERR in WRITE()"
  IErr= 1
  RETURN
         
END SUBROUTINE WriteOutputHAV

!--------------------------------------------------------------------
!	OutputEVals:
!
!	IErr	error code
!-------------------------------------------------------------------

SUBROUTINE OutputEVals( ILayer, IRange, IElements, Disorder,Energy, EVals, Csur, IErr )
  
  USE MyNumbers
  
  !USE CConstants
  !USE IConstants
  
  USE IPara
  !USE DPara
  
  USE IChannels
  
  INTEGER ILayer, IRange, IElements, iState, IErr
  REAL(KIND=RKIND) Disorder, Energy
  CHARACTER*4 Csur
  COMPLEX(KIND=CKIND) EVals(IRange)
  !EXTERNAL ARG

  CHARACTER*38 CNameP
  CHARACTER*39 CNameM
  CHARACTER*1 Cpre
  
  !PRINT*,"DBG: OutputEVals()"
  
  IErr= 0
  
  ! WRITE out the input parameter

  !IF(IStripeFlag.LT.0) THEN
  !   WRITE(Cpre, '(A1)') "m"
  !ELSE
     WRITE(Cpre, '(A1)') "-"
  !ENDIF
   
  IF( Energy.GE.-1.0D-10 ) THEN
     
     WRITE(CNameP, '(I4.4,A1,I6.6,A1,I6.6,A1,I6.6,A1,I5.5,A4)') &
          IRange,".", &
          ISeed, ".", &
          NINT(10000.0D0*ABS(Disorder)),".",		&
          NINT(10000.0D0*ABS(Energy)),".",ILayer/(NOfPrint*NOfOrtho),Csur
     
     !PRINT*,CNameP

     OPEN(UNIT= IChOutPsi, ERR= 10, STATUS= 'UNKNOWN', &
          FILE=CNameP)
  ELSE
     
     WRITE(CNameM, '(I4.4,A1,I6.6,A1,I6.6,A2,I6.6,A1,I5.5,A4) ') &
          IRange,".", &
          ISeed, ".", &
          NINT(10000.0D0*ABS(Disorder)),".-",		 &
          NINT(10000.0D0*ABS(Energy)),".",ILayer/(NOfPrint*NOfOrtho),Csur
     
     !PRINT*,CNameM

     OPEN(UNIT= IChOutPsi, ERR= 10, STATUS= 'UNKNOWN', &
          FILE=CNameM)
  ENDIF

  DO iState= 1, IElements
     
     WRITE(IChOutPsi,550,ERR=30) iState,&
          DBLE(EVals(iState)), AIMAG(EVals(iState)), &
          !-ATAN(AIMAG(EVals(iState))/DBLE(EVals(iState)))
          ARG(AIMAG(EVals(iState)),DBLE(EVals(iState)))
550  FORMAT( I4.1, " ", 3(G25.15) )
  ENDDO
     
  CLOSE(UNIT=IChOutPsi,ERR=40)
     
  RETURN
     
  !	error in OPEN detected
10 PRINT*,"OutputEVals(): ERR in OPEN()"
  IErr= 1
  RETURN
  
  !	error in WRITE detected
20 PRINT*,"OutputEVals(): ERR in WRITE()"
  IErr= 1
  RETURN

  !	ERR in Write detected
30 PRINT*,"OutputEVals(): ERR in WRITE()"
  IErr= 1
  RETURN

  ! ERR in CLOSE detected
40 PRINT*,"OutputEVals(): ERR in CLOSE()"
  IErr= 1
  RETURN

END SUBROUTINE OutputEVals

! --------------------------------------------------------------------
! WriteDataC
!-------------------------------------------------------------------

SUBROUTINE WriteDataC( &
     prefix, surname, data, size, step, IErr)

  USE MyNumbers

  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara

  USE IChannels

  CHARACTER*40 surname
  CHARACTER*6 prefix,postfix
  INTEGER(KIND=IKIND) size, step, IErr
  COMPLEX(KIND=CKIND) data(size)

  CHARACTER*50 filename
  INTEGER index

  !PRINT*,"WriteDataC()"

  WRITE(filename,'(A6,A40,A4)') prefix,surname,".raw"

  IF(IWriteFlag.EQ.MAXWriteFlag) PRINT*,"WriteDataC() for ", filename

  IErr=0

  OPEN(UNIT= IChOutWrite, ERR= 10, STATUS= 'UNKNOWN',&
          FILE=filename)

  DO index=1,size,step
     !PRINT*,"DBG: index=", index
	 IF (ABS(data(index)).GE. TINY) THEN
     WRITE(IChOutWrite,100) DBLE(data(index)),AIMAG(data(index)), &
          !-ATAN(AIMAG(EVals(iState))/DBLE(EVals(iState)))
          !ARG(AIMAG(data(index)),DBLE(data(index)))
          ARG(DBLE(data(index)),AIMAG(data(index)))
	 ELSE
     WRITE(IChOutWrite,100) DBLE(data(index)),AIMAG(data(index)), &
          !-ATAN(AIMAG(EVals(iState))/DBLE(EVals(iState)))
          0.0D0
	 ENDIF
	 
100  FORMAT(3(G25.15))
  ENDDO
     
  CLOSE(IChoutWrite,ERR=30)
  
  RETURN

! error in OPEN detected
10 PRINT*,"WriteDataC(): ERR in OPEN()"
  PRINT*, "file ", filename, " does not exist --- REOPEN not possible!"
  IErr= 1
  RETURN
  
  ! error in WRITE detected
20 PRINT*,"WriteDataC(): ERR in WRITE() for file=", filename
  IErr= 1
  RETURN

  ! ERR in CLOSE detected
30 PRINT*,"WriteDataC(): ERR in CLOSE() for file=", filename
  IErr= 1
  RETURN

END SUBROUTINE WriteDataC

! --------------------------------------------------------------------
! WriteDataR
!--------------------------------------------------------------------

SUBROUTINE WriteDataR( &
     prefix, surname, data, size, step, IErr)

  USE MyNumbers

  USE CConstants
  USE IConstants
  
  USE IPara
  USE DPara

  USE IChannels

  CHARACTER*40 surname
  CHARACTER*6 prefix,postfix
  INTEGER(KIND=IKIND) size, step, IErr
  REAL(KIND=RKIND) data(size)

  CHARACTER*50 filename
  INTEGER index

  !PRINT*,"WriteDataR()"

  WRITE(filename,'(A6,A40,A4)') prefix,surname,".raw"

  IF(IWriteFlag.EQ.MAXWriteFlag) PRINT*,"WriteDataR() for ", filename

  IErr=0

  OPEN(UNIT= IChOutWrite, ERR= 10, STATUS= 'UNKNOWN',&
          FILE=filename)!, POSITION='APPEND')

  DO index=1,size,step
     !PRINT*,"DBG: index=", index
     WRITE(IChOutWrite,100) data(index)
100  FORMAT(G25.15)
  ENDDO
     
  CLOSE(IChoutWrite,ERR=30)
  
  RETURN

! error in OPEN detected
10 PRINT*,"WriteDataR(): ERR in OPEN()"
  PRINT*, "file ", filename, " does not exist --- REOPEN not possible!"
  IErr= 1
  RETURN
  
  ! error in WRITE detected
20 PRINT*,"WriteDataR(): ERR in WRITE() for file=", filename
  IErr= 1
  RETURN

  ! ERR in CLOSE detected
30 PRINT*,"WriteDataR(): ERR in CLOSE() for file=", filename
  IErr= 1
  RETURN

END SUBROUTINE WriteDataR