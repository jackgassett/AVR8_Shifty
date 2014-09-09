REM For Papilio DUO LX9
set ucf=BPC3013_Papilio_DUO.ucf
set FinalName=AVR8_Shifty_PapilioDUO_LX9
set chip=xc6slx9-tqg144-2
xst -intstyle ise -ifn "top_avr_core_v8.xst" -ofn "top_avr_core_v8.syr" > out.txt
ngdbuild -intstyle ise -dd _ngo -sd ipcore_dir -nt timestamp -uc %ucf% -bm top_avr_core_V8.bmm -p %chip% top_avr_core_v8.ngc top_avr_core_v8.ngd  >> out.txt
map -intstyle ise -p %chip% -w -logic_opt off -ol high -t 1 -xt 0 -register_duplication off -r 4 -global_opt off -mt off -ir off -pr off -lc off -power off -o top_avr_core_v8_map.ncd top_avr_core_v8.ngd top_avr_core_v8.pcf >> out.txt
xst -intstyle ise -ifn "top_avr_core_v8.xst" -ofn "top_avr_core_v8.syr" >> out.txt
ngdbuild -intstyle ise -dd _ngo -sd ipcore_dir -nt timestamp -uc %ucf% -bm top_avr_core_V8.bmm -p %chip% top_avr_core_v8.ngc top_avr_core_v8.ngd  >> out.txt
map -intstyle ise -p %chip% -w -logic_opt off -ol high -t 1 -xt 0 -register_duplication off -r 4 -global_opt off -mt off -ir off -pr off -lc off -power off -o top_avr_core_v8_map.ncd top_avr_core_v8.ngd top_avr_core_v8.pcf >> out.txt
par -w -intstyle ise -ol high -mt off top_avr_core_v8_map.ncd top_avr_core_v8.ncd top_avr_core_v8.pcf >> out.txt
trce -intstyle ise -v 3 -s 2 -n 3 -fastpaths -xml top_avr_core_v8.twx top_avr_core_v8.ncd -o top_avr_core_v8.twr top_avr_core_v8.pcf -ucf %ucf% >> out.txt
bitgen -intstyle ise -f top_avr_core_v8.ut top_avr_core_v8.ncd >> out.txt
copy top_avr_core_v8.bit %FinalName%.bit
copy top_avr_core_v8_bd.bmm %FinalName%_bd.bmm
copy out.txt %FinalName%_out.txt
del top_avr_core_v8*.bit

pause

REM For Papilio Logic LX9
set ucf=BPC3011_Papilio_Logic.ucf
set FinalName=AVR8_Shifty_PapilioLogic_LX9
set chip=xc6slx9-tqg144-2
xst -intstyle ise -ifn "top_avr_core_v8.xst" -ofn "top_avr_core_v8.syr" > out.txt
ngdbuild -intstyle ise -dd _ngo -sd ipcore_dir -nt timestamp -uc %ucf% -bm top_avr_core_V8.bmm -p %chip% top_avr_core_v8.ngc top_avr_core_v8.ngd  >> out.txt
map -intstyle ise -p %chip% -w -logic_opt off -ol high -t 1 -xt 0 -register_duplication off -r 4 -global_opt off -mt off -ir off -pr off -lc off -power off -o top_avr_core_v8_map.ncd top_avr_core_v8.ngd top_avr_core_v8.pcf >> out.txt
xst -intstyle ise -ifn "top_avr_core_v8.xst" -ofn "top_avr_core_v8.syr" >> out.txt
ngdbuild -intstyle ise -dd _ngo -sd ipcore_dir -nt timestamp -uc %ucf% -bm top_avr_core_V8.bmm -p %chip% top_avr_core_v8.ngc top_avr_core_v8.ngd  >> out.txt
map -intstyle ise -p %chip% -w -logic_opt off -ol high -t 1 -xt 0 -register_duplication off -r 4 -global_opt off -mt off -ir off -pr off -lc off -power off -o top_avr_core_v8_map.ncd top_avr_core_v8.ngd top_avr_core_v8.pcf >> out.txt
par -w -intstyle ise -ol high -mt off top_avr_core_v8_map.ncd top_avr_core_v8.ncd top_avr_core_v8.pcf >> out.txt
trce -intstyle ise -v 3 -s 2 -n 3 -fastpaths -xml top_avr_core_v8.twx top_avr_core_v8.ncd -o top_avr_core_v8.twr top_avr_core_v8.pcf -ucf %ucf% >> out.txt
bitgen -intstyle ise -f top_avr_core_v8.ut top_avr_core_v8.ncd >> out.txt
copy top_avr_core_v8.bit %FinalName%.bit
copy top_avr_core_v8_bd.bmm %FinalName%_bd.bmm
copy out.txt %FinalName%_out.txt
del top_avr_core_v8*.bit

