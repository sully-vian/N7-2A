#include "aux.h"
#include "omp.h"
#include <stdio.h>
#include <stdlib.h>

double f(double x) { return 1.0 / (1 + x * x); }

int main(int argc, char **argv) {
    long t_start, t_end;
    int n, i, cnt;
    unsigned int seed = 1, npoints, it;
    double x, y;

    if (argc == 2) {
        npoints = atoi(argv[1]);
    } else {
        printf("Usage:\n\n ./main npoints\n\nwhere npoints is the number of "
               "random points.\n");
        return 1;
    }

    cnt = 0;
    t_start = usecs();
    // start parallel region
#pragma omp parallel
    {
        seed = omp_get_thread_num();
        // parallel for loop
        // - private seed: rnd_double cannot be called by different threads with
        // same arg
        // private x, y: different at each iteration
        // reduction(+ : cnt): sum cnt from all threads (each one calculates a
        // part of cnt)
#pragma omp for private(seed, x, y) reduction(+ : cnt)
        for (it = 0; it < npoints; it++) {
            x = rnd_doub(&seed);
            y = rnd_doub(&seed);
            if (y <= f(x))
                cnt++;
        }
    }

    t_end = usecs();
    printf("Integral is %f\n", ((double)cnt) / ((double)npoints) * 4.0);
    printf("Execution time : %8.2f msec.\n",
           ((double)t_end - t_start) / 1000.0);
}
