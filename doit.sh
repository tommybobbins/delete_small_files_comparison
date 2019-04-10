if [ ! -d output ]
then
    mkdir output
fi
./run_tests.sh 10 10000
./run_tests.sh 20 10000
./run_tests.sh 30 10000
./run_tests.sh 40 10000
./run_tests.sh 80 10000
./run_tests.sh 100 10000
./run_tests.sh 80 1000
./run_tests.sh 40 1000
./run_tests.sh 30 1000
./run_tests.sh 20 1000
./run_tests.sh 100 1000
./run_tests.sh 1000 10000
./run_tests.sh 2000 10000
./run_tests.sh 3000 10000
./run_tests.sh 4000 10000
./run_tests.sh 5000 10000
rsync -av /tmp/small_files* output
