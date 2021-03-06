%module fortran_ownership

%{
#include "boost/shared_ptr.hpp"
%}

%immutable foo_counter;
%immutable bar_counter;

// We aren't allowed to return a class via func-to-subroutine conversion, but we're going to test it and hide the warning
%fortransubroutine make_foo_subroutine;
%warnfilter(SWIGWARN_FORTRAN_NO_SUBROUTINE) make_foo_subroutine;

%include <boost_shared_ptr.i>
%shared_ptr(Bar)

%inline %{

static int foo_counter = 0;
static int bar_counter = 0;

struct Foo {
    int val;

    Foo(int val_) : val(val_) { ++foo_counter; }
    Foo(const Foo& other) : val(other.val) { ++foo_counter; }
    ~Foo() { --foo_counter; }
};

Foo& reference(Foo& other) { return other; }
const Foo& const_reference(const Foo& other) { return other; }
Foo make_foo(int val) { return Foo(val); }
Foo make_foo_subroutine(int val) { return Foo(val); }

int get_value(const Foo& other) { return other.val; }

struct Bar {
    int val;

    Bar(int val_) : val(val_) { ++bar_counter; }
    Bar(const Bar& other) : val(other.val) { ++bar_counter; }
    ~Bar() { --bar_counter; }
};

boost::shared_ptr<Bar> share(boost::shared_ptr<Bar> other) { return other; }
int use_count(const boost::shared_ptr<Bar>& sp) { return sp.use_count(); }
%}
