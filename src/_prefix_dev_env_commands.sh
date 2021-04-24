# Custom commands
_prefix_load_dotenv(){
  if [ -f .env ]; then
    # Open .env, pipe to sed which ignores lines starting with "#", then execute each export
    export $(cat .env | sed 's/#.*//g' | xargs)
  fi
}

_prefix_print_colors(){
    for i in {0..255}
        do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
    done
}
