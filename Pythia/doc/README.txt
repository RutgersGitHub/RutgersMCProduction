# To compile pythia fotran file (note: a .o file has been provided. Thus this step may be skipped.)
gfortran -c -m64 -fPIC pythia*.f

# To create fortran executable file
gfortran -ffixed-line-length-none <configfilename>.f  pythia-6.4.26.o -o <ouputfilename>.out

# To run fortran executable file
./<ouputfilename>.out <enter>
<randomseed> <pythialogfilename>.txt <lhefilenane.lhe> <enter>

# Where <randomseed> is a random seed used by Pythia, <pythialogfilename>.txt is the pythia log output filename, 
# and <lhefilenane.lhe> is the output LHE filename
