#include "aux.h"
#include "omp.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>

void barber_shop_seq(int nbarbs, int nchairs);
void barber_shop_par_fixed(int nbarbs, int nchairs);
void barber_shop_par_any(int nbarbs, int nchairs);

int main(int argc, char **argv) {
    long nbarbs, nchairs, nclients;
    long t_start, t_end;
    float *xs, *xsd;
    double *xd, *xdd;

    // Command line arguments
    if (argc == 4) {
        nbarbs = atoi(argv[1]);   /* number of barbers */
        nchairs = atoi(argv[2]);  /* number of chairs */
        nclients = atoi(argv[3]); /* number of clients */
        if (nbarbs <= nchairs) {
            printf("Please set nbarbs > nchairs.\n");
            return 1;
        }
    } else {
        printf("Usage:\n\n ./main nbarbs nchairs nclients\n where nbarbs is "
               "the number of barbers, nchairs the number of chairs and "
               "nclients the number of clients.\n");
        return 1;
    }

    init_data(nbarbs, nchairs, nclients);

    printf("\n\n========= Sequential "
           "==================================================\n");
    t_start = usecs();
    barber_shop_seq(nbarbs, nchairs);
    t_end = usecs();
    printf("Execution   time oop : %8.2f msec.\n",
           ((double)t_end - t_start) / 1000.0);

    check_and_cleanup();

    printf("\n\n========= Parallel with assigned chair "
           "================================\n");

    t_start = usecs();
    barber_shop_par_fixed(nbarbs, nchairs);
    t_end = usecs();
    printf("Execution   time  ip : %8.2f msec.\n",
           ((double)t_end - t_start) / 1000.0);

    check_and_cleanup();

    printf("\n\n========== Parallel with any chair "
           "====================================\n");

    t_start = usecs();
    barber_shop_par_any(nbarbs, nchairs);
    t_end = usecs();
    printf("Execution   time  ip : %8.2f msec.\n",
           ((double)t_end - t_start) / 1000.0);

    check_and_cleanup();

    return 0;
}

void barber_shop_seq(int nbarbs, int nchairs) {

    int barber, client, chair;

    barber = 0;

    for (;;) {

        client = receive_client();

        /* No more clients to serve */
        if (client < 0) {
            break;
        }

        chair = barber % nchairs;

        serve_client(barber, client, chair);
    }
}

void barber_shop_par_fixed(int nbarbs, int nchairs) {

    int barber, client, chair;

    // create locks for each chair
    omp_lock_t *chair_locks;
    chair_locks = (omp_lock_t *)malloc(nchairs * sizeof(omp_lock_t));
    for (chair = 0; chair < nchairs; chair++) {
        omp_init_lock(&chair_locks[chair]);
    }

#pragma omp parallel num_threads(nbarbs) private(barber, client, chair)
    {
        // barber different for each thread
        barber = omp_get_thread_num();
        for (;;) {

            // critical because
#pragma omp critical
            {
                client = receive_client();
            }

            /* No more clients to serve */
            if (client < 0) {
                break;
            }

            // select chair to wait for
            chair = barber % nchairs;

            // suspend until lock is available
            omp_set_lock(&chair_locks[chair]);
            serve_client(barber, client, chair);
            omp_unset_lock(&chair_locks[chair]);
        }
    }

    for (chair = 0; chair < nchairs; chair++) {
        omp_destroy_lock(&chair_locks[chair]);
    }
}

void barber_shop_par_any(int nbarbs, int nchairs) {

    int barber, client, chair;

    // create locks for each chair
    omp_lock_t *chair_locks;
    chair_locks = (omp_lock_t *)malloc(nchairs * sizeof(omp_lock_t));
    for (chair = 0; chair < nchairs; chair++) {
        omp_init_lock(&chair_locks[chair]);
    }

#pragma omp parallel num_threads(nbarbs) private(barber, client, chair)
    {
        barber = omp_get_thread_num();

        for (;;) {
#pragma omp critical
            {
                client = receive_client();
            }
            /* No more clients to serve */
            if (client < 0) {
                break;
            }

            // set chair to the first available
            chair = barber % nchairs;

            // loop until available chair is found
            while (!omp_test_lock(&chair_locks[chair])) {
                chair = (chair + 1) % nchairs;
            }
            serve_client(barber, client, chair);
            omp_unset_lock(&chair_locks[chair]);
        }
    }

    for (chair = 0; chair < nchairs; chair++) {
        omp_destroy_lock(&chair_locks[chair]);
    }
}
