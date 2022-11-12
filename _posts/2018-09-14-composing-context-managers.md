---
layout: post
title: Composing Context Managers in Python
tags: post python
---

Let's say you have a custom [context manager](https://www.python.org/dev/peps/pep-0343/).
Without loss of generality, consider:

```python
class MyGreeter(object):

    def __init__(self, name):
        self.name = name

    def __enter__(self):
        print(self.name, 'saying hello.')
        return len(self.name)

    def __exit__(self, exc_type, exc_val, exc_tb):
        print(self.name, 'saying goodbye.')
        return False


with MyGreeter('Mori') as thing:
    print(thing)

# Output:
# Mori saying hello.
# 4
# Mori saying goodbye.
```

This is fine, but you might want to extend the functionality and depend on
another context manager. Let’s say, in the above example, we wanted to print
the message to a temporary file instead of to the console. Typical usage of
`NamedTemporaryFile` would look like this:

```python
import tempfile

with tempfile.NamedTemporaryFile() as f:
    f.write('...')
```

But now we’re in trouble. We’d like f to be accessible in the `__enter__` and
`__exit__` methods. But we can’t have a reusable class defined inside of a
`with` construct.

So the question is, how do we compose these two context managers while still
being mindful of failure semantics?

## Solution 1: Invoke context manager methods directly

Something like this would work:

```python
import tempfile

class MyGreeter(object):

    def __init__(self, name):
        self.name = name
        self.tempfile_manager = tempfile.NamedTemporaryFile(
            mode='w', encoding='utf-8')

    def __enter__(self):
        self.tempfile = self.tempfile_manager.__enter__()
        self.tempfile.write('{} saying hello'.format(self.name))
        return self.tempfile  # or whatever

    def __exit__(self, exc_type, exc_val, exc_tb):
        try:
            self.tempfile.write('{} saying goodbye'.format(self.name))
        finally:
            return self.tempfile_manager.__exit__(exc_type, exc_val, exc_tb)
            
with MyGreeter('Bob') as thing:
    pass
```

Recall that, according to the [specification](https://www.python.org/dev/peps/pep-0343/)
 for ContextManagers, the three parameters to `__exit__` identify a currently
handled exception. If no exception is currently being handled, all three values
are None. Furthermore, `__exit__` returns True if a currently handled exception
should be re-thrown, or False if it should be swallowed.

This enables ContextManagers to ease cognitive load of their users – if certain
exceptions are recoverable, the author can do the recovery logic inside the CM
itself.

Our simple Greeter has no special semantics for exception handling, so we defer
to our inner CM tempfile_manager. If an exception is currently being handled,
maybe `NamedTemporaryFile` will want to do something special with it.

Beware though: When composing CMs like this, you could in theory swallow
exceptions that someone up the stack expected to see for their API to recover
properly. So if you catch any of these exceptions, you should probably
re-`raise`.

## Solution 2: Use the `contextlib` decorator

If you have no exception handling semantics, you can use something much more
concise.

```python
import contextlib
import tempfile

@contextlib.contextmanager
def my_greeter(name):
    with tempfile.NamedTemporaryFile(mode='w', encoding='utf-8') as temp:
        temp.write('{} saying hello\n'.format(name))
        try:
            yield name
        finally:
            temp.write('{} saying goodbye\n'.format(name))
```

The cool thing is, since generators pass exceptions through to the consumer,
NamedTemporaryFile gets to see the exceptions it was counting on seeing.
