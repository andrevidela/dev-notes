

# Using Unicode where you shouldn't

In a codebase, it might be that you want to use $\mu$ as an Identifier. Your first option is
to use `Mu` with a capital letter in order to make it a _constructor_. But if you want your
syntax to mimic your mathematical notation, you might tempted to use an alias for `Mu` which
is called `mu`.

However, if, in the same namespace you can mix up capital letters with unicode and use `M\mu`