pause

REM For Papilio Plus LX9
set ucf=BPC3010_Papilio_Plus.ucf
set FinalName=AVR8_Shifty_PapilioPlus_LX9
set chip=xc6slx9-tqg144-2
xst -intstyle ise -ifn "top_avr_core_v8.xst" -ofn "top_avr_core_v8.syr" > out.txt
ngdbuild -intstyle ise -dd _ngo -sd ipcore_dir -nt timestamp -uc %ucf% -bm top_avr_core_V8.bmm -p %chip% top_avr_core_v8.ngc top_avr_core_v8.ngd  >> out.txt
map -intstyle ise -p %chip% -w -logic_opt off -ol high -t 1 -xt 0 -register_duplication off -r 4 -global_opt off -mt off -ir off -pr off -lc off -power off -o top_avr_core_v8_map.ncd top_avr_core_v8.ngd top_avr_core_v8.pcf >> out.txt
xst -intstyle ise -ifn "top_avr_core_v8.xst" -ofn "top_avr_core_v8.syr" >> out.txt
ngdbuild -intstyle ise -dd _ngo -sd ipcore_dir -nt timestamp -uc %ucf% -bm top_avr_core_V8.bmm -p %chip% top_avr_core_v8.ngc top_avr_core_v8.ngd  >> out.txt
map -intstyle ise -p %chip% -w -logic_opt off -ol high -t 1 -xt 0 -register_duplication off -r 4 -global_opt off -mt off -ir off -pr off -lc off -power off -o top_avr_core_v8_map.ncd top_avr_core_v8.ngd top_avr_core_v8.pcf >> out.txt
par -w -intstyle ise -ol high -mt off top_avr_core_v8_map.ncd top_avr_core_v8.ncd top_avr_core_v8.pcf >> out.txt
trce -intstyle ise -v 3 -s 2 -n 3 -fastpaths -xml top_avr_core_v8.twx top_avr_core_v8.ncd -o top_avr_core_v8.twr top_avr_core_v8.pcf -ucf %ucf% >> out.txt
bitgen -intstyle ise -f top_avr_core_v8.ut top_avr_core_v8.ncd >> out.txt
copy top_avr_core_v8.bit %FinalName%.bit
copy top_avr_core_v8_bd.bmm %FinalName%_bd.bmm
copy out.txt %FinalName%_out.txt
del top_avr_core_v8*.bit

pause

