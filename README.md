# Philosophers-tester

## Usage

- At the same level as the "philo" directory
```
git clone https://github.com/ryhara/Philosophers-tester.git
```
```
Philosophers repository
.
├── Philosophers-tester
│   ├── README.md
│   ├── main.sh
│   └── test.sh
└── philo
    ├── Makefile
    ├── *.h
    └── *.c
```

```
cd Philosophers-tester
```
```
chmod +x test.sh main.sh
```

## Test
- simple test
```
./test.sh <num> <num> <num> <num> [ <num> ]
```

- all test
```
./main.sh
```

- die test
```
./main.sh d
```
- not die test
```
./main.sh n
```

- stop test
```
./main.sh s
```

- error case
```
 Error cases are not supported.
 Check it out for yourself.
```

**⚠️　Note**

If you press ctrl+C during the test, there may be a program running in the background.

Please check with ps and kill.

## Review
- The actual review will involve multiple tests with 5 or fewer people.
- Any tests will be conducted with no more than 200 people.

## Help
If you have any questions or test cases, please comment on the issue or discussion.

I will respond in Japanese or English.

- [Issues](https://github.com/ryhara/Philosophers-tester/issues)
- [Discussion](https://github.com/ryhara/Philosophers-tester/discussions)


## Reference
https://github.com/MichelleJiam/LazyPhilosophersTester
