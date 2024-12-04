Problem:    ModelAlpha
Rows:       19
Columns:    36 (36 integer, 36 binary)
Non-zeros:  108
Status:     INTEGER OPTIMAL
Objective:  CoutTotal = 6 (MINimum)

   No.   Row name        Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 RespectDiag[ALPHA]
                                   0            -0             = 
     2 RespectDiag[C1]
                                   0            -0             = 
     3 RespectDiag[C2]
                                   0            -0             = 
     4 RespectDiag[C3]
                                   0            -0             = 
     5 RespectDiag[C4]
                                   0            -0             = 
     6 RespectDiag[C5]
                                   0            -0             = 
     7 RespectPassageUnique[ALPHA]
                                   1             1             = 
     8 RespectPassageUnique[C1]
                                   1             1             = 
     9 RespectPassageUnique[C2]
                                   1             1             = 
    10 RespectPassageUnique[C3]
                                   1             1             = 
    11 RespectPassageUnique[C4]
                                   1             1             = 
    12 RespectPassageUnique[C5]
                                   1             1             = 
    13 RespectPassageUnique2[ALPHA]
                                   1             1             = 
    14 RespectPassageUnique2[C1]
                                   1             1             = 
    15 RespectPassageUnique2[C2]
                                   1             1             = 
    16 RespectPassageUnique2[C3]
                                   1             1             = 
    17 RespectPassageUnique2[C4]
                                   1             1             = 
    18 RespectPassageUnique2[C5]
                                   1             1             = 
    19 CoutTotal                   6                             

   No. Column name       Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 trajets[ALPHA,ALPHA]
                    *              0             0             1 
     2 trajets[C1,C1]
                    *              0             0             1 
     3 trajets[C2,C2]
                    *              0             0             1 
     4 trajets[C3,C3]
                    *              0             0             1 
     5 trajets[C4,C4]
                    *              0             0             1 
     6 trajets[C5,C5]
                    *              0             0             1 
     7 trajets[ALPHA,C1]
                    *              0             0             1 
     8 trajets[ALPHA,C2]
                    *              1             0             1 
     9 trajets[ALPHA,C3]
                    *              0             0             1 
    10 trajets[ALPHA,C4]
                    *              0             0             1 
    11 trajets[ALPHA,C5]
                    *              0             0             1 
    12 trajets[C1,ALPHA]
                    *              1             0             1 
    13 trajets[C1,C2]
                    *              0             0             1 
    14 trajets[C1,C3]
                    *              0             0             1 
    15 trajets[C1,C4]
                    *              0             0             1 
    16 trajets[C1,C5]
                    *              0             0             1 
    17 trajets[C2,ALPHA]
                    *              0             0             1 
    18 trajets[C2,C1]
                    *              1             0             1 
    19 trajets[C2,C3]
                    *              0             0             1 
    20 trajets[C2,C4]
                    *              0             0             1 
    21 trajets[C2,C5]
                    *              0             0             1 
    22 trajets[C3,ALPHA]
                    *              0             0             1 
    23 trajets[C3,C1]
                    *              0             0             1 
    24 trajets[C3,C2]
                    *              0             0             1 
    25 trajets[C3,C4]
                    *              0             0             1 
    26 trajets[C3,C5]
                    *              1             0             1 
    27 trajets[C4,ALPHA]
                    *              0             0             1 
    28 trajets[C4,C1]
                    *              0             0             1 
    29 trajets[C4,C2]
                    *              0             0             1 
    30 trajets[C4,C3]
                    *              1             0             1 
    31 trajets[C4,C5]
                    *              0             0             1 
    32 trajets[C5,ALPHA]
                    *              0             0             1 
    33 trajets[C5,C1]
                    *              0             0             1 
    34 trajets[C5,C2]
                    *              0             0             1 
    35 trajets[C5,C3]
                    *              0             0             1 
    36 trajets[C5,C4]
                    *              1             0             1 

Integer feasibility conditions:

KKT.PE: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.PB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

End of output
