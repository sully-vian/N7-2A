Problem:    cas_particulier_1_2
Rows:       11
Columns:    12
Non-zeros:  36
Status:     OPTIMAL
Objective:  CoutTotal = 1305.5 (MINimum)

   No.   Row name   St   Activity     Lower bound   Upper bound    Marginal
------ ------------ -- ------------- ------------- ------------- -------------
     1 RespectA[D1,F1]
                    NS             2             2             =             2 
     2 RespectA[D1,F2]
                    B              0            -0             = 
     3 RespectA[D2,F1]
                    NS             1             1             =             2 
     4 RespectA[D2,F2]
                    NS             3             3             =             3 
     5 RespectB[M1,F1]
                    NU           2.5                         2.5            -1 
     6 RespectB[M1,F2]
                    NU             1                           1            -2 
     7 RespectB[M2,F1]
                    B            0.5                           1 
     8 RespectB[M2,F2]
                    B              1                           2 
     9 RespectB[M3,F1]
                    B              0                           2 
    10 RespectB[M3,F2]
                    NU             1                           1            -1 
    11 CoutTotal    B            9.5                             

   No. Column name  St   Activity     Lower bound   Upper bound    Marginal
------ ------------ -- ------------- ------------- ------------- -------------
     1 vol[F1,M1,D1]
                    B              2             0               
     2 vol[F1,M2,D1]
                    NL             0             0                       < eps
     3 vol[F1,M3,D1]
                    NL             0             0                           1 
     4 vol[F2,M1,D1]
                    NL             0             0                           3 
     5 vol[F2,M2,D1]
                    NL             0             0                           3 
     6 vol[F2,M3,D1]
                    NL             0             0                           3 
     7 vol[F1,M1,D2]
                    B            0.5             0               
     8 vol[F1,M2,D2]
                    B            0.5             0               
     9 vol[F1,M3,D2]
                    NL             0             0                           1 
    10 vol[F2,M1,D2]
                    B              1             0               
    11 vol[F2,M2,D2]
                    B              1             0               
    12 vol[F2,M3,D2]
                    B              1             0               

Karush-Kuhn-Tucker optimality conditions:

KKT.PE: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.PB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.DE: max.abs.err = 0.00e+00 on column 0
        max.rel.err = 0.00e+00 on column 0
        High quality

KKT.DB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

End of output
