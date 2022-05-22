# Trying to implement a repository pattern

JPA is an amazing tool for Java developers that allow them to integrate with
databases very quickly. But with great power comes great responsability: there
are two main problems that have to be addresed.

The first one is the repository: JPA contains a very powerful interface called
`JPARepository<E, K>` that you can extend and do magic with. The problem is that
it exposes too many available actions you may not be interested in and that it
is not a class so it's not clear which implementation you're using.

The second one is with separating the domain entities from the database
entities.

### Repository

I'm proud to present you with my solution:

```java
// We declare a JPA repository as always, with all of JPA's magic in it
@Repository
public interface NativeJpaUserRepository extends JpaRepository<User, Long> {
}

// We create an interface for business use
public interface UserRepository {
	public Optional<User> getById(Long id);
}

// We create an implementation for that interface we previously created, with
// a dependency to that NativeJpaUserRepository we previously created
@Repository
public class JpaUserRepository implements UserRepository {
	private final NativeJpaUserRepository native;

	public JpaUserRepository(NativeJpaUserRepository native) {
		this.native = native;
	}

	public Optional<User> getById(Long id) {
		return native.getById(id);
	}
}
```

This way you can hide all the methods you don't want to use, and if you ever
need a different implementation of `UserRepository` you only have to implement
the few methods you really need.
