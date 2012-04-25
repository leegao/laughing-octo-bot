cd trolls
make
cd ..
echo "s 100000" | ./flamewar -vvvv -d -t 20000 -s 1000 trolls/bin/self trolls/bin/noop > out
cat out | grep "0\.0" > core0
cat out | grep "0\.2" > core2
cat out | grep "0\.1" > core1
cat out | grep "0\.3" > core3
cd trolls
mipsel-linux-objdump -xdlS bin/self > ../self.asm
cd ..
