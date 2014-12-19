h=( $(openssl rand 100000 | sha1sum) ); printf "%s${r[0]:0:13}\n"
