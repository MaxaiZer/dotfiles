if [ -z "$1" ]; then
  echo "No file path provided"
  exit 1
fi

CURRENT_USER=$(whoami)

if grep -q "NAME_OF_THE_USER" "$1"; then
  sed -i "s/NAME_OF_THE_USER/$CURRENT_USER/g" "$1"
  echo "File '$1' was updated."
else
  echo "No changes made to '$1'."
fi
