#!/bin/bash


sudo apt-get update
sudo apt-get install xxd


# Create read_handles.sh
cat <<EOF > read_handles.sh
#!/bin/bash
# Replace with your MAC
MAC=08:B6:1F:88:7A:62
gatttool -b \$MAC --char-read -a \$1 | awk -F':' '{print \$2}' | tr -d ' ' | xxd -r -p; printf '\n'
EOF
chmod +x read_handles.sh

# Create submit.sh
cat <<EOF > submit.sh
#!/bin/bash
# Replace with your MAC
MAC=08:B6:1F:88:7A:62
gatttool -b \$MAC --char-write-req -a 0x002c -n \$(echo -n "\$1" | xxd -ps)
EOF
chmod +x submit.sh

# Create score.sh
cat <<EOF > score.sh
#!/bin/bash
# Replace with your MAC
MAC=08:B6:1F:88:7A:62
gatttool -b \$MAC --char-read -a 0x002a | awk -F':' '{print \$2}' | tr -d ' ' | xxd -r -p; printf '\n'
EOF
chmod +x score.sh

# Fetch bdaddr binary from GitHub
wget https://github.com/PaulGG-Code/bdaddr/releases/download/v1.0.0/bdaddr -O bdaddr
chmod +x bdaddr

echo "Scripts created and bdaddr downloaded."
