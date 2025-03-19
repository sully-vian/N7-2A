#include "common.h"
#include "trace.h"

/* This is a sequential routine for the LU factorization of a square
   matrix in block-columns */
void chol_par_tasks(matrix_t A) {
    int i, j, k, prio;

    #pragma omp parallel private(i, j, k, prio) // create a global parallel region
    {
        # pragma omp single
        {
            for (k = 0; k < A.NB; k++) {
                // reduce the diagonal block
                #pragma omp task depend(inout : A.blocks[k][k]) priority(4)
                // inout: A.blocks[k][k] is read and written during the task

                potrf(A.blocks[k][k]);

                for (i = k + 1; i < A.NB; i++) {
                    // prioritize the tasks of the critical path
                    prio = i == k+1 ? 4 : 2;
                    // compute the A[i][k] sub-diagonal block
                    #pragma omp task depend(in : A.blocks[k][k]) depend(inout : A.blocks[i][k]) priority(prio)
                    // in: A.blocks[k][k] is read during the task
                    // inout: A.blocks[i][k] is read and written during the task
                    // the task depends on the completion of the previous task
                    trsm(A.blocks[k][k], A.blocks[i][k]);

                    for (j = k + 1; j <= i; j++) {
                        // update the A[i][j] block in the trailing submatrix
                        #pragma omp task depend(in : A.blocks[i][k], A.blocks[j][k]) depend(inout : A.blocks[i][j])
                        // in: A.blocks[i][k] and A.blocks[j][k] are read during the task
                        // task inout: A.blocks[i][j] is read and written during the task
                        gemm(A.blocks[i][k], A.blocks[j][k], A.blocks[i][j]);
                    }
                }
            }
        }
    }
    return;
}
