## Code examples

With some Python code (in @lst:mypython)

``` {#lst:mypython .python .numberLines caption="Some Python"}
def foo():
    return 1;
```

With some Ruby code

``` {#myruby .ruby .numberLines}
def foo
    1
end
```

and Some C code:


``` {#myc .c .numberLines}
int
foo() {
    return 1;
}
```

Aaah, and some `C++`:

``` {#mycpp .cpp .numberLines}
template <typename T>
std::tuple<T, T> mymodule::hassome::foo()
{
    return std::make_tuple<T, T>(1, 1);
} // I don't even know whether this works
```

And, of course, because pandoc:

~~~~ {#mycode .haskell .numberLines startFrom="100"}
qsort []     = []
qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++
               qsort (filter (>= x) xs)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

