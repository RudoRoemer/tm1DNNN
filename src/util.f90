! ********************************************************************
!       
! TM1DNNN - Transfer matrix method for the Anderson model
! in 1D with finite-range hopping
!
! ********************************************************************
       
! ********************************************************************
!     
! $Header: /home/cvs/phsht/GrapheneTMM/src/Restart/ALL/utilC.f90,v 1.1 2011/07/22 17:49:19 ccspam Exp $
!
! ********************************************************************

!--------------------------------------------------------------------
! TMMultNNN:
!
! Multiplication of the transfer matrix onto the vector (PSI_A,PSI_B), 
! giving (PSI_B,PSI_A) so that the structure of the transfer matrix 
! can be exploited
!-----------------------------------------------------------------------

SUBROUTINE TMMultNNN(PSI_A,PSI_B, Ilayer, &
     HopMatiLR, HopMatiL, EMat, dummyMat, OnsitePotVec, &
     En, Dis, M )

  USE MyNumbers
  USE IPara
  USE RNG
  USE DPara
  
  ! wave functions:
  !       
  ! (PSI_A, PSI_B) on input, (PSI_B,PSI_A) on output
  
  IMPLICIT NONE
  
  INTEGER Ilayer,           &! current # TM multiplications
       M                     ! strip width
  
  REAL(KIND=RKIND)  Dis,    &! diagonal disorder
       En                    ! energy
  
  REAL(KIND=RKIND) PSI_A(M,M), PSI_B(M,M)
  REAL(KIND=RKIND) HopMatiLR(M,M),HopMatiL(M,M), EMat(M,M),dummyMat(M,M)
  REAL(KIND=RKIND) OnsitePotVec(M)
  
  INTEGER iSite, jState
  REAL(KIND=RKIND) OnsitePot
  REAL(KIND=RKIND) new, PsiLeft, PsiRight

  !PRINT*,"TMMultNNN()"

  ! create the new onsite matrix 
  DO iSite=1,M
     SELECT CASE(IRNGFlag)
     CASE(-1)
        EMat(iSite,iSite)= REAL(M-iSite+1,RKIND)
     CASE(0)
        EMat(iSite,iSite)= En - Dis*(DRANDOM()-0.5D0)
     CASE(1)
        EMat(iSite,iSite)= En - Dis*(DRANDOM()-0.5D0)*SQRT(12.0D0)
     !CASE(2)
        !EMat(iSite,iSite)= En - GRANDOM(ISeedDummy,0.0D0,Dis)
     END SELECT
  ENDDO ! iSite
  !PRINT*,"EMat=", EMat

!!$  dummyMat= MATMUL(HopMatiL,EMat)
!!$  PRINT*,"HopMatiLE=", dummyMat; PAUSE
  CALL DGEMM('N','N',M,M,M,1.0D0,HopMatiL,M,EMat,M,0.0D0,dummyMat,M)
!!$  PRINT*,"HopMatiLE=", dummyMat; PAUSE

  dummyMat= MATMUL(dummyMat,PSI_A)

!!$  PSI_B= dummyMat + MATMUL(HopMatiLR,PSI_B)
!!$  PRINT*,"PsiB=", PSI_B; PAUSE
  CALL DGEMM('N','N',M,M,M,1.0D0,HopMatiLR,M,PSI_B,M,1.0D0,dummyMat,M)
  PSI_B= dummyMat
!!$  PRINT*,"PsiB=", PSI_B; PAUSE

  !PRINT*,"PSIA(1,1),(2,1),(3,1),(4,1)",&
   !    PSI_A(1,1),PSI_A(2,1),PSI_A(3,1),PSI_A(4,1)
  !PRINT*,"PSIB(1,1),(2,1),(3,1),(4,1)",&
   !    PSI_B(1,1),PSI_B(2,1),PSI_B(3,1),PSI_B(4,1)
  
  RETURN
END SUBROUTINE TMMultNNN

