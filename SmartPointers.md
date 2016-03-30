
## What problem does it solve? ##

Smart pointers solve the problem of managing the lifetime of resource (typically dynamically allocated) or problem of acquisition and release of resources (files or network connections). Here we cover the first case of storing pointers to dynamically allocated objects and delete those objects at the right time.

## When do v need smart pointer? ##

Some typical scenarios when smart pointers are appropriate:

  * Shared ownership of resource;

This is the case when two or more objects must use a third object. How should that third object be deallocated? Delegate the monitoring work to a smart pointer. When no more shared owners exist, the smart pointer can safely free the resource.

  * Exception-safe code;

Exception-safe means not leaking resource and preserving invariants of program when an exception is thrown. When an object is dynamically allocated, it won't be deleted automatically when an exception is thrown. As the stack unwinds and the pointer goes out of scope, the resource is possibly lost until the program exits. Smart pointers comes to the rescue.

  * Avoid common errors, such as memory leaks;

Forgetting to call delete is one of the oldest mistake of the programming activity. A smart pointer doesn't care about the control path of a program. It only cares about deleting a pointed-to object at the end of its life time.

## scoped\_ptr ##

_`boost::scoped_ptr`_ has similar characteristics to `std::auto_ptr`, with the important difference that it doesn't transfer ownership the way `auto_ptr` does. A `scoped_ptr` cannot be copied or assigned at all. This property improves expressiveness in our code, as we can select the smart pointer that best fit for our code.

Using `scope_ptr` doesn't make ur program larger or run slower. It only makes your code safer and more maintainable.

### Synopsis ###

Simplify for simplicity.

```
namespace boost {

template<typename T> class scoped_ptr : noncopyable {
public:
    explicit scoped_ptr(T* p = 0); 
    ~scoped_ptr(); 

    void reset(T* p = 0); 

    T& operator*() const; 
    T* operator->() const; 
    T* get() const; 
   
    void swap(scoped_ptr& b); 
};

template<typename T> 
    void swap(scoped_ptr<T> & a, scoped_ptr<T> & b); 
}
```

### Members description ###

#### `explicit scoped_ptr(T* p = 0);` ####

Store a copy of p. p must be allocated using operator new or be null. There's no requirement on T to be a complete type at the time of construction. This is useful when p is the result of some allocation functions. A forward declaration of T is enough.

#### `~scoped_ptr();` ####

Delete the pointer. The type T must be a complete type when it is destroyed. If the `scoped_ptr` holds no resource at the time of its destruction, nothing will happen.

#### `void reset(T* p = 0);` ####

Deletes the stored pointer it already owns, if any, and saves p. Use it sparingly (Is there a design problem?)

#### `T& operator*() const;` ####

Returns a reference to the object pointed to by the stored pointer. Dereference a null `scoped_ptr` will result in undefined behavior (There are no null reference).

#### `T* operator->() const;` ####

Returns a stored pointer. It's undefined behavior to invoke this operator if the stored pointer is null.

#### `T* get() const;` ####

Returns the stored pointer. Use get() with caution, because of the issues of dealing with raw pointers.

#### operator unspecified\_bool\_type() const; ####

Returns whether the `scoped_ptr` is non-null. Rather than using get() to test the validity of the `scope_ptr`, prefer using this conversion function.

#### `void swap(scoped_ptr& b); ` ####

Exchange the contents of two `scoped_ptr`S.

### Free Function ###

#### `template<typename T> void swap(scoped_ptr<T> & a, scoped_ptr<T> & b);` ####

Exchange the contents of two scoped pointers. It's preferable because it can be applied generically to many pointer types. but `scoped_pointer.swap` only works on smart pointers.


### Usage ###

Using `scoped_ptr` is just as fast as using raw pointers. There's no size overhead.

To use `boost::scoped_ptr`:

  1. Include `boost::scoped_ptr`;
  1. The type of pointer is the parameter to the class template;

Example:

```
boost::scoped_ptr<std::string> pString(new std::string("Welcome"));
```

