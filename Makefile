all: prog_orig

prog_orig: prog_orig.f90
	$(MPIF90) -o $@ prog_orig.f90

test: prog_orig
	@echo ' *** Single executable test ***'
	srun -p test -t 5 -N 1 -n 16 $<
	@echo ' *** MPMD test ***'
	printf "0-15 $<\n16-23 $<\n" > mpmd.conf
	srun -p test -t 5 -N 1 -n 24 --multi-prog mpmd.conf

clean:
	rm -f prog_orig mpmd.conf