!------------------------------------------------------------------------
!	ReNorm:
!
!	Gram-Schmidt orthonormalization of the wave vectors (PSI_A,PSI_B),
!	see e.g. Horn/Johnson, "Matrix Analysis", pp. 15. 
!
!	PLUS reading off the Lyapunov exponents
!
!	(PSI_A,PSI_B) is the incoming vector of eigenvectors,
!	GAMMA, GAMMA2 are Lyapunov exponent and its square,
!	M is the width of the strip,
!
!	IVec/JVec label different vectors, 
!	KIndex is the component index of a SINGLE vector,
!
!	dummy, sum and norm are just different names for the same
!	double precision workspace
!-------------------------------------------------------------------------

SUBROUTINE ReNorm(PSI_A,PSI_B,GAMMA,GAMMA2,M,NORTHO)
  
  USE MyNumbers
  USE IConstants
  USE IPara
  
  INTEGER M,NORTHO
  
  REAL(KIND=RKIND) PSI_A(M,M), PSI_B(M,M)
  REAL(KIND=RKIND) GAMMA(M), GAMMA2(M)
  
  INTEGER IVec,JVec,KIndex
  
  REAL(KIND=RKIND) sum
  REAL(KIND=RKIND) dummy,norm, normbefore,quot
  !EQUIVALENCE (dummy,norm)

  REAL*8 MinAccuracy,MaxAccuracy
  PARAMETER (MinAccuracy= 1D-11, MaxAccuracy= 1D-8)

  !make the local variables static
  !SAVE
  
  !PRINT*,"DBG: ReNorm()"

!!$  norm= REAL(0.D0,RKIND)
!!$  DO 50 KIndex=1,M                      
!!$     norm= norm + CONJG(PSI_A(IVec,KIndex)) * PSI_A(IVec,KIndex) &
!!$          + CONJG(PSI_B(IVec,KIndex)) * PSI_B(IVec,KIndex)
!!$50 ENDDO
!!$  normbefore= norm
!!$  

  DO 100 IVec=1,M
     
     DO 200 JVec=1,IVec-1
        
        sum= CZERO
        
        DO 300 KIndex=1,M
           
!!$           sum= sum + CONJG(PSI_A(JVec,KIndex))*PSI_A(IVec,KIndex) &
!!$                + CONJG(PSI_B(JVec,KIndex))*PSI_B(IVec,KIndex)
           sum= sum + (PSI_A(JVec,KIndex))*PSI_A(IVec,KIndex) &
                + (PSI_B(JVec,KIndex))*PSI_B(IVec,KIndex)
300     ENDDO
        
        DO 400 KIndex=1,M
           
           PSI_A(IVec,KIndex)= PSI_A(IVec,KIndex) - &
                sum * PSI_A(JVec,KIndex)
           PSI_B(IVec,KIndex)= PSI_B(IVec,KIndex) - &
                sum * PSI_B(JVec,KIndex)
           
400     ENDDO
        
200  ENDDO
     
     ! calculation of norm
     norm= REAL(0.D0,RKIND)
     DO 500 KIndex=1,M                      
!!$        norm= norm + CONJG(PSI_A(IVec,KIndex)) * PSI_A(IVec,KIndex) &
!!$             + CONJG(PSI_B(IVec,KIndex)) * PSI_B(IVec,KIndex)
        norm= norm + (PSI_A(IVec,KIndex)) * PSI_A(IVec,KIndex) &
             + (PSI_B(IVec,KIndex)) * PSI_B(IVec,KIndex)
500  ENDDO
     ! renormalization
     dummy= 1.D0/SQRT(norm)
     DO 600 KIndex=1,M
!!$        PSI_A(IVec,KIndex)= CMPLX(dummy,0.0D0,CKIND) * PSI_A(IVec,KIndex)
!!$        PSI_B(IVec,KIndex)= CMPLX(dummy,0.0D0,CKIND) * PSI_B(IVec,KIndex)
        PSI_A(IVec,KIndex)= dummy * PSI_A(IVec,KIndex)
        PSI_B(IVec,KIndex)= dummy * PSI_B(IVec,KIndex)
