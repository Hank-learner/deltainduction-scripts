#! /bin/bash

sudo useradd MasterH -m -s /bin/bash
sudo passwd MasterH

sudo useradd Hertz -m -s /bin/bash
sudo passwd Hertz
sudo useradd Holland -m -s /bin/bash
sudo passwd holland
sudo useradd Heisenberg -m -s /bin/bash
sudo passwd Heisenberg


for((i=1;i<=20;i++))
do
sudo useradd Hertz$i -m -s /bin/bash
sudo passwd Hertz$i
#entering password
done

for((i=1;i<=20;i++))
do
sudo useradd Holland$i -m -s /bin/bash
sudo passwd Holland$i
#entering password
done

for((i=1;i<=20;i++))
do
sudo useradd Heisenberg$i -m -s /bin/bash
sudo passwd Heisenberg$i
#entering password
done




for((i=1;i<=20;i++))
do
sudo gpasswd -a Hertz Hertz$i
sudo gpasswd -a MasterH Hertz$i
done

for((i=1;i<=20;i++))
do
sudo gpasswd -a Holland Holland$i
sudo gpasswd -a MasterH Holland$i
done

for((i=1;i<=20;i++))
do
sudo gpasswd -a Heisenberg Heisenberg$i
sudo gpasswd -a MasterH Heisenberg$i
done

sudo gpasswd -a MasterH Hertz
sudo gpasswd -a MasterH Holland
sudo gpasswd -a MasterH Heisenberg

#In home directory
cd /home
sudo chmod 700 MasterH 

sudo chmod 770 Hertz
sudo chmod 770 Holland
sudo chmod 770 Heisenberg

for((i=1;i<=20;i++))
do
sudo chmod 770 Hertz$i
done

for((i=1;i<=20;i++))
do
sudo chmod 770 Holland$i
done

for((i=1;i<=20;i++))
do
sudo chmod 770 Heisenberg$i
done

sudo su

for((i=1;i<=20;i++))
do
cd Hertz$1/
umask 222
cd ..
done

for((i=1;i<=20;i++))
do
cd Holland$1/
umask 222
cd ..
done

for((i=1;i<=20;i++))
do
cd Heisenberg$i/
umask 222
cd ..
done

cd Hertz/
for((i=1;i<=5;i++))
do
mkdir task$i
cd task$i
for((j=1;j<=50;j++))
do 
touch Hertz_task$j
head /dev/urandom | tr -dc '!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~A-Za-z0-9' | head -c 128 >> Hertz_task$j
done
cd ..
done
cd..

cd Holland/
for((i=1;i<=5;i++))
do
mkdir task$i
cd task$i
for((j=1;j<=50;j++))
do 
touch Holland_task$j
head /dev/urandom | tr -dc '!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~A-Za-z0-9' | head -c 128 >> Holland_task$j
done
cd ..
done
cd..

cd Heisenberg/
for((i=1;i<=5;i++))
do
mkdir task$i
cd task$i
for((j=1;j<=50;j++))
do 
touch Heisenberg_task$j
head /dev/urandom | tr -dc '!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~A-Za-z0-9' | head -c 128 >> Heisenberg_task$j
done
cd ..
done
cd..

for((i=1;i<=20;i++))
do
cd Hertz$i/
for((j=1;j<=5;j++))
do
mkdir task$j
done
cd ..
done

for((i=1;i<=20;i++))
do
cd Holland$i/
for((j=1;j<=5;j++))
do
mkdir task$j
done
cd ..
done

for((i=1;i<=20;i++))
do
cd Heisenberg$i/
for((j=1;j<=5;j++))
do
mkdir task$j
done
cd ..
done  




