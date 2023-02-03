# Things I hate about Java

### Checking Optional equality

Optionals are a wonderful feature, but using them results in extremely
verbose code even for Java standards. The most outrageous representation of
this is when you try to check if the contents of an optional match a known
literal:

```java
Optional<String> word = getSomeWord();
if (word.equals(Optional.of("Hello, World!"))) {
  // ...
}
```

Because `.equals` checks for it being also an Optional you're required to
convert your known literal into an Optional using `Optional.of(...)`. This
not only adds verbosity to your code but also increases complexity and
decreases performance. The `equals` method should be smart enought to be
able to do something like this:

```java
Optional<String> word = getSomeWord();
if (word.equals("Hello, World!")) {
  // ...
}
```

### Generics

```java
var map = new HashMap<String, ?>();
map.put("num", 33);
```

### Stupid ? extends Something

```
Long num = 69L;
List<? extends Object> list = new LinkedList<>();
list.add(num); // add(? extends Object) is not applicable for the arguments add(Long)
```

### Immutable Collections

Why Java, just Why?

I want a strongly typed language to catch as many errors as I can during
compilation

Interfaces are contracts, why do you claim to have a certain interface just
to throw UnsupportedMethodException on runtime? That's cheating

### String comparissons

<https://stackoverflow.com/a/767379>

Why do I need to use .equals to check for string equality and not ==?

```java
if ("hello" == String.format("%s", "hello")) {
  System.out.println("Hello, world!");
} else {
  System.out.println("Goodbye, world!");
}
```
