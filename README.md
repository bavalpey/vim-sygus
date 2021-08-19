# Sygus sytax for vim

requires https://github.com/bohlender/vim-smt2

Add's keywords `constraint`, `check-synth`, and `synth-fun`.
Detects `.sy` files as sygus.

### Commands
If you have cvc4 or cvc5 installed in your path, the following commands are available
* `<localleader>r` evaluates the current file
* `<localleader>R` evaluates the current file, putting the output in a new split with syntax highlighting
* `<localleader>v` prints the solver's version
