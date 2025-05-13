#!/bin/bash

# Output the start.sh script
cat <<'EOF' > start.sh
#!/bin/bash

# Base64 encoded tarball begins here
tarball="PASTE_YOUR_BASE64_ENCODED_TAR_HERE"

# Decode the tarball and extract it
mkdir gallery
echo "Restoring files to the 'gallery' directory..."
echo "$tarball" | base64 --decode | tar -xz -C gallery

echo "Files have been restored inside the 'gallery' directory."

# Update package list and install dependencies
sudo apt-get update
sudo apt-get install -yq python3-pip python3-venv


# Run the flask app under a venv
cd gallery
python3 -m venv gallery_venv
source gallery_venv/bin/activate
pip install --upgrade pip
pip install -r ./requirements.txt
export FLASK_APP="main.py"
export FLASK_RUN_PORT="80"
export FLASK_RUN_HOST="0.0.0.0"
flask run
EOF

# Base64 encode the tarball
encoded_tarball=$(tar -czf - --exclude=bundle.sh --exclude=start.sh . | base64 -w 0)

# Insert the base64 encoded tarball into start.sh
sed -i "s|PASTE_YOUR_BASE64_ENCODED_TAR_HERE|$encoded_tarball|" start.sh

echo "The start.sh script has been created."