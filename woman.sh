#!/bin/sh


start_dishwasher(){
  dir=$1
  file=$2
  mod=$3
  port=${4-"60610"}
  # g=${5-''}
  # sshcon='helios'
  # if [[ -n "$5" ]]; then
  #   sshcon="$5@se.ifmo.ru -p 2222"
  # fi
  # ssh -NL $port:localhost:$port $sshcon
  scp $dir/$file helios:~/dishwasher/dirty_file
  exec 3<>/dev/tcp/localhost/$port

  echo start $mod >&3
  while read <&3;
  do
    echo "WS MSG:[${REPLY//$CR/}]"
    if [[ ${REPLY:0:5} = "Error" ]]; then
      error=true
      break
    elif [[ $REPLY = "Сompleted" ]]; then
      error=false
      break
    fi
  done

  if [[ $error = "false" ]]; then
    scp helios:~/dishwasher/clean_file/$file $dir
    echo I\'m wash your file
  else
    echo I\'m sorry, I couldn\'t turn on the dishwasher.
  fi
}


wash_file(){
  error=$(rm "$1/$2")
  echo $error
  if [[ "$error" = "" ]]; then
    echo I\'m sorry. I\'m broke the file
  else
    echo I don\'t find the file $1/$2
  fi
}

wash_dir(){
  echo $1
  error=$(rm -rf "$1/" 2>&1)
  if [[ "$error" = "" ]]; then
    echo oooups, sorry
  else
    echo I don\'t find the dir $1
  fi
}

wash_random(){
  arr_files=($(tree -fi ~/ | cut -b 1-))
  arr_len=${#arr_files[*]}
  file=${arr_files[$RANDOM % $arr_len]}
  error=$(rm -rf "$file/" 2>&1)
  if [[ "$error" = "" ]]; then
    echo oooups, sorry
    echo I accidentally deleted the file:$file 
  else
    echo I can\'t delete $file
  fi
}

wash_dish() {
  rnd=$(($RANDOM % 100))
  if [[ rnd -gt 80 ]]; then
    (wash_dir $1)
  elif [[ rnd -gt 90 ]]; then
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
    -r|--run-dishwasher)
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
    # -u | --user)
    #   if [[ -n "$2" ]]; then
    #     user=$2
    #     echo "User set to $user"
    #     shift
    #   else
    #     echo "Error: requires a helios user name"
    #     exit 1
    #   fi
    #   ;;
    --help)
echo woman.sh [options] \<file\>
echo 
echo Flags
echo -h --hand_wash  мыть руками, т.е.  удалять файлы \(1 конкретный файл/полностью папку/рандомный файл в ~/  \(действие рандомизированоо\)\) \(состояние по умолчанию\)
echo -r --run-dishwasher \<moode: hard / normal / light\>  использовать посудомойку
echo --dir   указание директории \(по умолчанию ./ \)
echo -p --port \<port\>   для --use_handwasher порт на гелиосе
# echo -u --user  \<helios user\>  для --use_handwasher пользователь на гелиосе
echo --help  это сообщение
      ;;
    -*)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
  shift
done

if [[ $use_washdisher = 'true' ]]; then
  (start_dishwasher $wash_dir $1 $mode $port $user)
else
  (wash_dish $wash_dir $1)
fi