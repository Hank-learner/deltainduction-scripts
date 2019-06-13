#! /bin/bash -x

sudo useradd MasterH -m -s /bin/bash
sudo passwd MasterH

arr=(Hertz Holland Heisenberg)
for((j=0;j<3;j++))
do
   sudo useradd ${arr[$j]} -m -s /bin/bash
   sudo passwd ${arr[$j]}
done

for((i=1;i<=20;i++))
do
  for((j=0;j<3;j++))
  do
     sudo useradd ${arr[$j]}${i} -m -s /bin/bash
     sudo passwd ${arr[$j]}${i}
     #entering password
  done     
done


for((j=0;j<3;j++))
do
  sudo gpasswd -a MasterH ${arr[$j]}
done



for((i=1;i<=20;i++))
do
  for((j=0;j<3;j++))
  do
     sudo gpasswd -a ${arr[$j]} ${arr[$j]}${i}
     sudo gpasswd -a MasterH ${arr[$j]}${i}
  done
done

#In home directory
cd /home
sudo chmod 700 MasterH 

for((j=0;j<3;j++))
do
  sudo chmod 770 ${arr[$j]}
done

for((i=1;i<=20;i++))
do
    for((j=0;j<3;j++))
  do
     sudo chmod 770 ${arr[$j]}${i}
  done
done


sudo su
arr=(Hertz Holland Heisenberg)
for((i=1;i<=20;i++))
do
  for((j=0;j<3;j++))
  do
     cd ${arr[$j]}${i}/
     umask 222
     cd ..
  done
done

for((k=1;k<3;k++))
    do
    cd ${arr[$k]}/
    for((i=1;i<=5;i++))
        do
        mkdir task${i}
        cd task${i}
        for((j=1;j<=50;j++))
            do 
            touch ${arr[$k]}_task${j}
            head /dev/urandom | tr -dc '!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~A-Za-z0-9' | head -c 128 >> Hertz_task${j}
            done
        cd ..
    done
    cd..
done


for((k=1;k<3;k++))
do
      for((i=1;i<=20;i++))
          do
          cd ${arr[$k]}${i}/
          for((j=1;j<=5;j++))
              do
              mkdir task${j}
              done
          cd ..
      done
done





touch dailytask.sh
gedit dailytask.sh
chmod u+x dailytask.sh
#inside dailytask.sh
  #! /bin/bash
  for((k=1;k<3;k++))
  do  
      for((i=1;i<=5;i++))
      do
           cd /home/${arr[$k]}/task${i}
           for((j=1;j<=20;j++))
           do
             ls | sort -R | tail -5 | while read file; do
               cp $file /home/${arr[$k]}${j}/task${j}
               chmod 444 /home/${arr[$k]}${j}/task${j}/${file}
               done
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
for((k=0;k<3;k++))
do
   cd /home/${arr[$k]}
   touch success failure
done


for((i=1;i<=20;i++))
do
  for((j=0;j<3;j++))
  do
	cd /home/${arr[$j]}${i}{
	touch} success failure
  done
done


cd /home/MasterH
cat server_logs.txt | grep ".*MasterH ->" >> success 
for((j=0;j<3;j++))
do
  cd /home/${arr[$j]}
  cat server_logs.txt | grep ".*${arr[$j]} -> ${arr[$j]}.*" >> success
  cat server_logs.txt | grep "${arr[$j]} ->" | grep -v "${arr[$j]} -> ${arr[$j]}" >> failure
done

for((i=1;i<=20;i++))
do
    for((j=0;j<3;j++))
    do
	  cd /home${arr[j]}${i}
    cat server_logs.txt | grep '${arr[$j]}-Intern${i} -> ${arr[$j]}-Intern${i}' >> success
    cat server_logs.txt | grep '${arr[$j]}-Intern${i} ->' | grep -v '${arr[$j]}-Intern${i} -> ${arr[$j]}-Intern${i}' >> failure
    done
done


#for displaying in table
for((i=1;i<=20;i++))
do
  for((j=0;j<3;j++))
  do
	cat server_logs.txt | grep '${arr[$j]}-Intern${i}' | wc -l
  cat server_logs.txt | grep '${arr[$j]}-Intern${i}' | sed 's/\ /:/g' | cut -d: -f 1,2,3,4,5
  done
done
