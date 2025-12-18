#!/bin/bash

# --- CONFIGURATION ---
FILES_DIR="files"
TITLE_COLOR=$(tput setaf 6)
RESET_COLOR=$(tput sgr0)
POINTER="❯"
POINTER_COLOR=$(tput setaf 5)
KEYWORD_COLOR=$(tput setaf 4)
VARIABLE_COLOR=$(tput setaf 1)
STRING_COLOR=$(tput setaf 2)
COMMENT_COLOR=$(tput setaf 3)

# --- FUNCTIONS ---

function cleanup() {
    echo -e "\n\n${TITLE_COLOR}Exiting...${RESET_COLOR}"
    tput cnorm # Show cursor
    exit 0
}

function display_menu() {
    clear
    echo "${TITLE_COLOR}--- SELECT A FILE ---${RESET_COLOR}"
    echo "Use arrow keys to navigate, Enter to select, Ctrl+C to exit."
    echo

    for i in "${!files[@]}"; do
        if [ "$i" -eq "$selected" ]; then
            echo "  ${POINTER_COLOR}${POINTER} ${files[$i]}${RESET_COLOR}"
        else
            echo "    ${files[$i]}"
        fi
    done
}

function colorize_text() {
    local text="$1"
    text=$(echo "$text" | sed -E "s/\b(echo|function|array|foreach|as|if|else|true|false|new)\b/${KEYWORD_COLOR}&${RESET_COLOR}/g")
    text=$(echo "$text" | sed -E "s/(\\$[a-zA-Z_][a-zA-Z0-9_]*)/${VARIABLE_COLOR}&${RESET_COLOR}/g")
    text=$(echo "$text" | sed -E "s/(\"[^\"]*\")/${STRING_COLOR}&${RESET_COLOR}/g")
    text=$(echo "$text" | sed -E "s/(#.*|\\/\\/.*)/${COMMENT_COLOR}&${RESET_COLOR}/g")
    echo "$text"
}


# --- MAIN LOGIC ---

trap cleanup SIGINT

# Initialize menu selection variable ONCE
selected=0

# Main application loop
while true; do
    # --- FILE SELECTION MENU ---
    files=($FILES_DIR/*)
    display_menu

    while true; do
        read -rsn1 key
        case "$key" in
            $'\x1b') # Arrow keys
                read -rsn2 -t 0.1 key
                case "$key" in
                    '[A') # Up
                        [ "$selected" -gt 0 ] && selected=$((selected - 1))
                        ;;
                    '[B') # Down
                        [ "$selected" -lt $((${#files[@]} - 1)) ] && selected=$((selected + 1))
                        ;;
                esac
                display_menu
                ;;
            "" ) # Enter
                break
                ;;
        esac
    done

    # --- FAKE TYPING ---
    selected_file="${files[$selected]}"
    file_content=$(<$selected_file)
    colorized_content=$(colorize_text "$file_content")
    tput civis && clear

    i=0
    while [ "$i" -lt "${#colorized_content}" ]; do
        char="${colorized_content:$i:1}"

        if [[ "$char" == $'\x1b' ]]; then
            end_seq_pos=$(expr index "${colorized_content:i}" "m")
            if [ "$end_seq_pos" -gt 0 ]; then
                echo -n "${colorized_content:i:$end_seq_pos}"
                i=$((i + end_seq_pos))
                continue
            fi
        fi

        echo -n "$char"
        i=$((i + 1))

        read -rsn1 key_press
        if [[ "$key_press" == $'\x18' ]]; then # Ctrl+X
            echo -n "${colorized_content:i}"
            break 
        fi
    done

    # --- POST-TYPING DECISION LOOP ---
    tput cnorm
    echo
    echo -e "\n${TITLE_COLOR}Run code? (y/n) | Go Back (Ctrl+B)${RESET_COLOR}"

    while true; do
        read -rsn1 answer
        case "$answer" in
            [yY])
                echo -e "\n\n${TITLE_COLOR}--- EXECUTING ---${RESET_COLOR}"
                php -d xdebug.mode=off "$selected_file"
                echo -e "\n${TITLE_COLOR}--- DONE ---${RESET_COLOR}"
                read -rsn1 -p "Press any key to return to menu..."
                break
                ;;
            [nN])
                echo -e "\n\n${TITLE_COLOR}Not executing.${RESET_COLOR}"
                sleep 1
                break
                ;;
            $'\x02') # Ctrl+B
                break
                ;;
        esac
    done
    
    continue
done