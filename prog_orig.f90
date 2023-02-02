  implicit none


  include 'mpif.h'

  integer :: mpierr, nprocs, iproc, iapp, flag, &
       
       MPI_COMM_PENCIL,MPI_COMM_GRID


  call MPI_INIT(mpierr)

  !

  ! Size and rank w.r.t. MPI_COMM_WORLD

  !

  call MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, mpierr)

  call MPI_COMM_RANK(MPI_COMM_WORLD, iproc, mpierr)

  call MPI_COMM_GET_ATTR(MPI_COMM_WORLD, MPI_APPNUM, iapp, flag, mpierr)

  call MPI_COMM_SPLIT(MPI_COMM_WORLD, iapp, iproc, MPI_COMM_PENCIL, mpierr)

  iapp=0

  call MPI_COMM_RANK(MPI_COMM_PENCIL, iproc, mpierr)

  !print*, 'PENCIL1: iapp, nprocs=', iapp, nprocs   !MPI_COMM_PENCIL, MPI_COMM_WORLD

  !

  print*, 'PENCIL2: before DUP', iproc

  call MPI_COMM_DUP(MPI_COMM_PENCIL,MPI_COMM_GRID,mpierr)

  print*, 'PENCIL3: after DUP', iproc


  call MPI_FINALIZE(mpierr)


end program
