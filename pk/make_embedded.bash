#!/bin/bash
# Run this to create a pk that includes and runs the user progeram elf from the
# software dir.

rm -rf build
mkdir build
cp ../software/user_program.elf build/helloworld
cd build
export temp_cc=$CC
export CC=
export PATH=/add/your/path/here:$PATH
../configure --prefix=$RISCV --host=riscv64-unknown-elf
export CC=$temp_cc
make -j $(nproc)
cd ../
cp build/pk pk_fr_aws
riscv64-unknown-elf-objcopy pk_fr_aws -O binary pk_fr_aws.bin
python freedom-bin2hex.py --bit-width 128 -itype bin -otype hex pk_fr_aws.bin pk_fr_aws.hex


