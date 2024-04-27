# Passman - v0.1

## About

A really simple parameterized password generator. Creates a random sequence of letters, numbers and special characters and lets you copy them.

![Screenshot 2024-04-27 132817](https://github.com/HooptyDaDoop/F_PassMan/assets/165091445/5c70b7cf-fe93-4ada-8268-5fb8a3ac149b)

---

## Parameters

### Split on fourth:
Instead of picking characters at random, it picks 3 letters, and then on the 4th character either adds a special character (such as "!@#$%") or a number 0-9 (inclusive)

### Toggle uppercase:
50% chance for every encountered lower case letter (lower case by default) to flip to upper case

### Enclose with character & Surround character:
if a surround character is given in the text field, and the "enclose with character" option is toggled on, whatever the generated password is, it'll insert the surround character at the beginning and the end of the generated password.

(eg. if surround char is "*" 123_abcd ---becomes---> \*123_abcd\* 