touch dailytask.sh
gedit dailytask.sh
chmod u+x dailytask.sh
#inside dailytask.sh
      #! /bin/bash
      for((i=1;i<=5;i++))
      do
           cd /home/Hertz/task$i
           for((j=1;j<=20;j++))
           do
             ls | sort -R | tail -5 | while read file; do
               cp $file /home/Hertz${j}/task${j}
               chmod 444 /home/Hertz${j}/task${j}/${file}
               done
            done
      done
      
      for((i=1;i<=5;i++))
      do
           cd /home/Holland/task$i
           for((j=1;j<=20;j++))
           do
              ls | sort -R | tail -5 | while read file; do
                  cp $file /home/Holland${j}/task${j}
                  chmod 444 /home/Hertz${j}/task${j}/${file}
              done
           done
      done
      
      for((i=1;i<=5;i++))
      do
            cd /home/Heisenberg/task$i
            for((j=1;j<=20;j++))
            do
               ls | sort -R | tail -5 | while read file; do
               cp $file /home/Heisenberg${j}/task${j}
               chmod 444 /home/Hertz${j}/task${j}/${file}
               done
            done
      done
      
      
crontab -e
#using nano editor adding code
0 0 * * * /bin/sh /home/dailytask.sh
#saving and exiting ^x





#hacker mode

cd /home/MasterH
touch success failure

cd /home/Heisenberg
touch success failure

cd /home/Hertz
touch success failure

cd /home/Holland
touch success failure


for((i=1;i<=20;i++))
do
	cd /home/Hertz${i}
	touch success failure

	cd /home/Holland${i}
	touch success failure

	cd /home/Heisenberg${i}
	touch success failure
done


cd /home/MasterH
cat server_logs.txt | grep ".*MasterH ->" >> success 

cd /home/Hertz
cat server_logs.txt | grep ".*Hertz -> Hertz.*" >> success
cat server_logs.txt | grep "Hertz ->" | grep -v "Hertz -> Hertz" >> failure

cd /home/Holland
cat server_logs.txt | grep ".*Holland -> Holland.*" >> success
cat server_logs.txt | grep "Holland ->" | grep -v "Holland -> Holland" >> failure

cd /home/Heisenberg
cat server_logs.txt | grep ".*Heisenberg -> Heisenberg.*" >> success
cat server_logs.txt | grep "Heisenberg ->" | grep -v "Heisenberg -> Heisenberg" >> failure

for((i=1;i<=20;i++))
do
	cd /home/Hertz${i}
    cat server_logs.txt | grep 'Hertz-Intern${i} -> Hertz-Intern${i}' >> success
    cat server_logs.txt | grep 'Hertz-Intern${i} ->' | grep -v 'Hertz-Intern${i} -> Hertz-Intern${i}' >> failure

    cd /home/Holland${i}
    cat server_logs.txt | grep 'Holland-Intern${i} -> Holland-Intern${i}' >> success
    cat server_logs.txt | grep 'Holland-Intern${i} ->' | grep -v 'Holland-Intern${i} -> Holland-Intern${i}' >> failure

    cd /home/Heisenberg${i}
    cat server_logs.txt | grep 'Heisenberg-Intern${i} -> Heisenberg-Intern${i}' >> success
    cat server_logs.txt | grep 'Heisenberg-Intern${i} ->' | grep -v 'Heisenberg-Intern${i} -> Heisenberg-Intern${i}' >> failure
done


#for displaying in table
for((i=1;i<=20;i++))
do
	cat server_logs.txt | grep 'Hertz-Intern${i}' | wc -l
    cat server_logs.txt | grep 'Hertz-Intern${i}' | sed 's/\ /:/g' | cut -d: -f 1,2,3,4,5
done

for((i=1;i<=20;i++))
do
	cat server_logs.txt | grep 'Hertz-Intern${i}' | wc -l
    cat server_logs.txt | grep 'Hertz-Intern${i}' | sed 's/\ /:/g' | cut -d: -f 1,2,3,4,5
done

for((i=1;i<=20;i++))
do
	cat server_logs.txt | grep 'Hertz-Intern${i}' | wc -l
    cat server_logs.txt | grep 'Hertz-Intern${i}' | sed 's/\ /:/g' | cut -d: -f 1,2,3,4,5
done








