#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


cd "$SCRIPT_DIR/composite" || exit

for d in */ ; do
    echo "Updating readme for $d..."
    cd "$SCRIPT_DIR/composite/$d" || exit
    terraform-docs markdown table --output-file README.md .
    echo "Done."
done

cd "$SCRIPT_DIR/simple" || exit

for d in */ ; do
    echo "Updating readme for $d..."
    cd "$SCRIPT_DIR/simple/$d" || exit
    terraform-docs markdown table --output-file README.md .
    echo "Done."
done