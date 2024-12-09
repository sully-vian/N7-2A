Problem:    cas_particulier_2
Rows:       50
Columns:    42 (36 integer, 36 binary)
Non-zeros:  204
Status:     INTEGER EMPTY
Objective:  CoutTotal = 0 (MINimum)

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
                                   0             1             = 
     8 RespectPassageUnique[C1]
                                   0             1             = 
     9 RespectPassageUnique[C2]
                                   0             1             = 
    10 RespectPassageUnique[C3]
                                   0             1             = 
    11 RespectPassageUnique[C4]
                                   0             1             = 
    12 RespectPassageUnique[C5]
                                   0             1             = 
    13 RespectPassageUnique2[ALPHA]
                                   0             1             = 
    14 RespectPassageUnique2[C1]
                                   0             1             = 
    15 RespectPassageUnique2[C2]
                                   0             1             = 
    16 RespectPassageUnique2[C3]
                                   0             1             = 
    17 RespectPassageUnique2[C4]
                                   0             1             = 
    18 RespectPassageUnique2[C5]
                                   0             1             = 
    19 DepartAlpha                 0             1             = 
    20 pasDeboucle[ALPHA,C1]
                                   0                           5 
    21 pasDeboucle[ALPHA,C2]
                                   0                           5 
    22 pasDeboucle[ALPHA,C3]
                                   0                           5 
    23 pasDeboucle[ALPHA,C4]
                                   0                           5 
    24 pasDeboucle[ALPHA,C5]
                                   0                           5 
    25 pasDeboucle[C1,ALPHA]
                                   0                           5 
    26 pasDeboucle[C1,C2]
                                   0                           5 
    27 pasDeboucle[C1,C3]
                                   0                           5 
    28 pasDeboucle[C1,C4]
                                   0                           5 
    29 pasDeboucle[C1,C5]
                                   0                           5 
    30 pasDeboucle[C2,ALPHA]
                                   0                           5 
    31 pasDeboucle[C2,C1]
                                   0                           5 
    32 pasDeboucle[C2,C3]
                                   0                           5 
    33 pasDeboucle[C2,C4]
                                   0                           5 
    34 pasDeboucle[C2,C5]
                                   0                           5 
    35 pasDeboucle[C3,ALPHA]
                                   0                           5 
    36 pasDeboucle[C3,C1]
                                   0                           5 
    37 pasDeboucle[C3,C2]
                                   0                           5 
    38 pasDeboucle[C3,C4]
                                   0                           5 
    39 pasDeboucle[C3,C5]
                                   0                           5 
    40 pasDeboucle[C4,ALPHA]
                                   0                           5 
    41 pasDeboucle[C4,C1]
                                   0                           5 
    42 pasDeboucle[C4,C2]
                                   0                           5 
    43 pasDeboucle[C4,C3]
                                   0                           5 
    44 pasDeboucle[C4,C5]
                                   0                           5 
    45 pasDeboucle[C5,ALPHA]
                                   0                           5 
    46 pasDeboucle[C5,C1]
                                   0                           5 
    47 pasDeboucle[C5,C2]
                                   0                           5 
    48 pasDeboucle[C5,C3]
                                   0                           5 
    49 pasDeboucle[C5,C4]
                                   0                           5 
    50 CoutTotal                   0                             

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
                    *              0             0             1 
     9 trajets[ALPHA,C3]
                    *              0             0             1 
    10 trajets[ALPHA,C4]
                    *              0             0             1 
    11 trajets[ALPHA,C5]
                    *              0             0             1 
    12 trajets[C1,ALPHA]
                    *              0             0             1 
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
                    *              0             0             1 
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
                    *              0             0             1 
    27 trajets[C4,ALPHA]
                    *              0             0             1 
    28 trajets[C4,C1]
                    *              0             0             1 
    29 trajets[C4,C2]
                    *              0             0             1 
    30 trajets[C4,C3]
                    *              0             0             1 
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
                    *              0             0             1 
    37 rang[C1]                    0             1             6 
    38 rang[ALPHA]                 0             1             6 
    39 rang[C2]                    0             1             6 
    40 rang[C3]                    0             1             6 
    41 rang[C4]                    0             1             6 
    42 rang[C5]                    0             1             6 

Integer feasibility conditions:

KKT.PE: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.PB: max.abs.err = 1.00e+00 on row 7
        max.rel.err = 5.00e-01 on row 7
        SOLUTION IS INFEASIBLE

End of output
