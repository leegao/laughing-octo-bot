cd trolls
make
cd ..
echo "s 100000" | ./flamewar -vvvv -d -t 100000 -s 1000 trolls/bin/self trolls/bin/greedy > out
cat out | grep "0\.0" > core0
cat out | grep "0\.2" > core2
cat out | grep "0\.1" > core1
cat out | grep "0\.3" > core3
