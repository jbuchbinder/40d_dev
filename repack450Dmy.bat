echo -------------- 450D REPACK --------------------

copy /b header.bin + autoexec.bin 450d_my.fir


echo correcting checksum and size in fir-header

csumsize 450d_my.fir

echo copy fir to SDcard

copy /Y 450d_my.fir G:\

pause

