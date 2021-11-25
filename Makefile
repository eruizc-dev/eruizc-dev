sync:
	make sync-qmk

sync-qmk:
	ls ~/qmk_firmware/keyboards/crkbd/keymaps/eruizc-dev/ \
		| awk '{ print $0 }' \
		| xargs -I {} ln -f ~/qmk_firmware/keyboards/crkbd/keymaps/eruizc-dev/{} ~/repos/eruizc-dev/eruizc-dev/qmk_firmware/keyboards/crkbd/keymaps/eruizc-dev/{}