600  ENDDO
     
     !	----------------------------------------------------------------
     !	gammadummy is ordered s.t. the vector with the smallest overall 
     !	norm is last and the vector with the largest overall norm first. 
     !	We sum this so that the smallest value is used for GAMMA(M)
     !	and the largest for GAMMA(1). Same for GAMMA2(). Therefore, the
     !	inverse of the smallest Lyapunov exponent is obtained by taking
     !	LAMBDA(1) = N/GAMMA(M)
     dummy       = LOG(dummy)
     GAMMA(IVec) = GAMMA(IVec) - dummy
     GAMMA2(IVec)= GAMMA2(IVec) + dummy*dummy

     ! ----------------------------------------------------------------
     ! check orthogonality if desired
     GOTO 100
     IF(IWriteFlag.GE.MAXWriteFlag) THEN

        DO JVec=1,IVec-1
           sum= REAL(0.D0,RKIND)
           DO KIndex=1,M
!!$              sum= sum + CONJG(PSI_A(JVec,KIndex))*PSI_A(IVec,KIndex) &
!!$                   + CONJG(PSI_B(JVec,KIndex))*PSI_B(IVec,KIndex)
              sum= sum + (PSI_A(JVec,KIndex))*PSI_A(IVec,KIndex) &
                   + (PSI_B(JVec,KIndex))*PSI_B(IVec,KIndex)
           ENDDO
           PRINT*,"Renorm: <",JVec,"|",IVec,">=",sum
        ENDDO
        
     ENDIF
     
100 ENDDO
  
!!$  ! determine whether NOrtho needs to be changed
!!$  IF (IWriteFLAG.GE.5) THEN
!!$     
!!$     quot = SQRT(norm/normbefore)
!!$     !PRINT*, "ReNorm(): NORTHO=", NORTHO, ", quot=", quot, norm, normbefore
!!$     
!!$     IF (quot.LT.MinAccuracy) THEN
!!$        !       decrease NORTHO if accuracy is ba
!!$        PRINT*, "ReNorm(): WRNG, normbefore, norm, quot=", normbefore,norm,quot
!!$        PRINT*, "ReNorm(): WRNG, NORTHO=", NORTHO, " should be decreased!"
!!$     ELSEIF (quot.GT.MaxAccuracy) THEN
!!$        !       increase NORTHO if accuracy is good
!!$        PRINT*, "ReNorm(): normbefore, norm, quot=", normbefore,norm,quot
!!$        PRINT*, "ReNorm(): NORTHO=", NORTHO, " could be increased!"
!!$     ENDIF
!!$     
!!$  ENDIF
  
  RETURN
  
END SUBROUTINE ReNorm

! --------------------------------------------------------------------
!       ReOrtho:
!
! DO NOT USE, DOES MOST LIKELY NOT WORK!
!
!       Gram-Schmidt orthonormalization of the wave vectors (PSI_A,PSI_B),
!       see e.g. Horn/Johnson, "Matrix Analysis", pp. 15.
!
!       PLUS reading off the Luapunov exponents
!
!       (PSI_A,PSI_B) is the incoming vector of eigenvectors,
!       GAMMA, GAMMA2 are Luapunov exponent and its square,
!       M is the width of the strip,
!
!       IVec/JVec label different vectors, 
!       KIndex is the component index of a SINGLE vector,
!
!       dummy, sum and norm are just different names for the same
!       double precision workspace

