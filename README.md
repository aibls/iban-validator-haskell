# iban-validator-haskell
IBAN Validator in Haskell
-------------------------

# Haskell IBAN Validator

This is a small Haskell project implementing IBAN validation.

It checks:
- country code
- total IBAN length
- block validity (1–4 chars, uppercase or digits)
- resolves letters A=10..Z=35
- performs optional mod 97 check

Course: Functional Programming (ELTE)
Language: Haskell

