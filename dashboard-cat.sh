#/bin/bash

echo -ne $(cat "$1" | sed  's/$/\\n/')