SUBROUTINE ReNormBLAS(PSI_A,PSI_B,GAMMA,GAMMA2,MX,MY,NOrtho)

  INTEGER MX,MY,NOrtho
  
  REAL*8 PSI_A(MX*MY,MX*MY), PSI_B(MX*MY,MX*MY)
  REAL*8 GAMMA(MX*MY), GAMMA2(MX*MY)
  
  INTEGER IVec,JVec,KIndex, MXY
  
  REAL*8 dummy,sum,norm,normbefore,quot
  EQUIVALENCE (dummy,sum)
  
  REAL*8 MinAccuracy,MaxAccuracy
  PARAMETER (MinAccuracy= 1D-11, MaxAccuracy= 1D-8)
  
  !     BLAS routines
  
  REAL*8 ddot
  EXTERNAL ddot

  !       make the local variables static
  SAVE

  !PRINT*, "ReNormBLAS(): NOrtho=", NOrtho
  !D     PRINT*,"DBG: ReOrtho()"
  !D     PRINT*,"DBG: MinAccuracy=", MinAccuracy,
  !D    +          ", MaxAccuray=", MaxAccuracy
  
  MXY       = MX*MY
  
  normbefore= &
       ddot(MXY, PSI_A(1,MXY),1, PSI_A(1,MXY),1) + &
       ddot(MXY, PSI_B(1,MXY),1, PSI_B(1,MXY),1)
  
  DO IVec=1,MXY
     DO JVec=1,IVec-1
        
        sum= -( &
             ddot(MXY, PSI_A(1,JVec),1, PSI_A(1,IVec),1) + &
             ddot(MXY, PSI_B(1,JVec),1, PSI_B(1,IVec),1) &
             )
        
        call daxpy(MXY, sum, PSI_A(1,JVec),1, PSI_A(1,IVec),1)
        call daxpy(MXY, sum, PSI_B(1,JVec),1, PSI_B(1,IVec),1)
        
     ENDDO
     
     !          calculation of norm
     norm= ddot(MXY, PSI_A(1,IVec),1, PSI_A(1,IVec),1) + &
          ddot(MXY, PSI_B(1,IVec),1, PSI_B(1,IVec),1)
     
     dummy= 1.D0/SQRT(norm)
     
     call dscal(MXY, dummy, PSI_A(1,IVec), 1)
     call dscal(MXY, dummy, PSI_B(1,IVec), 1)
     
     !          ----------------------------------------------------------------
     !          gammadummy is ordered s.t. the vector with the smallest overall 
     !          norm is last and the vector with the largest overall norm first. 
     !          We sum this so that the smallest value is used for GAMMA(M)
     !          and the largest for GAMMA(1). Same for GAMMA2(). Therefore, the
     !          inverse of the smallest Lyapunov exponent is obtained by taking
     !          LAMBDA(1) = N/GAMMA(M)
     !           PRINT *,"DBG: dummy,LOG(dummy)", dummy,LOG(dummy)
     
     dummy       = LOG(dummy)
     
     GAMMA(IVec) = GAMMA(IVec) - dummy
     GAMMA2(IVec)= GAMMA2(IVec) + dummy*dummy
     
  ENDDO
  
  !       determine whether NOrtho needs to be changed
  
  quot = SQRT(norm/normbefore)
  PRINT*, "ReNormBLAS(): NOrtho=", NOrtho, ", quot=", quot, norm, normbefore

  !       decrease NOrtho if accuracy is bad
  IF (quot.LT.MinAccuracy) THEN
     NOrtho = NOrtho-2
     PRINT*, "ReNormBLAS(): NOrtho=", NOrtho
     IF (NOrtho.LT.1) THEN
        NOrtho = 1
     ENDIF
  ENDIF
  
  !       increase NOrtho if accuracy is good
  IF (quot.GT.MaxAccuracy) THEN
     NOrtho = NOrtho+2
     PRINT*, "ReNormBLAS(): NOrtho=", NOrtho
  ENDIF
  
  RETURN
END SUBROUTINE ReNormBLAS

!---------------------------------------------------------------------
!	Swap:
!
!	(PSI_A,PSI_B)= (old,new) is the incoming vector, this is swapped
!	into (PSI_A,PSI_B)= (new,old)
!-------------------------------------------------------------------

SUBROUTINE Swap( PSI_A, PSI_B, M)

  USE MyNumbers
  
  INTEGER M
  REAL(KIND=RKIND) PSI_A(M,M), PSI_B(M,M)
  
  INTEGER jState, index
  REAL(KIND=RKIND) dummy
  
  !	PRINT*,"DBG: Swap()"
  
  DO jState=1,M
     DO index=1,M
        
        dummy              = PSI_B(index,jState)
        PSI_B(index,jState)= PSI_A(index,jState)
        PSI_A(index,jState)= dummy
        
     ENDDO
  ENDDO
  
  RETURN
  
END SUBROUTINE Swap


