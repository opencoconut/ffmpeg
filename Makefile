TEMPLATE_NAME ?= fccn/ffmpeg

shell: image
	docker run -a stdin -a stdout -i -t --entrypoint=/bin/sh $(TEMPLATE_NAME)

image:
	docker build -t $(TEMPLATE_NAME) .

dist: image
	cp scripts/ffmpeg-aliases.sh /etc/profile.d/ffmpeg-aliases.sh && source /etc/profile.d/ffmpeg-aliases.sh
