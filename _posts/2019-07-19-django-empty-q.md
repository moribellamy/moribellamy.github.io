---
layout: post
title: Empty Q() objects in Django
tags: post django python
---
As Django developers know, the ORM uses python `**kwargs` to specify filtering criterion. From [their own documentation](https://docs.djangoproject.com/en/2.2/topics/db/queries/#complex-lookups-with-q-objects), we have the example:

```python
from django.db.models import Q
Q(question__startswith='What')
Q(question__startswith='Who') | Q(question__startswith='What')
```

So, for example, these would be passed to an ORM method so it knows which SQL to generate:

```python
results = Poll.objects.get(
    Q(question__startswith='Who'),
    Q(pub_date=date(2005, 5, 2)) | Q(pub_date=date(2005, 5, 6))
)
```

## Weird Behavior

That's fine and good. There's interesting semantics, though, if you omit kwargs from the `Q()` constructor (which is perfectly valid python). For example:

```python
In [1]: Address.objects.all().count()
Out[1]: 39789

In [2]: Address.objects.filter(Q()).count()
Out[2]: 39789

In [3]: Address.objects.filter(Q() | Q(city='boston')).count()
Out[3]: 28
```

In entry (2), we can see an empty Q() appears to be a noop. *But hold up*. Example 3 uses the vertical bar operator, which in the whole universe of programming has traditionally meant "or", "union", or "disjunction". And it's actually [no different in Django](https://docs.djangoproject.com/en/2.2/topics/db/queries/#complex-lookups-with-q-objects).

And last time I checked, *the union operator is not supposed to make a set smaller.*

## So what?

Well, it's certainly surprising. But it's been that way for a long time, definitely too long to change without wreaking havoc on developers. [At least one person was confused before](https://code.djangoproject.com/ticket/24279).

My personal theory is that this behavior evolved organically with the following (anti?) pattern:

```python
# OK, time to dynamically make my queryset criteria...
query = Q()
for thing in things:
    query = query | Q(my_field__iexact=thing)

# Sweet, I'll match anything in `things`.
```

I've almost fallen into that pattern myself, and I've seen it in other codebases. Squinting, most programmers would find this at least superficially reasonable. Start with an empty-ish thing (`Q()`) and programatically add criteria.

In fact, the current implementation works as the above example intends. But I consider it pretty risky. It doesn't jive with typical set theory, and some of us are kind of used to thinking in those terms. What made me feel better is:

```python
query = Q(my_field__iexact=things[0])
for thing in things[1:]:
    query = query | Q(my_field__iexact=thing)
```

A clever use of [reduce](https://docs.python.org/2/library/functions.html#reduce) would also do the trick, but for my money the more mathematical higher level functions are becoming less pythonic (for better or for worse).
