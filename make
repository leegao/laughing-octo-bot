cd trolls
make
cd ..
echo "s 100000" | ./flamewar -vvvv -d -t 20000 -s 1000 trolls/bin/noop trolls/bin/self > out
cat out | grep "0\.0" > core0
cat out | grep "0\.2" > core2
cat out | grep "0\.1" > core1
cat out | grep "0\.3" > core3
cat out | grep "1\.0" > core10
cat out | grep "1\.2" > core12
cat out | grep "1\.1" > core11
cat out | grep "1\.3" > core13
cd trolls
mipsel-linux-objdump -xdlS bin/self > ../self.asm
cd ..