REM For Papilio One 500K
set ucf=BPC3003_2.03+.ucf
set FinalName=AVR8_Shifty_PapilioOne_500
set chip=xc3s500e-vq100-4
xst -intstyle ise -ifn "top_avr_core_v8.xst" -ofn "top_avr_core_v8.syr" > out.txt
ngdbuild -intstyle ise -dd _ngo -sd ipcore_dir -nt timestamp -uc %ucf% -bm top_avr_core_V8.bmm -p %chip% top_avr_core_v8.ngc top_avr_core_v8.ngd  >> out.txt
map -intstyle ise -p %chip% -w -logic_opt off -ol high -t 1 -xt 0 -register_duplication off -r 4 -global_opt off -mt off -ir off -pr off -power off -o top_avr_core_v8_map.ncd top_avr_core_v8.ngd top_avr_core_v8.pcf >> out.txt
xst -intstyle ise -ifn "top_avr_core_v8.xst" -ofn "top_avr_core_v8.syr" >> out.txt
ngdbuild -intstyle ise -dd _ngo -sd ipcore_dir -nt timestamp -uc %ucf% -bm top_avr_core_V8.bmm -p %chip% top_avr_core_v8.ngc top_avr_core_v8.ngd  >> out.txt
map -intstyle ise -p %chip% -w -logic_opt off -ol high -t 1 -xt 0 -register_duplication off -r 4 -global_opt off -mt off -ir off -pr off -power off -o top_avr_core_v8_map.ncd top_avr_core_v8.ngd top_avr_core_v8.pcf >> out.txt
par -w -intstyle ise -ol high -mt off top_avr_core_v8_map.ncd top_avr_core_v8.ncd top_avr_core_v8.pcf >> out.txt
trce -intstyle ise -v 3 -s 2 -n 3 -fastpaths -xml top_avr_core_v8.twx top_avr_core_v8.ncd -o top_avr_core_v8.twr top_avr_core_v8.pcf -ucf %ucf% >> out.txt
bitgen -intstyle ise -f top_avr_core_v8.ut top_avr_core_v8.ncd >> out.txt
copy top_avr_core_v8.bit %FinalName%.bit
copy top_avr_core_v8_bd.bmm %FinalName%_bd.bmm
copy out.txt %FinalName%_out.txt
del top_avr_core_v8*.bit

REM For Papilio One 250K.
set ucf=BPC3003_2.03+.ucf
set FinalName=AVR8_Shifty_PapilioOne_250
set chip=xc3s250e-vq100-4
xst -intstyle ise -ifn "top_avr_core_v8.xst" -ofn "top_avr_core_v8.syr" > out.txt
ngdbuild -intstyle ise -dd _ngo -sd ipcore_dir -nt timestamp -uc %ucf% -bm top_avr_core_V8.bmm -p %chip% top_avr_core_v8.ngc top_avr_core_v8.ngd  >> out.txt
map -intstyle ise -p %chip% -w -logic_opt off -ol high -t 1 -xt 0 -register_duplication off -r 4 -global_opt off -mt off -ir off -pr off -power off -o top_avr_core_v8_map.ncd top_avr_core_v8.ngd top_avr_core_v8.pcf >> out.txt
xst -intstyle ise -ifn "top_avr_core_v8.xst" -ofn "top_avr_core_v8.syr" >> out.txt
ngdbuild -intstyle ise -dd _ngo -sd ipcore_dir -nt timestamp -uc %ucf% -bm top_avr_core_V8.bmm -p %chip% top_avr_core_v8.ngc top_avr_core_v8.ngd  >> out.txt
map -intstyle ise -p %chip% -w -logic_opt off -ol high -t 1 -xt 0 -register_duplication off -r 4 -global_opt off -mt off -ir off -pr off -power off -o top_avr_core_v8_map.ncd top_avr_core_v8.ngd top_avr_core_v8.pcf >> out.txt
par -w -intstyle ise -ol high -mt off top_avr_core_v8_map.ncd top_avr_core_v8.ncd top_avr_core_v8.pcf >> out.txt
trce -intstyle ise -v 3 -s 2 -n 3 -fastpaths -xml top_avr_core_v8.twx top_avr_core_v8.ncd -o top_avr_core_v8.twr top_avr_core_v8.pcf -ucf %ucf% >> out.txt
bitgen -intstyle ise -f top_avr_core_v8.ut top_avr_core_v8.ncd >> out.txt
copy top_avr_core_v8.bit %FinalName%.bit
copy top_avr_core_v8_bd.bmm %FinalName%_bd.bmm
copy out.txt %FinalName%_out.txt
del top_avr_core_v8*.bit

pause