# 3-Digit Prime Numbers Starting With 5

**Question:**
> Write the algorithm flow with pseudo-code or any software language which displays all prime numbers having 3 digits and starting with 5.

---

## Algorithm (Pseudo-code)

```
ALGORITHM FindPrimesStartingWith5

BEGIN
    FOR number FROM 500 TO 599 DO
        IF isPrime(number) THEN
            PRINT number
        END IF
    END FOR
END

FUNCTION isPrime(n)
BEGIN
    IF n < 2 THEN RETURN FALSE
    IF n == 2 THEN RETURN TRUE
    IF n IS EVEN THEN RETURN FALSE

    FOR divisor FROM 3 TO sqrt(n) STEP 2 DO
        IF n MOD divisor == 0 THEN
            RETURN FALSE
        END IF
    END FOR

    RETURN TRUE
END FUNCTION
```

---

## Python Implementation

```python
def is_prime(n):
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
    return [n for n in range(500, 600) if is_prime(n)]

if __name__ == "__main__":
    primes = three_digit_primes_starting_with_five()
    print(f"Count: {len(primes)}")
    for p in primes:
        print(p)
```

Run: `python primes.py`

---

## Output

```
Count: 14
503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599
```

---

## Files

| File | Description |
|------|-------------|
| `pseudocode.txt` | Algorithm in pseudo-code |
| `primes.py` | Python implementation |
| `primes.c` | C implementation |
