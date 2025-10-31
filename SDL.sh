#!/bin/bash


        echo "=====timestamps before listing====="
        stat -c "  Access: %x" "$1"
        stat -c "  Modify: %y" "$1"
        echo ""

stealth_ls(){
	local dir=${1:-.}
	#save original timestamps
	local original_atime=$(stat -c %X "$dir")
	local original_mtime=$(stat -c %Y "$dir")

	#perform listing dengan kontrol penuh
	ls -la "$dir"
	echo ""
	#restore original timestamps untuk avoid detection
	touch -a -d "@$original_atime" "$dir"
	touch -m -d "@$original_mtime" "$dir"

        echo "=====timestamps resets====="
   	 stat -c "  Access: %x" "$dir"
   	 stat -c "  Modify: %y" "$dir"
   	 echo ""
}

stealth_ls "$1"
