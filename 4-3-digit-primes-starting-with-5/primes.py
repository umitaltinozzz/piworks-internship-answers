def is_prime(n):
    """Return True if n is a prime number."""
    if n < 2:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    i = 3
    while i * i <= n:
        if n % i == 0:
            return False
        i += 2
    return True


def three_digit_primes_starting_with_five():
    """Return all 3-digit prime numbers whose first digit is 5 (i.e. 500-599)."""
    return [n for n in range(500, 600) if is_prime(n)]


if __name__ == "__main__":
    primes = three_digit_primes_starting_with_five()
    print(f"Count: {len(primes)}")
    print("Primes:")
    for p in primes:
        print(p)