### A simple demo ###

```
#include "boost/scoped_ptr.hpp"
#include <string>
#include <iostream>

int main() {
    {
        boost::scoped_ptr<std::string> 
        p(new std::string("Use scoped_ptr often."));

        // Print the value of the string
        if (p)
            std::cout << *p << '\n';
    
        // Get the size of the string
        size_t i=p->size();

        // Assign a new value to the string
        *p = "Acts just like a pointer";
  
    } // p is destroyed here, and deletes the std::string 
}
```

Things are worth noting:

  * `scoped_ptr` can be tested for validity;
  * Call member functions on the pointer works like raw pointers;
  * Deference `scoped_ptr` works exactly like raw pointers;
  * No need to manually delete;

> ### `boost::scoped_ptr` vs `std::auto_ptr` ###

> The major difference between them is the treatment of ownership. `auto_ptr` willingly transfer ownership away frm the source `auto_ptr` when be copied, whereas a scoped\_ptr cannot be copied. Take look at the example:

```
void scoped_vs_auto() {

    using boost::scoped_ptr;
    using std::auto_ptr;

    scoped_ptr<std::string> p_scoped(new std::string("Hello"));
    auto_ptr<std::string> p_auto(new std::string("Hello"));

    p_scoped->size();
    p_auto->size();

    scoped_ptr<std::string> p_another_scoped = p_scoped;  //!! Wrong, cannot be copied.
    // This assignment will leave p_auto with a null pointer.
	auto_ptr<std::string> p_another_auto = p_auto; 

    p_another_auto->size();
    (*p_auto).size(); // Bow!! Unpleasant surprise :-(
}
```

Things to remember:

  * Never, ever, store `auto_ptr`S into STL containers;
  * Don't do evil things by the return of `scoped_ptr::get()`;
  * Don't delete the return pointer of `scoped_ptr::get()`;
  * Don't store the raw pointer in another `scoped_ptr` object;

> ### `scoped_ptr` is NOT the same as const `auto_ptr` ###

  * They have different names:-)
  * A `scoped_ptr` can be reset;

### How smart pointer helps to improve the Pimpl Idiom ###

The idea behind the Pimpl Idiom is to insulate class clients from all knowledge about the private parts of a class. Because clients depend on the header file of a class, any changes to the header will affetc clients. So

#### key approach ####

  * Put private data and functions in a seperate type defined in the implementation file;
  * Forward declaring the type in the header file;

Then we remove the implementation dependcies from the header file.

The header file:

```
// pimpl_sample.hpp

#if !defined (PIMPL_SAMPLE)
#define PIMPL_SAMPLE

struct impl; // The forward declaration.

class pimpl_sample {
    impl* pimpl_;
public:
    pimpl_sample();
    ~pimpl_sample();
    void do_something();
};

#endif
```

Put the implementation of _impl_ into the implementation file.

```
// pimpl_sample.cpp 

#include "pimpl_sample.hpp"
#include <string>
#include <iostream>

struct pimpl_sample::impl {
    void do_something_() {
        std::cout << s_ << "\n";
    }

    std::string s_;
};

pimpl_sample::pimpl_sample()
  : pimpl_(new impl) {
    pimpl_->s_ = "This is the pimpl idiom";
}

pimpl_sample::~pimpl_sample() {
    delete pimpl_;
}

void pimpl_sample::do_something() {
    pimpl_->do_something_();
}  
```

Then any changes in the implementation file will not affect the header and users. Perfect? NO!

The implementation is not exception safe.

The pimple\_sample constructor may throw an exception after the `pimpl_` was constructed, then the desctructor will never be called when the stack unwind.

However, `scoped_ptr` comes to the rescue.

```
class pimpl_sample {
    struct impl;
	// Neve need to delete pimpl_ in the desctructor.
    boost::scoped_ptr<impl> pimpl_;
    ...
};  
```

It's worth noting that if `pimpl_` can be safely shared between instances of the enclosing class, boost::shared\_ptr is the right choice for handling its lifetime.


_To be continue..._