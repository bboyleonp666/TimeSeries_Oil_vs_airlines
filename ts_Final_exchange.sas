%let dir = D:\�ɶ��ƦC���R\Final_project\data;
%let JPY = JPY_to_USD.xlsx;
%let TWD = TWD_to_USD.xlsx;
%let CHY = CNY_to_USD.xlsx;

proc import datafile = "&dir\&JPY" out = JPY
dbms = xlsx replace;
datarow = 4;
getnames = no;
data JPY;
set jpy;
rename 
	A = time
	B = exchange
	C = pred
	;
proc sort;
by time;
proc print; run;

proc gplot data = jpy;
title "Time Series data for Japan";
plot exchange * time;
symbol c = red i = spline v = dot;
run;

proc import datafile = "&dir\&TWD" out = TWD
dbms = xlsx replace;
datarow = 4;
getnames = no;
data TWD;
set twd;
rename 
	A = time
	B = exchange
	C = pred
	;
proc sort;
by time;
proc print; run;

proc gplot data = twd;
title "Time Series data for Taiwan";
plot exchange * time;
symbol c = red i = spline v = dot;
run;

proc arima data = jpy;
identify var = exchange nlag = 36 stationarity = (adf=0); *test stationarity by agument dickey-fuller test;
run;
proc arima data = jpy;
identify var = exchange(1) nlag = 36 stationarity = (adf=0); *test stationarity by agument dickey-fuller test;
run;

proc arima data = twd;
identify var = exchange nlag = 36 stationarity = (adf=0); *test stationarity by agument dickey-fuller test;
run;
proc arima data = twd;
identify var = exchange(1) nlag = 36 stationarity = (adf=0); *test stationarity by agument dickey-fuller test;
run;
proc arima data = twd;
identify var = exchange(1) nlag = 36 stationarity = (adf=0); *test stationarity by agument dickey-fuller test;
estimate p = 1 method = ml;
run;

proc import datafile = "&dir\&CHY" out = CHY
dbms = xlsx replace;
datarow = 4;
getnames = no;
data CHY;
set chy;
rename 
	A = time
	B = exchange
	C = pred
	;
proc sort;
by time;
proc print; run;

proc gplot data = chy;
title "Time Series data for China";
plot exchange * time;
symbol c = red i = spline v = dot;
run;

proc arima data = chy;
identify var = exchange nlag = 36 stationarity = (adf=0); *test stationarity by agument dickey-fuller test;
run;
proc arima data = chy;
identify var = exchange(1) nlag = 36 stationarity = (adf=0); *test stationarity by agument dickey-fuller test;
run;