!--------------------------------------------------------------------
!	ReSort:
!
!	sort the Lyapunov eigenvalues s.t. the largest comes first. RESORT()
!	is ShellSort taken from NumRec, SHELL().
!---------------------------------------------------------------------

SUBROUTINE ReSort( PSI_A, PSI_B, array0, array1, N )

  USE MyNumbers
  
  INTEGER N
  REAL(KIND=RKIND) PSI_A(N,N),PSI_B(N,N)
  REAL(KIND=RKIND) array0(N), array1(N)
  
  REAL(KIND=RKIND) ALN2I, LocalTINY
  PARAMETER (ALN2I=1.4426950D0, LocalTINY=1.D-5)
  
  INTEGER NN,M,L,K,J,I,LOGNB2, index
  REAL(KIND=RKIND) dummyA, dummyB
  
  !	PRINT*,"DBG: ReSort()"
  
  !	PRINT*,"array0(1),array0(N)",array0(1),array0(N)
  
  LOGNB2=INT(LOG(REAL(N))*ALN2I+LocalTINY)
  M=N
  DO 12 NN=1,LOGNB2
     M=M/2
     K=N-M
     DO 11 J=1,K
        I=J
3       CONTINUE
        L=I+M
        IF(array0(L).GT.array0(I)) THEN
           
           dummyA   = array0(I)
           array0(I)= array0(L)
           array0(L)= dummyA
           
           dummyB   = array1(I)
           array1(I)= array1(L)
           array1(L)= dummyB
           
           DO 100 index=1,N
              dummyA        = PSI_A(index,I)
              dummyB        = PSI_B(index,I)
              
              PSI_A(index,I)= PSI_A(index,L)
              PSI_B(index,I)= PSI_B(index,L)
              
              PSI_A(index,L)= dummyA
              PSI_B(index,L)= dummyB
100        ENDDO
        
           I=I-M
           IF(I.GE.1) GOTO 3
        ENDIF
11   ENDDO
12 ENDDO
  
  !	PRINT*,"array0(1),array0(N)",array0(1),array0(N)
  RETURN

END SUBROUTINE ReSort

! --------------------------------------------------------------------
SUBROUTINE CheckUnitarity(Umat,Wmat,M,IErr)

  USE MyNumbers
  USE IPara
  USE IConstants
  USE DPara

  IMPLICIT NONE

  INTEGER(KIND=IKIND) M, IErr, index,jndex
  COMPLEX(KIND=CKIND) Umat(M,M), Wmat(M,M)
  REAL(KIND=RKIND) sum

  IErr=0

  !PRINT*,"Umat=", Umat

  Wmat=CONJG(TRANSPOSE(Umat))
  !Wmat=CONJG(Wmat)
  Wmat=MATMUL(Umat,Wmat)

  sum= 0.0D0
  DO index=1,M
     DO jndex=1,M
        sum= sum+ABS(Wmat(index,jndex))
     ENDDO
  ENDDO
  sum= (sum-REAL(M,RKIND))/REAL(M*M,RKIND)

  !PRINT*,"Wmat=", Wmat
  IF(IWriteFlag.GE.MAXWriteFlag) THEN
     PRINT*,"CheckUnit: sum=",sum!; PAUSE
  ENDIF

  !IF(ABS(sum).GE.EPSILON(0.0D0)) IErr=1
  IF(ABS(sum).GE.TINY) THEN
     PRINT*,"CheckUnit: sum=",sum," > TINY=",TINY," !"
     IErr=1
  ENDIF

  ! check symmetrization if no magnetic field
  IF(MagFlux.LT.TINY) THEN
     Wmat=TRANSPOSE(Umat)
     
     sum= 0.0D0
     DO index=1,M
        DO jndex=1,M
           sum= sum+ABS(Umat(index,jndex)-Wmat(index,jndex))
        ENDDO
     ENDDO
     sum= (sum)/REAL(M*M,RKIND)
     
     !PRINT*,"Wmat=", Wmat
     IF(IWriteFlag.GE.MAXWriteFlag) THEN
        PRINT*,"CheckSym: sum=",sum!; PAUSE
     ENDIF
  ENDIF

  RETURN

END SUBROUTINE CheckUnitarity
