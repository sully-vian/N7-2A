Problem:    affectation
Rows:       7
Columns:    9 (9 integer, 9 binary)
Non-zeros:  27
Status:     INTEGER OPTIMAL
Objective:  BonheurTotal = 19 (MAXimum)

   No.   Row name        Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 RespecteUniteTache[P1]
                                   1             1             = 
     2 RespecteUniteTache[P2]
                                   1             1             = 
     3 RespecteUniteTache[P3]
                                   1             1             = 
     4 RespecteUnitePersonne[T1]
                                   1             1             = 
     5 RespecteUnitePersonne[T2]
                                   1             1             = 
     6 RespecteUnitePersonne[T3]
                                   1             1             = 
     7 BonheurTotal               19                             

   No. Column name       Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 A[P1,T1]     *              0             0             1 
     2 A[P1,T2]     *              0             0             1 
     3 A[P1,T3]     *              1             0             1 
     4 A[P2,T1]     *              1             0             1 
     5 A[P2,T2]     *              0             0             1 
     6 A[P2,T3]     *              0             0             1 
     7 A[P3,T1]     *              0             0             1 
     8 A[P3,T2]     *              1             0             1 
     9 A[P3,T3]     *              0             0             1 

Integer feasibility conditions:

KKT.PE: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.PB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

End of output
