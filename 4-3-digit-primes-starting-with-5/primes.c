#include <stdio.h>
#include <stdbool.h>

static bool is_prime(int n) {
    if (n < 2)        return false;
    if (n == 2)       return true;
    if (n % 2 == 0)   return false;

    for (int i = 3; i * i <= n; i += 2) {
        if (n % i == 0) {
            return false;
        }
    }
    return true;
}

int main(void) {
    int count = 0;
    int primes[100];

    for (int n = 500; n <= 599; ++n) {
        if (is_prime(n)) {
            primes[count++] = n;
        }
    }

    printf("Count: %d\n", count);
    printf("Primes:\n");
    for (int i = 0; i < count; ++i) {
        printf("%d\n", primes[i]);
    }
    return 0;
}
