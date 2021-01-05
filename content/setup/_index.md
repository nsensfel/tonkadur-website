---
menuTitle: "Setup"
title: "Setting Up Tonkadur"
weight: 1
---
There are two parts to set up: the compiler, and the interpreter. The compiler
is provided and does not require any modification. The interpreter depends on
the software you wish to integrate Tonkadur to. Examples of interpreters are
available, but expect some modifications to be required. This should not prove
to be difficult however, as the whole approach is design with the idea of
keeping the interpreter small and simple.

## Setting Up the Compiler

### Installation
**Dependencies:**
* Java

Download the latest release of Tonkadur on [this
page](https://github.com/nsensfel/tonkadur/releases).

### Use
The Tonkadur compiler is invoked using `java -jar tonkadur.jar [option] <file>`.
`java -jar tonkadur.jar` will yield the complete list of valid options.

`<file>` corresponds to a Fate file. By default, the generated Wyrd file will
have the same name with a suffix.

## Setting Up the Interpreter
It is recommended to look up existing interpreters. Not only might you be able
to just use an existing one, but having examples of interpreters will help you
create your own if you can't find one that fits your needs.

**Known open source Wyrd interpreters:**
* [nsensfel/tonkadur-python-interpreter](https://github.com/nsensfel/tonkadur-python-interpreter): A minimal Python3 interpreter, with JSON input.

### Creating Your Own Interpreter
If you end up needing to create your own interpreter, here are some clues on how
to proceed.

A Wyrd interpreter keeps track of:
* **The Memory:** typically a mapping of strings to values. These values may be
of any Wyrd type.
* **The Program Counter:** an integer corresponding to the next Wyrd instruction
to execute.
* **Available Choices:** A list of `TEXT`.
* **Last Chosen Choice:** Index of the last chosen choice.
* **The Code:** A list of instructions.

Additionally, the following can be kept track of:
* **Types:** The default value for each type, making it easier to create new
  memory elements of a given type.
* **Allocated Data Counter:** The number of dynamically allocated memory
  elements, making it easy to generate unique names for new memory elements.

A few pitfalls:
* **Copy values on assignment:** `(set_value a b)` does not make `a` become `b`,
  but rather assigns a copy of the current value of `b` to `a`.
* **Addresses may be already computed:** An `address` computation can take an
   address as its `address` parameter. In other words, while in most cases an
   `address` computation is a string that must be put in a list to become an
   actual address, it can also sometimes already be a list and must then stay
   unchanged.
* **Beware of references:** When performing a computation that accesses memory
  elements, be sure not to actually be returning the memory element itself after
  it has been modified, but rather a modified copy of the memory element. This
  is only problematic for memory elements whose type is modified by reference in
  the interpreter's programming language. An example would be relative address
  computation, which appends an element to a list. Computing a relative address
  must not modify the base address, it only returns a list equivalent to the
  base address but with an extra element.

A set of tests can found on [this
page](https://github.com/nsensfel/tonkadur/tree/master/data/tests), and will let
you test your interpreter more easily. They have to be compiled to Wyrd first,
however.
