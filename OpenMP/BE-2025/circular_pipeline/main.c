#include "aux.h"
#include "omp.h"

int main(int argc, char **argv) {
    long t_start, t_end;
    int i, s, I, S;
    Token token;

    if (argc == 3) {
        I = atoi(argv[1]); /* number of iterations */
        S = atoi(argv[2]); /* number of stages */
    } else {
        printf("Usage:\n\n ./main I S\n\nsuch that I is the number of "
               "iterations and S the number of stages.\n");
        return 1;
    }

    init(&token, I, S);

    omp_lock_t *locks;
    locks = (omp_lock_t *)malloc(S * sizeof(omp_lock_t));
    for (s = 0; s < S; s++) {
        omp_init_lock(&locks[s]);
    }

    for (i = 0; i < I; i++) {
        printf("Iteration %2d\n", i);
        // block everybody (if needed) except thread 0
        for (s = 1; s < S; s++) {
            omp_test_lock(&locks[s]);
        }
#pragma omp parallel for num_threads(S) schedule(static, 1)

        for (s = 0; s < S; s++) {
            // wait for its own lock to release
            omp_set_lock(&locks[s]);
            process(&token, s);
            // release next lock
            omp_unset_lock(&locks[(s + 1) % S]);
        }
    }

    check(&token, I, S);

    return 0;
}
