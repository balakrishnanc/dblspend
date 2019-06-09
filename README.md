# About

Analysis of the “double spend” attack on Bitcoin.


## Usage

```
§ ./dblspend.rkt -h
dblspend.rkt [ <option> ... ]
 where <option> is one of
  -v, --verbose : Enable verbose mode
  -q <q>, --attacker-power <q> : Probability of an attacker mining a block
  -z <z>, --conf-depth <z> : Number of blocks after which a transaction is marked as `safe`
  --help, -h : Show this help
  -- : Do not treat any remaining argument as a switch (at this level)
 Multiple single-letter switches can be combined after one `-'; for
  example: `-h-' is the same as `-h --'
```

## Example

```
§ ./dblspend.rkt -v
#> q: 0.1, z: 6
0.000032754422
c
```