#!/usr/bin/bash

source "$HOME/.cargo/env"

module load python/3.10.5

PYTHON=0
SWIFT=0
RUST=0
GO=0
CHAPEL=1

TIME=1000
SIZE=1000000

if [ "${PYTHON}" == "1" ]
then

    cd python

    for i in {40..0..2}
    do 
        python3.10 heat2.py $i ${TIME} ${SIZE} 0 
    done

    cd ..

fi

if [ "${SWIFT}" == "1" ]
then
    cd swift/heat

    for i in {40..0..2}
    do 
        ./heat_3 $i ${TIME} ${SIZE} >> perfstat.csv
    done

    cd ../..
fi


if [ "${RUST}" == "1" ]
then
    cd rust/heat_simd/target/release

    for i in {40..0..2}
    do 
        ./heat_simd $i ${TIME} ${SIZE}
    done

    cd ../../../..
fi


if [ "${GO}" == "1" ]
then
    cd go/heat

    for i in {40..0..2}
    do 
        ./main $i ${TIME} ${SIZE}
    done

    cd ../..
fi


if [ "${CHAPEL}" == "1" ]
then
    cd chapel

    for i in {40..0..2}
    do 
        CHPL_RT_NUM_THREADS_PER_LOCALE=$i ./heat --nx ${SIZE} --nt ${TIME} >> perfstat.csv
    done

    cd ../
fi



