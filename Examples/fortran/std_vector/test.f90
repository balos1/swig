!-----------------------------------------------------------------------------!
! \file   std_vector/test.f90
! \author Seth R Johnson
! \date   Mon Dec 05 09:05:31 2016
! \brief  test module
! \note   Copyright (c) 2016 Oak Ridge National Laboratory, UT-Battelle, LLC.
!-----------------------------------------------------------------------------!

program main
    use ISO_FORTRAN_ENV
    use, intrinsic :: ISO_C_BINDING
    use stdvec, only : make_view => make_const_viewdbl, &
        print_view => print_viewdbl, VecDbl, get_vec_ref => get_vec_refdbl
    implicit none
    type(VecDbl) :: v
    integer :: i
    real(C_DOUBLE), pointer :: vview(:)
    real(C_DOUBLE), allocatable :: local_vec(:)
    real(C_DOUBLE), dimension(4)  :: test_dbl = (/ 0.1, 1.9, -2.0, 4.0 /)

    ! This should be a null-op since the underlying pointer is initialized to
    ! null
    call v%release()

    write(0, *) "Constructing..."
    call v%create()
    write(0, *) "Sizing..."
    call v%resize(4)
    write(0, *) "Resizing with fill..."
    call v%resize(10, 1.5d0)

    write(0, *) "Setting"
    do i = 0, 7
        call v%set(i, real(i + 1) * 123.0d0)
    end do

    vview => make_view(v)

    write(0, *) "pointer:", vview

    write(0, *) "Printing from array pointer"
    call print_view(vview)

    write(0, *) "Printing from test data"
    call print_view(test_dbl)

    write(0, *) "Copying vector of data"
    local_vec = get_vec_ref()
    write(0, *) "Printing that data"
    call print_view(local_vec)

    write(0, *) "Destroying..."
    call v%release()
end program

!-----------------------------------------------------------------------------!
! end of std_vector/test.f90
!-----------------------------------------------------------------------------!
