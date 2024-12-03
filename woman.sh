#!/bin/sh


start_dishwasher(){
  dir=$1
  file=$2
  mod=$3
  port=${4-"60610"}

  scp $dir/$file helios:~/dishwasher/dirty_file
  exec 3<>/dev/tcp/se.ifmo.ru/${port="60605"}
  #exec 3<>/dev/tcp/127.0.0.1/$port
  echo start $mod >&3
  while read <&3; 
  do
    echo "WS MSG:[${REPLY//$CR/}]"
    if [[ ${REPLY:0:5} = "Error" ]]; then
      error= true
      echo "WS MSG:[${REPLY//$CR/}]"
      break
    elif [[ $REPLY = "Сompleted" ]]; then
      eror= false
      echo adasdasd
      break
    fi
  done
  
  if [[ $error = "true" ]]; then
    echo I\'m sorry, I couldn\'t turn on the dishwasher.
  else
    scp helios:~/dishwasher/clear_file/$file $dir
    echo I\'m wash your file
  fi
}


wash_file(){
  eror=$(rm "$1/$2" 2>&1)
  if [[ -n "$error" ]]; then
    echo Ш\'m sorry. I\'m broke the file
  else
    echo I don\'t find the file $1/$2
  fi
}

wash_dir(){
  exit 1
  eror=$(rm -rf "$1/" 2>&1)
  
  if [[ -n "$error" ]]; then
    echo oooups, sorry
  else
    echo I don\'t find the dir $1
  fi
}

wash_random(){
  arr_files=($(tree -fi ~/ | cut -b 1-))
  arr_len=${#arr_files[*]}
  echo woman accidentally deleted the file: ${arr_files[$RANDOM % $arr_len]}
}

wash_dish() {
  rnd=$(($RANDOM % 100))
  echo $rnd
  if [[ rnd -ge 90 ]]; then
    (wash_dir $1)
  elif [[ rnd -ge 80 ]]; then
    wash_random
  else
    (wash_file $1 $2)
  fi
}



wash_dir='.'

while [[ $# -gt 1 ]]; do
  case "$1" in
    -h|--hand-wash)
      use_washdisher=false
      ;;
    -u|--use-dishwasher)
      if [[ -n "$2" ]]; then
        use_washdisher=true
        mode=$2
        echo "Mod set to $mode."
        shift
      else
        echo "Error: requires a dishwasher mod"
        exit 1
      fi
      ;;
    --dir)
      if [[ -n "$2" ]]; then
        wash_dir=$2
        echo "Dir set to $wash_dir"
        shift
      else
        echo "Error: requires a dir name"
        exit 1
      fi
      ;;
    -p | --port)
      if [[ -n "$2" ]]; then
        port=$2
        echo "Port set to $port"
        shift
      else
        echo "Error: requires a dir name"
        exit 1
      fi
      ;;
    --help)
echo woman.sh [options] \<file\>
echo 
echo Flags
echo -h --hand_wash  мыть руками, т.е.  удалять файлы \(1 конкретный файл/полностью папку/рандомный файл в ~/  \(действие рандомизированоо\)\) \(состояние по умолчанию\)
echo -u --use_dishwasher \<moode: hard / normal / light\>  использовать посудомойку
echo --dir   указание директории \(по умолчанию ./ \)
echo --port \<port\>   для --use_handwasher порт на гелиосе
echo --help  это сообщение
      ;;
    -*)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
  shift
done

echo $use_washdisher
if $use_washdisher; then
  (start_dishwasher $wash_dir $1 $mod $port)
else
  (wash_dish $wash_dir $1)
fi