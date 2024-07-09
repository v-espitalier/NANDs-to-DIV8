
# NANDs to DIV8

POC that NAND gates achieve [functional completeness](https://en.wikipedia.org/wiki/Functional_completeness) and can be used to build any complex binary function. In this example, a circuit that computes an 8-bit integer division is built from 1720 NAND gates.

## Installation

You need to install **ghdl** to compile and simulate your circuits, and **gtkwave** to view the evolution of the signals over time.

On Ubuntu, you only need to install the appropriate packages:

```
sudo apt-get install ghdl gtkwave
```

## Compile & Run

```
bash compile.sh
```

This will compile the vhdl sources and run bench tests (like regression tests).
You can then visualize the results with gtkwave. For example:

```
gtkwave div8_tb.vcd
```


## Example

![exemple.png](exemple.png)

In this example, a = 51 (0x33) is divided by b = 4. The calculation finishes after 72 ns (352 ns in the worst case), and the resulting quotient is q = 12 (0x0C), with a remainder of r = 3.
