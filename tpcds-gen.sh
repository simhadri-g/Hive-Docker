#! /bin/bash

cd /tpcds-data/tpcds-kit/tools/
./dsdgen -scale 100 -dir /tpcds-data/tpcds-data -parallel 8 -child 1 &amp;
./dsdgen -scale 100 -dir /tpcds-data/tpcds-data -parallel 8 -child 2 &amp;
./dsdgen -scale 100 -dir /tpcds-data/tpcds-data -parallel 8 -child 3 &amp;
./dsdgen -scale 100 -dir /tpcds-data/tpcds-data -parallel 8 -child 4 &amp;
./dsdgen -scale 100 -dir /tpcds-data/tpcds-data -parallel 8 -child 5 &amp;
./dsdgen -scale 100 -dir /tpcds-data/tpcds-data -parallel 8 -child 6 &amp;
./dsdgen -scale 100 -dir /tpcds-data/tpcds-data -parallel 8 -child 7 &amp;
./dsdgen -scale 100 -dir /tpcds-data/tpcds-data -parallel 8 -child 8 &amp;
