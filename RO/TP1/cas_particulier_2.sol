Problem:    cas_particulier_2
Rows:       45
Columns:    42 (42 integer, 36 binary)
Non-zeros:  174
Status:     INTEGER OPTIMAL
Objective:  CoutTotal = 22 (MINimum)

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
     7 RespectDepartUnique[ALPHA]
                                   1             1             = 
     8 RespectDepartUnique[C1]
                                   1             1             = 
     9 RespectDepartUnique[C2]
                                   1             1             = 
    10 RespectDepartUnique[C3]
                                   1             1             = 
    11 RespectDepartUnique[C4]
                                   1             1             = 
    12 RespectDepartUnique[C5]
                                   1             1             = 
    13 RespectArriveeUnique2[ALPHA]
                                   1             1             = 
    14 RespectArriveeUnique2[C1]
                                   1             1             = 
    15 RespectArriveeUnique2[C2]
                                   1             1             = 
    16 RespectArriveeUnique2[C3]
                                   1             1             = 
    17 RespectArriveeUnique2[C4]
                                   1             1             = 
    18 RespectArriveeUnique2[C5]
                                   1             1             = 
    19 DepartAlpha                 1             1             = 
    20 RangClients[C1]
                                   6             2               
    21 RangClients[C2]
                                   2             2               
    22 RangClients[C3]
                                   3             2               
    23 RangClients[C4]
                                   5             2               
    24 RangClients[C5]
                                   4             2               
    25 pasDeboucle[C1,C2]
                                   4                           5 
    26 pasDeboucle[C1,C3]
                                   3                           5 
    27 pasDeboucle[C1,C4]
                                   1                           5 
    28 pasDeboucle[C1,C5]
                                   2                           5 
    29 pasDeboucle[C2,C1]
                                  -4                           5 
    30 pasDeboucle[C2,C3]
                                   5                           5 
    31 pasDeboucle[C2,C4]
                                  -3                           5 
    32 pasDeboucle[C2,C5]
                                  -2                           5 
    33 pasDeboucle[C3,C1]
                                  -3                           5 
    34 pasDeboucle[C3,C2]
                                   1                           5 
    35 pasDeboucle[C3,C4]
                                  -2                           5 
    36 pasDeboucle[C3,C5]
                                   5                           5 
    37 pasDeboucle[C4,C1]
                                   5                           5 
    38 pasDeboucle[C4,C2]
                                   3                           5 
    39 pasDeboucle[C4,C3]
                                   2                           5 
    40 pasDeboucle[C4,C5]
                                   1                           5 
    41 pasDeboucle[C5,C1]
                                  -2                           5 
    42 pasDeboucle[C5,C2]
                                   2                           5 
    43 pasDeboucle[C5,C3]
                                   1                           5 
    44 pasDeboucle[C5,C4]
                                   5                           5 
    45 CoutTotal                  22                             

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
                    *              0             0             1 
    19 trajets[C2,C3]
                    *              1             0             1 
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
                    *              1             0             1 
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
                    *              1             0             1 
    37 rang[ALPHA]  *              1             1             6 
    38 rang[C1]     *              6             1             6 
    39 rang[C2]     *              2             1             6 
    40 rang[C3]     *              3             1             6 
    41 rang[C4]     *              5             1             6 
    42 rang[C5]     *              4             1             6 

Integer feasibility conditions:

KKT.PE: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.PB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

End of output
