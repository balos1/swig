//---------------------------------*-C++-*-----------------------------------//
/*!
 * \file   spdemo/spdemo.h
 * \author Seth R Johnson
 * \date   Tue Dec 06 14:55:04 2016
 * \brief  spdemo class declaration.
 * \note   Copyright (c) 2016 Oak Ridge National Laboratory, UT-Battelle, LLC.
 */
//---------------------------------------------------------------------------//

#ifndef spdemo_spdemo_hh
#define spdemo_spdemo_hh

#include <memory>

class Foo {
public:
  double d_val;

public:
  // Constructor
  Foo();
  Foo(const Foo &other);
  Foo(double val);
  ~Foo();

  double get() const;
  void set(double v);

  // Return a copy by value
  Foo clone() const;
  // Return an SP copy
  std::shared_ptr<Foo> clone_sp() const;

  // Return references to ourself
  Foo &mutable_ref() { return *this; }
  const Foo &ref() const { return *this; }

  Foo *mutable_ptr() { return this; }
  const Foo *ptr() const { return this; }
};

int use_count(const std::shared_ptr<Foo> *f) {
  if (!f) return 0;
  return f->use_count();
}
void print_crsp(const std::shared_ptr<Foo> &f);
void print_sp(std::shared_ptr<Foo> f);
void print_spc(std::shared_ptr<const Foo> f);
void print_crspc(const std::shared_ptr<const Foo> &f);
void print_cr(const Foo &f);

//---------------------------------------------------------------------------//
#endif                                 // spdemo_spdemo_hh

//---------------------------------------------------------------------------//
// end of spdemo/spdemo.h
//---------------------------------------------------------------------------//
